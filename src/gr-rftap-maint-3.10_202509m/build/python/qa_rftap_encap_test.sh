#!/usr/bin/sh
export VOLK_GENERIC=1
export GR_DONT_LOAD_PREFS=1
export srcdir=/home/yinlab/gr-block/gr-rftap-maint-3.10-changed/python
export GR_CONF_CONTROLPORT_ON=False
export PATH="/home/yinlab/gr-block/gr-rftap-maint-3.10-changed/build/python":"$PATH"
export LD_LIBRARY_PATH="":$LD_LIBRARY_PATH
export PYTHONPATH=/home/yinlab/gr-block/gr-rftap-maint-3.10-changed/build/test_modules:/home/yinlab/gr-block/gr-rftap-maint-3.10-changed/build/swig:$PYTHONPATH
/usr/bin/python3 /home/yinlab/gr-block/gr-rftap-maint-3.10-changed/python/qa_rftap_encap.py 
