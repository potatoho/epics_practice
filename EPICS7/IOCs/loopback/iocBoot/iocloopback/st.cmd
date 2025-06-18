#!../../bin/linux-x86_64/loopback

< envPaths
cd "${TOP}"

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/db")


# 1. DBD 로드 및 드라이버 등록
dbLoadDatabase("dbd/loopback.dbd")
loopback_registerRecordDeviceDriver(pdbbase)

# 2. 시리얼 포트 설정 (예: /dev/ttyUSB0)
drvAsynSerialPortConfigure("L0", "/dev/ttyUSB0", 0, 0, 0)

# 3. 시리얼 옵션 설정 (예: 9600 8N1, no flow control)
asynSetOption("L0", 0, "baud", "9600")
asynSetOption("L0", 0, "bits", "8")
asynSetOption("L0", 0, "parity", "none")
asynSetOption("L0", 0, "stop", "1")
asynSetOption("L0", 0, "clocal", "Y")
asynSetOption("L0", 0, "crtscts", "N")

# 4. EOS 설정 (줄바꿈 방식: \n 기준 루프백)
asynOctetSetInputEos("L0", 0, "\n")
asynOctetSetOutputEos("L0", 0, "\n")

# 5. 레코드 로드
dbLoadRecords("db/loopback.db", "PORT=L0,P=LOOPBACK:")

# 6. IOC 초기화
iocInit()
