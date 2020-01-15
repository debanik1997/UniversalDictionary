import firebase_admin
import google.cloud
from firebase_admin import credentials, firestore
import csv
import random

cred = credentials.Certificate("./universaldictionary-8a651-firebase-adminsdk-qcvgc-dc763d5acd.json")
app = firebase_admin.initialize_app(cred)

store = firestore.client()
doc_ref = store.collection(u'universaldictionary')

res = [] 

reader = csv.reader(
    open("swadesh.tsv"), delimiter="\t")

universalDict = {}

for row in reader:
	englishword = row[0]
	translation = row[2]
	code = row[1]
	if code not in universalDict:
		universalDict[code] = {}

	if englishword not in universalDict[code]:
		universalDict[code][englishword] = []

	universalDict[code][englishword].append(translation)

print(len(universalDict.keys()))
rand_sample = random.sample(universalDict.keys(), 10)
print(rand_sample)
hindi = ['hin']
for key in hindi:
	print("LANGUAGE: " + key)
	doc_ref = doc_ref.document(u'translations').collection(key)
	current_dict = universalDict[key]
	for engWord in current_dict:
		translatedString = ", ".join(str(x) for x in current_dict[engWord])
		doc_ref.add({u'englishWord': engWord, u'translation': translatedString})

