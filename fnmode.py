#!python3
"""
this module changes the value in file fnmode from 0 to 1 or vice versa. This
results into changing the mode of fn keys.

    - if value is 0 the fn keys must be activated with fn (linux mode)
    - if value is 1 the fn keys are directly accessible (mac mode)

This script can be activated externally by calling it through a pre set key
combination
"""

file = open('/sys/module/hid_apple/parameters/fnmode', 'r+')
value = file.read()
# print('value: ', value)
opposite = str(int(not int(value)))
# print('opposite: ', opposite)
file.write(opposite)
file.close()
