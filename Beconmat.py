# -*- coding: utf-8 -*-
"""
Created on Mon Jul  6 16:23:08 2020

@author: shahrear
shahrear.zaman1971@gmail.com
student.eco86@gmail.com
"""
from __future__ import division 
import numpy as np
import scipy as sp
import pandas as pd
import matplotlib.pyplot as plt
from scipy import *

import os
os.chdir('C:\\Users\shahrear\Desktop\play\GRAPH')
os.getcwd()

#test = pd.read_csv("C:/Users/shahrear/Desktop/play/GRAPH/play3.csv", index_col=0)
test = pd.read_csv("C:/Users/shahrear/Desktop/play/GRAPH/play3.csv")
test.head()

BRP = test['AusRiceProduction']
Time = test['Period']


BRP1 = np.array([BRP])
N = np.size(BRP1)
BRP0 = np.random.gamma(2500,1,100) 
Y = np.size(BRP0) 
BRP_BAR1 = np.sum(BRP1)/N
BRP_BAR0 = np.sum(BRP0)/Y

v = Y
m_star = (v /(v+N))*BRP_BAR0 + (N/(v+N))*BRP_BAR1

mu_0 = np.arange(0,1,0.1)
s2_0 = 100
v_0 = 50


s2 = (np.sum((BRP1-BRP_BAR1)**2))/(N-1)
s21_0 = ((v_0*s2_0)+np.sum((BRP1-BRP_BAR0)**2) + ((v_0*v)/(v_0+v)*(mu_0 - BRP_BAR0)**2))/(v_0+v)
mu = m_star + mu_0*((s21_0/(v+N))**(1/2))

pdf_mu = (1/((2*sp.pi*s2)/(v+N))**(1/2))*np.exp((-(mu-m_star)**2)/((2*s2)/(v+N)))

plt.plot(Time,BRP)
plt.plot(BRP0)
plt.plot(mu,pdf_mu)
plt.hist(BRP)
plt.hist(BRP0)

fig = plt.figure(figsize=(50,50), dpi=100)
fig,(ax1) = plt.subplots(1, 1, sharex=True, sharey=True)
ax1.plot(Time,BRP)
ax1.legend(['Production of the Aus Rice'])
ax1.set_xlabel('Year')
ax1.set_ylabel('Production')
ax1.grid()
plt.show() 
plt.draw()
fig.savefig('Aus1.png', format='png')
fig.savefig('Aus1.pdf')
plt.close(fig)

fig = plt.figure(figsize=(50,50), dpi=100)
fig,(ax1) = plt.subplots(1, 1, sharex=True, sharey=True)
ax1.hist(BRP)
ax1.legend(['Histogram of the Aus Rice'])
ax1.set_xlabel('Production(hypothetical)')
ax1.set_ylabel('frequency')
ax1.grid()
plt.show() 
plt.draw()
fig.savefig('Aush1.png', format='png')
fig.savefig('Aush1.pdf')
plt.close(fig)

fig,(ax2) = plt.subplots(1, 1, sharex=True, sharey=True)
ax2.plot(BRP0)
ax2.legend(['Production of the Aus Rice from previous experiences'])
ax2.set_xlabel('Year')
ax2.set_ylabel('Production(hypothetical)')
ax2.grid()
plt.show() 
plt.draw()
fig.savefig('Aus0.png', format='png')
fig.savefig('Aus0.pdf')
plt.close(fig)

fig = plt.figure(figsize=(50,50), dpi=100)
fig,(ax2) = plt.subplots(1, 1, sharex=True, sharey=True)
ax2.hist(BRP0)
ax2.legend(['Histogram of the Aus Rice'])
ax2.set_xlabel('Production')
ax2.set_ylabel('frequency')
ax2.grid()
plt.show() 
plt.draw()
fig.savefig('Aush0.png', format='png')
fig.savefig('Aush0.pdf')
plt.close(fig)


fig = plt.figure(figsize=(50,50), dpi=100)
fig,(ax1) = plt.subplots(1, 1, sharex=True, sharey=True)
ax1.plot(mu,pdf_mu)
ax1.legend(['Pdf of the mean of the Aus Rice production'])
ax1.set_xlabel('mean')
ax1.set_ylabel('probability')
ax1.grid()
plt.show() 
plt.draw()
fig.savefig('Auspdf.png', format='png')
fig.savefig('Auspdf.pdf')
plt.close(fig)





