import getpass
import sys
import telnetlib


tn = telnetlib.Telnet("192.168.1.3",8102)

tn.write("PF\n\r")

tn.close()

