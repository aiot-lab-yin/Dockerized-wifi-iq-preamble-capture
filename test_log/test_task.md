
# ✅ Wi-Fi IQ Capture System 基础功能测试任务书

本任务用于测试并验证 USRP B210 + Docker + GNU Radio 的 Wi-Fi IQ 采集系统是否可用。适合首次接手者进行硬件、容器、信号接收和数据保存的完整流程测试。

---

## 👤 测试者信息（请填写）

- 姓名：Jinxiao Zhu
- 日期：2025/7/18
- 测试主机品牌 / 型号（如：Intel NUC 11, Jetson, 工控机等）： (Processor) 13th Gen Intel® Core™ i7-13700H × 20; (Hardware Model) Micro Computer _HK_ Tech Limited Venus Series
- 操作系统版本（如 Ubuntu 20.04）：Ubuntu 22.04.5 LTS
- USRP 型号（如 B210, B200mini）：B210
- 是否为 USB3.0 连接：✔ 
- 备注（如热插拔失败、容器异常等）：

---

## 📦 准备步骤（压缩包版）

1. 解压你收到的 zip 包（如：`wifi-iq-capture.zip`）：
   ```bash
   unzip wifi-iq-capture.zip
   cd wifi-iq-capture
   ```

2. **无需使用 git！**

3. 执行以下命令开始自动启动环境：
   ```bash
   ./start_capture.sh
   ```

---

## ✅ 测试任务表格（请执行后打勾 ✔ 或填 ✘）

### 📋 前置检查

| 检查项 | 命令或操作 | 是否完成（✔/✘） | 备注 |
|--------|------------|----------------|------|
| 安装 Docker | `docker -v` | ✔ |  Docker version 28.3.2, build 578ccf6 |
| 安装 Docker Compose | `docker-compose -v` | ✔ | Run `docker compose version` command --> output is "Docker Compose version v2.38.2". Docker Compose was installed together with Docker. |
| 插入 USRP B210 到 USB3.0 口 | `lsusb | grep Ettus` | ✔ | No output currently. |
| 配置 USB 权限 | `sudo cp udev/90-usrp.rules /etc/udev/rules.d/` 等 | ✔ |  |
| 重启 udev 服务 | `sudo udevadm control --reload-rules && sudo udevadm trigger` | ✔ |  |

---

### 🚀 启动容器并采集数据

| 测试项 | 命令或描述 | 是否成功（✔/✘） | 备注 |
|--------|-------------|----------------|------|
| 运行 `./start_capture.sh` 是否成功 | |  ✔| `docker compose up` need to be executed first before the `./start_capture.sh` command. It took about 3 minutes to end up with the message "Attaching to wifi-capture" --> ctrl + c  |
| 容器中 `uhd_usrp_probe` 显示设备 | |  ✔| |
| `check_usrp_permission.py` 检查通过 | |  ✘ -> ✔ | Exit the container of the docker with `exit`, then run  `python3 check_usrp_permission.py` --> Outupt: ✅ USRP is connected and accessible. |
| 运行 `iq_capture.py` 采集成功 | We need to go to the container again now by running `./start_capture.sh` | ✘ -> ✔ |Output: ModuleNotFoundError: No module named 'uhd' | 
| 生成 `iq_capture.csv`，大小非零 | | ✔ | file size is 509872673 Bytes |

---

### 📂 文件输出检查

| 项目 | 检查内容 | 是否正常 | 备注 |
|------|----------|----------|------|
| 输出 CSV 是否存在 | `./data/iq_capture.csv` | ✔ | |
| 文件格式是否正常 | 用 `head`、`pandas` 或 Excel 查看 | ✔  | a line has data like "-1.422162167727947235e-02,-9.857475757598876953e-03"  |
| IQ 样本是否合理 | 是否为浮点格式，是否无乱码 | ✔ | |

---

## ✅ 整体验收结论

- 是否已完成所有测试项： ✔
- 是否有失败项目，具体原因：
- 是否建议提交 issue 或修复项：
 Please check the note with mark ✘ -> ✔  and also tell user to install docker first before execute `./start_capture.sh`  in README.md.
---

## 📎 提交内容

1. 此 Markdown 文件填写完成（打勾 ✔ 和备注）
2. 终端截图（USB 检测、采集过程、CSV 文件）
3. 输出样本文件（如 `iq_capture.csv` 前几 MB 或压缩后） -->  head -n 1000 iq_capture.csv > iq_capture1000.csv
4. 如发现问题，请记录 terminal 报错或现象

---

📝 若有任何问题，请联系项目开发者 Yin Chen
