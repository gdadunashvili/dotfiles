#!/usr/bin/env python
"""
moonphase.py - Calculate Lunar Phase
Author: Sean B. Palmer, inamidst.com
Cf. http://en.wikipedia.org/wiki/Lunar_phase#Lunar_phase_calculation
"""

import math, decimal, datetime
dec = decimal.Decimal

# print(dec(1), dec(12.12))
# print(now-datetime.datetime(2001,1,1))
def position(now=None):
   if now is None:
      now = datetime.datetime.now()

   diff = now - datetime.datetime(2001, 1, 1)
   days = dec(diff.days) + (dec(diff.seconds) / dec(86400))
   lunations = dec("0.20439731") + (days * dec("0.03386319269"))

   return lunations % dec(1)
#
def phase(pos):
   index = (pos * dec(8)) + dec("0.5")
   index = math.floor(index)
   return (int(index) & 7) + 1

def main():
   print(phase(position()))
   # print(8)
#     pos = position()
#     phase_name = phase(pos)[0]
#     phas_symbol = phase(pos)[1]
#
#     roundedpos = round(float(pos), 3)
#     print("%s (%s)" % (phase_name, phase_symbol))
#
#
if __name__=="__main__":
    main()
