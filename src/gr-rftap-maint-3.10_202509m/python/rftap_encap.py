#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2016 Jonathan Brucker <jonathan.brucke@gmail.com>
#
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this software; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
#

import array
import struct
import numpy
import math
import cmath
import pmt
import csv
import os
import numpy as np
from gnuradio import gr

class rftap_encap(gr.basic_block):
    """
    add a rftap header to PDUs, see https://rftap.github.io/
    """

    PMT_IN = pmt.intern('in')
    PMT_OUT = pmt.intern('out')

    def __init__(self, encapsulation_from, custom_dlt, custom_dissector_name, mac_address_target):
        gr.basic_block.__init__(self,
            name="rftap_encap",
            in_sig=[],
            out_sig=[])

        self.encapsulation_from = encapsulation_from
        self.custom_dlt = custom_dlt
        self.custom_dissector_name = custom_dissector_name
        self.mac_address_target = mac_address_target
        
        print(type(mac_address_target))
        print(mac_address_target)
        
        
        self.message_port_register_in(self.PMT_IN)
        self.set_msg_handler(self.PMT_IN, self.handle_msg)

        self.message_port_register_out(self.PMT_OUT)
        
    def average_product_of_conjugates(self, complex_numbers):
        #print("average_product",complex_numbers)
        
        
        cor_len = []
        freq_len= []
        for start_index in range(32+32):
        
            total_delay = 0
            total_mag = 0
            count_delay = 0
            count_mag = 0
            f = lambda complex_signal : np.real(complex_signal)**2 + np.imag(complex_signal)**2 # calculate the power of the complex signal
            
            for i in range(start_index, start_index + 48): # Calculate delay
                total_delay += complex_numbers[i].conjugate() * complex_numbers[i + 16]
                count_delay += 1
                
            for j in range(start_index, start_index + 64): # Calculate magnitude
                total_mag += f(complex_numbers[j])
                count_mag += 1

            if count_delay == 0 or count_mag == 0:
                return None  # Avoid division by zero

            average_delay = total_delay / (count_delay)
            average_mag = total_mag / count_mag
            #f = lambda x: max(x.real,x.imag) + 0.25*min(x.real,x.imag)
            
            cor = np.sqrt(f(average_delay)) / average_mag
            cor_len.append(cor)
            #d_freq_offset = cmath.phase(average) / 16
            #d_freq_offset = abs(average) / 16
            d_freq_offset = math.atan2(average_delay.imag, average_delay.real) / 16
            freq_len.append(d_freq_offset)
            
        average_offset = sum(freq_len)/len(freq_len)
        re = average_offset*20000000/(2*math.pi)
        
        #print('freq_complex',average_delay)
        #print("cor_len",cor_len)
        #print("freq_len",freq_len)
        return re
        #return freq_len[0]

    def handle_msg(self, pdu):
        if not pmt.is_pair(pdu):
            print("rftap_encap: error: received invalid message type (not pair)", pdu)
            return

        d = pmt.to_python(pmt.car(pdu))  # metadata (dict)
        #print('d:')
        #print(d)
        #print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
        vec = pmt.to_python(pmt.cdr(pdu))  # data (u8 vector (numpy))

        if not d: d = {}  # fix for pmt.to_python(pmt.to_pmt({})) returning None...

        if not isinstance(d, dict):
            print("rftap_encap: error: unexpected metadata type (not dict)", pdu, repr(d))
            return

        if not isinstance(vec, numpy.ndarray) or not vec.dtype==numpy.dtype('uint8'):
            print("rftap_encap: error: unexpected PDU data type (not ndarray uint8)", pdu, repr(vec))
            return
        vec = vec.tostring()# aka tobytes() (numpy1.9+)
        #TODO
        #add1 = d.get('address 1')
        #add2 = d.get('address 2')
        #add3 = d.get('address 3')
        #freq = d.get('frequency offset')
        preamble = d.get('preamble')
        short_freq = d.get('short_freq')
        long_freq = d.get('long_freq')
        mac_address = d.get('address 2')
        freq = d.get('frequency offset')
        #print(self.mac_address_target == mac_address)
        if preamble[0] == 0.+1.j:
            return
        elif self.mac_address_target != '' and mac_address != self.mac_address_target:
            return
        elif mac_address == None:
            return
        elif short_freq == 0:
            return
        #TEST preamble[0:96]->preamble[96:192]
        freq_bench = self.average_product_of_conjugates(preamble[0:96+32])
       
        filename = "/data/"+mac_address+"_pre.csv"
        mac_address_filename =  "/data/mac_address.csv"
            
        data_to_write = [mac_address, freq, preamble, freq_bench,short_freq, long_freq]

        
        #print(mac_address,freq,freq_bench,short_freq)
        #print(preamble[:96])
        k = 0
        #print(mac_address,freq,short_freq)
        rows=[]
        mac_found = False
        # 查找需要修改的MAC地址
        mac_to_modify = self.mac_address_target  # 替换为你要修改的MAC地址
        with open(mac_address_filename,'r') as mac_file:
            mac_reader = csv.reader(mac_file)
            for row in mac_reader:
                #print(row[0]+mac_to_modify)
                if row[0] == mac_address:
                    current_count = int(row[1])
                    mac_found = True
                    if current_count < 1000:
                        print(mac_address,freq,short_freq)
                        new_count = current_count + 1
                        row[1] = str(new_count)
                        # 检查文件是否存在
                        if not os.path.exists(filename):
                            with open(filename, 'w', newline='') as csvfile:
                                csv_writer = csv.writer(csvfile)
                                # 写入标题行
                                csv_writer.writerow(['MAC_address', 'frequency offset', 'preamble', 'freq_bench', 'short_freq', 'long_freq'])
                                csv_writer.writerow(data_to_write)
                                print("初始化数据已写入output.csv文件中!")
                                print(mac_address +': 1')
                        else:
                            with open(filename, 'a', newline='') as csvfile:
                                csv_writer = csv.writer(csvfile)
                                csv_writer.writerow(data_to_write)
                                print(mac_address +': ' +str(new_count))
                                #print(f"MAC地址 {mac_to_modify} 的 count 已更新为 {new_count} 并保存到 {file_path}")
                    else:
                        print(f"MAC地址 {mac_to_modify} 的 count 为 {current_count}，已达到或超过1000，跳过修改。")
                rows.append(row)
        if mac_found:
            with open(mac_address_filename, 'w', newline='') as file:
                writer = csv.writer(file)
                writer.writerows(rows)  # 保存修改后的数据

                
        
        
        #TODO end
        flags = 0

        # To create and initialize a byte array for the RFTap header. 
        b = array.array('B') # Creates a new array of bytes ('B' stands for unsigned char in the array module)
        hdr = struct.pack('<4sHH', b'RFta', 0, 0)  # len, flags written below 
        b.frombytes(hdr)

        # this should be done in order of the bitfield:

        # dlt from PDU
        if self.encapsulation_from == 0:
            if 'dlt' not in d:
                print("[ERROR] dlt is expected in PDU, but it is missing")
            else:
                val = d.get('dlt')
                if not isinstance(val, int):
                    print("[ERROR] dlt in PDU is not an integer:", repr(val))
                else:
                    b.frombytes(struct.pack('<I', val))
                    flags |= 1
        # custom dlt
        elif self.encapsulation_from == 2:
            val = self.custom_dlt
            if not isinstance(val, int):
                print("[ERROR] custom dlt is not an integer:", repr(val))
            else:
                b.frombytes(struct.pack('<I', val))
                flags |= 1

        if 'freq' in d:
            val = d.get('freq')
            if not isinstance(val, (float,int)):
                print("[ERROR] freq is not a number:", repr(val))
            else:
                b.frombytes(struct.pack('<d', val))
                flags |= (1<<1)

        if 'nominal frequency' in d:
            val = d.get('nominal frequency')
            if not isinstance(val, (float,int)):
                print("[ERROR] nominal frequency is not a number:", repr(val))
            else:
                b.frombytes(struct.pack('<d', val))
                flags |= (1<<2)

        if 'frequency offset' in d:
            val = d.get('frequency offset')
            if not isinstance(val, (float,int)):
                print("[ERROR] frequency offset is not a number:", repr(val))
            else:
                b.frombytes(struct.pack('<d', val))
                flags |= (1<<3)

        if 'power' in d:
            val = d.get('power')
            if not isinstance(val, (float,int)):
                print("[ERROR] power is not a number:", repr(val))
            else:
                b.frombytes(struct.pack('<f', val))
                flags |= (1<<5)

        if 'noise' in d:
            val = d.get('noise')
            if not isinstance(val, (float,int)):
                print("[ERROR] noise is not a number:", repr(val))
            else:
                b.frombytes(struct.pack('<f', val))
                flags |= (1<<6)

        if 'snr' in d:
            val = d.get('snr')
            if not isinstance(val, (float,int)):
                print("[ERROR] snr is not a number:", repr(val))
            else:
                b.frombytes(struct.pack('<f', val))
                flags |= (1<<7)

        if 'qual' in d:
            val = d.get('qual')
            if not isinstance(val, (float,int)):
                print("[ERROR] qual is not a number:", repr(val))
            else:
                b.frombytes(struct.pack('<f', val))
                flags |= (1<<8)

        # tagged parameters:

        # dissector name from PDU
        if self.encapsulation_from == 1:
            if 'dissector' not in d:
                print("[ERROR] dissector name is expected in PDU, but it is missing")
            else:
                val = d.get('dissector')
                if not isinstance(val, str):
                    print("[ERROR] dissector name in PDU is not a string:", repr(val))
                else:
                    val = val.encode()
                    b.frombytes(struct.pack('<HBB', 16, len(val), 255))
                    b.frombytes(val)
                    padlen = 3 - ((len(val)+3)&3)
                    b.frombytes(b'\0'*padlen)
        # custom dissector name
        elif self.encapsulation_from == 3:
            val = self.custom_dissector_name
            if not isinstance(val, str):
                print("[ERROR] custom dissector name is not a string:", repr(val))
            else:
                val = val.encode()
                b.frombytes(struct.pack('<HBB', 16, len(val), 255))
                b.frombytes(val)
                padlen = 3 - ((len(val)+3)&3)
                b.frombytes(b'\0'*padlen)

        if len(b) % 4 != 0:
            print("[ERROR] wrong padding!!!")

        struct.pack_into('<H', b, 4, len(b)//4)
        struct.pack_into('<H', b, 6, flags)

        b.frombytes(vec)

        pmt_v = pmt.init_u8vector(len(b), b)
        outpdu = pmt.cons(pmt.car(pdu), pmt_v)
        self.message_port_pub(self.PMT_OUT, outpdu)
