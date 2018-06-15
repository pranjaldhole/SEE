import zmq, json, simplejson, re, time, os, sys
import numpy as np
from pprint import pprint

savename = (sys.argv[1])

y = np.array([np.zeros(150)])
directory=os.popen("find ./  -printf \"%f\n\"| grep recording")
for filename in directory.readlines():
    print("Processing "+filename)
    #time.sleep(3)

    file = ""+filename+""
    f = os.popen("cat "+filename+"")
    x = np.array([])
    for i in f.readlines():
        if '.' in i:
            #print i
            i = re.sub(',', '', i)
            #i = np.array
            i = round(float(i),2)
            #print i
            x = np.append(x, i)
        else:
            pass
    y = np.vstack([y,x])

y = np.delete(y,(0),axis=0)


x_list = np.array([])
y_list = np.array([])
t_list = np.array([])

for i in range(0,150):
    if i % 3 ==0:
        x_list = np.append(x_list,i)
        y_list = np.append(y_list,i+1)
        t_list = np.append(t_list,i+2)
    i +=1

xmeans =[]
ymeans =[]
tmeans =[]


for j in range(0,y.shape[0]):
    z = y[j,:]
    xtotal = 0
    ytotal = 0
    ttotal = 0

    xmean = 0
    ymean = 0
    tmean = 0
    for i in range(0,50):
        xtotal += z[int(x_list[i])]
        ytotal += z[int(y_list[i])]
        ttotal += z[int(t_list[i])]

    xmean = xtotal / 50
    ymean = ytotal / 50
    tmean = ttotal / 50

    xmeans = np.append(xmeans, xmean)
    ymeans = np.append(ymeans, ymean)
    tmeans = np.append(tmeans, tmean)


all_means = np.vstack([xmeans,ymeans])
all_means =  np.vstack([all_means,tmeans])

#print(all_means)
np.savetxt(savename+".csv", all_means, delimiter=";", fmt='%f')
