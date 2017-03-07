#!/usr/bin/env python
from __future__ import absolute_import, division, print_function
import netmiko
import sys
#
# supply six arguments to back up an ios config
#   ip
#   username
#   password
#   delay factor (start at one and go up - some devices take a long time to save and may need this set to 40 for example)
#   image destination, e.g. flash:
#   image name, e.g. cat3k_caa-universalk9ldpe.SPA.03.06.06.E.152-2.E6.bin
#
connection = netmiko.ConnectHandler(ip=sys.argv[1], device_type='cisco_ios', username=sys.argv[2], password=sys.argv[3], global_delay_factor=int(sys.argv[4]))
print(connection.send_command('software install file ' + sys.argv[5] + sys.argv[6] + ' verbose on-reboot\r\n'))
connection.disconnect()

