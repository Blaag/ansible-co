#!/usr/bin/env python
from __future__ import absolute_import, division, print_function
import netmiko
import sys
#
# supply five arguments to back up an ios config
#   ip
#   username
#   password
#   delay factor (start at one and go up - some devices take a long time to save and may need this set to 40)
#   location of software, e.g. tftp://1.1.1.1/blah.tar
#
connection = netmiko.ConnectHandler(ip=sys.argv[1], device_type='cisco_ios', username=sys.argv[2], password=sys.argv[3], global_delay_factor=int(sys.argv[4]))

output = connection.send_command('archive download-sw /imageonly ' + sys.argv[5] + '\r\n')

print(output)

connection.disconnect()

#if output.count('Incomplete') > 0 :
#  exit(0)
#else :
#  exit(1)
