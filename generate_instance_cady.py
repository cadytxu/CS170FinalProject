#generate_instance.py
import random
import sys


def generate():
    # login = input('Enter the next login or . if done: ').strip().split()

    f = open('UNBREAKABLE2.in', 'w')
    f.write('500\n')
    children = random.sample(list(range(500)),  200) 
    for child in children: 
    	f.write(str(child) + ' ')
    f.write('\n')
    for i in range(500): 
    	for j in range(500):
    		if i == j: 
    			f.write('0 ')
    		else: 
    			f.write(str(random.sample([0,1], 1)[0])+ ' ')
    	f.write('\n')
    return True

generate()
print('Generating the instance')