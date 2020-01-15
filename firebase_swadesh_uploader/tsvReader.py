import csv
import json

res = [] 

reader = csv.reader(
    open("swadesh.tsv"), delimiter="\t")

universalDict = {}

for row in reader:
	englishword = row[0]
	translation = row[2]
	code = row[1]
	if code not in universalDict:
		# print(code)
		universalDict[code] = {}

	if englishword not in universalDict[code]:
		universalDict[code][englishword] = []

	universalDict[code][englishword].append(translation)

print(universalDict['tjg']['suck'])
# with open('swadesh.json', 'w') as json_file:
#     json.dump(universalDict, json_file)
