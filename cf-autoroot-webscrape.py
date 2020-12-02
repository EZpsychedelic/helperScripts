#Short program to get all the chain fire autoroot packages.

from requests_html import HTMLSession
import subprocess
from bs4 import BeautifulSoup

session = HTMLSessio()
page = session.get('https://autoroot.chainfire.eu')
	
# Finds all the links using 'a href' tags
links = page.html.links

# Make those into a list
links = list(links)

# List comprehension that appends the '?retrieve_file=1' to our items in links
newLinks = [link.replace(link, link + '?retrieve_file=1') for link in links]

# Opens a text document for a simple log that we can use later if we need it and iterates through our list of appended links and calls 'wget' on each one. 
with open('links.txt', 'w') as file:
	for l in newLinks:
		subprocess.run(["wget", l])
		file.write('%s\n' % l)
    
 # Get all the MD5 values with package name into a dictionary for further parsing.
soup = BeautifulSoup(page.content, 'lxml')

#Get a dict of download URLs as key and md5 as value
#Return a list
sums = [row.findAll('td') for row in soup.findAll('tr')]
#First two elements in list were empty. Remove them
n = 2
del sums[:n]

#Create an empty dict, pop the needed values, and add them into the dict with update().
dict = {}
for s in sums:
    key = s.pop(9).find('a').get('href') #finds the nested link tags in the tables and gets just the url using get('href')
    val = s.pop(9).get_text() #get_text() remove html tags
    dict.update( {key : val} )
