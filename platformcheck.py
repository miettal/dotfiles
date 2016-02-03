# coding:utf-8
#
# platformcheck.py
#
# Author:   Hiromasa Ihara (miettal)
# URL:      http://miettal.com
# License:  MIT License
# Created:  2016-02-02
#

import sys
import platform

uname = platform.uname()
if uname[0] == 'Darwin' :
  print 'mac'
elif uname[0] == 'Linux' :
  if uname[1] == 'ubuntu' :
    print 'ubuntu'
  elif uname[1] == 'debian' :
    print 'debian'
  else :
    sys.exit(1)
elif uname[0] == 'cygwin' :
  print 'cygwin'
else :
  sys.exit(1)

