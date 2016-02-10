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

system = platform.system()
if system == 'Darwin' :
  print 'mac'
elif system == 'Linux' :
  dist = platform.linux_distribution()
  if dist[0] == 'Ubuntu' :
    print 'ubuntu'
  elif dist[0] == 'debian' :
    print 'debian'
  else :
    sys.exit(1)
elif system == 'cygwin' :
  print 'cygwin'
else :
  sys.exit(1)

