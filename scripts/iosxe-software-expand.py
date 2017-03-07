#!/usr/bin/env python
from __future__ import absolute_import, division, print_function
import netmiko
import sys
#
# supply five arguments to convert an iosxe device from bundle to istall mode
#   ip
#   username
#   password
#   delay factor (start at one and go up - some devices take a long time to save and may need this set to 40)
#   destination filesystem, e.g. flash:
#
connection = netmiko.ConnectHandler(ip=sys.argv[1], device_type='cisco_ios', username=sys.argv[2], password=sys.argv[3], global_delay_factor=int(sys.argv[4]))
print(connection.send_command('software expand running to ' + sys.argv[5] + ' verbose\r\n'))
connection.disconnect()

