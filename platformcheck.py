import sys
import platform

import distro

system = platform.system()
if system == 'Darwin' :
  print('mac')
elif system == 'Linux' :
  dist = distro.linux_distribution()
  if dist[0] == 'Ubuntu' :
    print('ubuntu')
  elif dist[0] == 'debian' :
    print('debian')
  else :
    sys.exit(1)
elif system == 'cygwin' :
  print('cygwin')
else :
  sys.exit(1)

