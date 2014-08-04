#!/bin/sh
         echo "  *******  1 minute Load";
               snmpwalk -v2c -c public localhost  .1.3.6.1.4.1.2021.10.1.3.1
         echo "  *******  5 minute Load";
               snmpwalk -v2c -c public localhost  .1.3.6.1.4.1.2021.10.1.3.2
         echo "  *******  15 minute Load";
               snmpwalk -v2c -c public localhost  .1.3.6.1.4.1.2021.10.1.3.3
         echo "  *******  percentage of user CPU time";
               snmpwalk -v2c -c public localhost  .1.3.6.1.4.1.2021.11.9.0
         echo "  *******  raw user cpu time";
               snmpwalk -v2c -c public localhost  .1.3.6.1.4.1.2021.11.50.0
         echo "  *******  percentages of system CPU time";
               snmpwalk -v2c -c public localhost  .1.3.6.1.4.1.2021.11.10.0
         echo "  *******  raw system cpu time";
               snmpwalk -v2c -c public localhost  .1.3.6.1.4.1.2021.11.52.0
         echo "  *******  percentages of idle CPU time";
               snmpwalk -v2c -c public localhost  .1.3.6.1.4.1.2021.11.11.0
         echo "  *******  raw idle cpu time";
               snmpwalk -v2c -c public localhost  .1.3.6.1.4.1.2021.11.53.0
         echo "  *******  raw nice cpu time";
               snmpwalk -v2c -c public localhost  .1.3.6.1.4.1.2021.11.51.0
