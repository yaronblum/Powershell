# function getNetAdapter ($AdapterName) {
#     $AdapterState = Get-NetAdapter -Name $AdapterName
    
# }

# if (getNetAdapter.$AdapterState.status = 'true')

# $Disk = Get-WmiObject win32_logicaldisk 
# Foreach ($Drive in $Disk) {Switch ($Drive.DriveType) {
# 1{ $Drive.DeviceID + " Unknown" } 
# 2{ $Drive.DeviceID + " Floppy or Removable Drive" } 
# 3{ $Drive.DeviceID + " Hard Drive" } 
# 4{ $Drive.DeviceID + " Network Drive" } 
# 5{ $Drive.DeviceID + " CD" } 
# 6{ $Drive.DeviceID + " RAM Disk" } 
#     }
# }

$networkAdapters = Get-NetAdapter
foreach ($adapter in $networkAdapters) {Switch ($adapter.state) {
    0{             "disconnected" }
    1{                "connected" }
    2{            "disconnecting" }
    3{                "connected" }
    4{     "hardware not present" }
    5{        "hardware disabled" }
    6{     "hardware malfunction" }
    7{       "media disconnected" }
    8{           "authenticating" }
    9{ "authenticating successed" }
    10{   "authenticating failed" }
    11{         "invalid address" }
    12{    "credentials required" }
    }
}


$wifiConnection = Get-NetAdapter -Name "wireless network connection"
