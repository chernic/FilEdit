# coding: utf-8

import csv

csvfile = file('csv_test.csv', 'rb')
reader = csv.reader(csvfile)

for line in reader:
    print line

with open('csv_test.csv', 'rb') as f:
    reader = csv.reader(f, delimiter=',', quoting=csv.QUOTE_NONE)
    for row in reader:
        print row
	
	
	
csvfile.close() 