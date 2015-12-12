import numpy as np

def get_hex_num(index) :
    hex_num = 0
    flag = 0
    if (index == 0) :
        hex_num = 0
    else :
        hex_num = 1
        while (flag == 0) :
            if(index > 3*hex_num*(hex_num+1)) :
                hex_num = hex_num + 1
            else :
                flag = 1
    return hex_num

def global_index(k1, k2) :
    # Takes the coordinates (k1,k2) on the (r1,r2) basis and 
    # returns global index of that mesh point.

    # ! We compute the hexagon-ring number
    if (k1*k2 >= 0) :
        hex_num = max( abs(k1), abs(k2))
    else :
        hex_num = abs(k1) + abs(k2)

    # ! We get the index of the first point in this ring
    first_index = 1 + 3*(hex_num - 1)*hex_num

    if ((k1 == 0)and(k2 == 0)) :
       # ! Origin :
       val = 0
    elif (k1 == hex_num) :
       # ! First edge of hexagone
       val = first_index + k2
    elif (k2 == hex_num) :
       # ! Second edge of hexagone
       val = first_index + 2*hex_num - k1
    elif (( k1 < 0) and (k2 > 0)) :
       # ! Third edge of hexagone
       val = first_index + 3*hex_num - k2
    elif (k1 == -hex_num) :
       # ! Forth edge of hexagone
       val = first_index + 3*hex_num + abs(k2)
    elif (k2 == -hex_num) :
       # ! Fifth edge of hexagone
       val = first_index + 5*hex_num - abs(k1)
    elif (( k1 > 0) and (k2 < 0)) :
       # ! Sixth edge of hexagone
       val = first_index + 6*hex_num - abs(k2)
    else  :
        val = -1

    return val




def hexmesh(nhex) :
    r1x1 = 0.5*np.sqrt(3.)/nhex
    r1x2 = 0.5/nhex
    r2x1 = -0.5*np.sqrt(3.)/nhex
    r2x2 = 0.5/nhex
    prod = nhex*(nhex+1)
    ntot = 6*prod/2+1
    xcoo = np.zeros((ntot))
    ycoo = np.zeros((ntot))
    print "TOTAL POINTS = ", ntot
    for k1 in range(-nhex,nhex+1) :
        for k2 in range(-nhex,nhex+1) :
            index = global_index(k1,k2)
            if (index == 0) :
                xcoo[index] = 0.
                ycoo[index] = 0.
            elif ((index > 0) and (get_hex_num(index) <= nhex)):
                xcoo[index] = r1x1*k1 + r2x1*k2
                ycoo[index] = r1x2*k1 + r2x2*k2
    return xcoo, ycoo


def hextocirc(xcoo, ycoo) :
    ntot = np.size(xcoo)
    xnew = np.zeros_like(xcoo)
    ynew = np.zeros_like(ycoo)
    for i in range(1,ntot) :
        a = np.sqrt( ycoo[i]**2 + xcoo[i]**2 )
        hex_num = get_hex_num(i)
        first = 1 + 3*(hex_num - 1)*hex_num
        xc = xcoo[first]
        yc = ycoo[first]
        b = np.sqrt(xc**2 + yc**2)
        xnew[i] = xcoo[i]*b/a
        ynew[i] = ycoo[i]*b/a
    return xnew, ynew



def hextocirc2(xcoo, ycoo) :
    ntot = np.size(xcoo)
    xnew = np.zeros_like(xcoo)
    ynew = np.zeros_like(ycoo)
    for i in range(ntot) :
        x = xcoo[i]
        y = ycoo[i]
        a = np.sqrt( y**2 + x**2 )
        if ((x == 0.) or (abs(y)/abs(x) > 1./np.sqrt(3.))) :
            b = abs(y) + 1./np.sqrt(3.)*abs(x)
        else :
            b = 2.*np.sqrt(3.)/3.*abs(x)
        if (a > 0) :
            xnew[i] = xcoo[i]*b/a
            ynew[i] = ycoo[i]*b/a
        else :
            xnew[i] = 0.
            ynew[i] = 0.
    return xnew, ynew


nhex = 4
xcoo, ycoo = hexmesh(nhex)
xnew, ynew = hextocirc2(xcoo, ycoo)

import matplotlib.pyplot as plt
import pylab as py

py.scatter(xcoo, ycoo, color="blue")
# py.plot(xcoo, ycoo, 'blue')
# py.plot(xnew, ynew, 'green')
py.scatter(xnew, ynew, color="green")

fig = py.gcf()

for m in range(nhex+1) :
    l = []
    a = 1 + 3*(m - 1)*m
    b = 3*(m + 1)*m + 1
    for i in range(a,b):
        l.append(i)
    l.append(a)
    py.plot(xcoo[l], ycoo[l], 'blue')
    radius = np.sqrt(xnew[l]**2 + ynew[l]**2)
    circle=py.Circle((0.,0.), radius[0], fill=False, color="green", linestyle="dashed")
    fig.gca().add_artist(circle)
    # py.plot(np.cos(xnew[l]), np.sin(ynew[l]), 'green')

for i in range(np.size(xcoo[l])):
    print xcoo[l][i]*2., ycoo[l][i]*2.
# step = 1./nhex
# for r in np.linspace(step, step*nhex, nhex):
#     py.gca().add_patch(py.Circle((0,0), radius=r, 
#                                  fill=False, color='green'))


py.show(block=True)

# py.scatter(xnew, ynew)
# py.plot(xcoo, ycoo, 'blue')
# py.show(block=True)
