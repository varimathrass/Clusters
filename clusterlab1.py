#!/usr/bin/env python
# coding: utf-8

# In[93]:


import numpy as np
import math
import scipy.spatial


# In[94]:


cut = "%.2f"


# In[95]:


def get_random_vector(lenght):
    return np.random.randint(-30, 31, lenght)


# In[96]:


def get_random_array(rows, cols):
    return [get_random_vector(cols) for row in range(rows)]


# In[97]:


def euclidean(x, y):
    return scipy.spatial.distance.euclidean(x, y)


# In[98]:


def minkowsky(x, y, p):
    return scipy.spatial.distance.minkowski(x,y,p)


# In[99]:


def mahalanobis(x, y, W):
    return scipy.spatial.distance.mahalanobis(x, y, W)


# In[100]:


def pearson(x, y):
    return scipy.spatial.distance.correlation(x, y)


# In[101]:


def hamming(x, y):
    return scipy.spatial.distance.hamming(x, y)


# In[102]:


c = [12, -6, -8, 17, 18]
f = [13, 6, -7, 5, 19]
t = [1, 16, 10, 10, 17]
s = [2, -17, 12, 3, -20]
d = [c, f, t, s]
W = [
        [1,0,0,0,0],
        [0,1,0,0,0],
        [0,0,1,0,0],
        [0,0,0,1,0],
        [0,0,0,0,1],
    ]

print(euclidean(c, f))
print(minkowsky(c, f, 2.0))
print(mahalanobis(c, f, W))
print(pearson(c, f))
print(hamming(c, f))


# In[103]:


def get_distance(array, method):

    result = []
    
    for i in range(len(array)):
        result.append([])
        for j in range(len(array)):
            result[i].append(0)
            if method == 1:
                result[i][j] = euclidean(array[i], array[j])
            if method == 2:
                result[i][j] = minkowsky(array[i], array[j], 2)
            if method == 3:
                vectorW = [
                    [1, 0, 0, 0, 0],
                    [0, 1, 0, 0, 0],
                    [0, 0, 1, 0, 0],
                    [0, 0, 0, 1, 0],
                    [0, 0, 0, 0, 1],
                ]
                result[i][j] = mahalanobis(array[i], array[j], vectorW)
            if method == 4:
                result[i][j] = pearson(array[i], array[j])
            if method == 5:
                result[i][j] = hamming(array[i], array[j])
    
    return result


# In[104]:



get_distance(d, "s")


# In[105]:


import plotly.plotly as py
import plotly.graph_objs as go
import plotly.offline as plo


# In[106]:


def draw_dots(vectorX, vectorY):
    trace = go.Scatter(
        x = vectorX,
        y = vectorY,
        name = 'task3',
        mode = 'markers',
        marker = dict(
            size = 10,
            color = 'rgba(244, 65, 178.8)',
            line = dict(
                width = 2,
                color = 'rgb(0, 0, 0)'
            )
        )
    )

    data = [trace]

    layout = dict(title = 'Styled Scatter',
            yaxis = dict(zeroline = False),
            xaxis = dict(zeroline = False)
        )

    plo.init_notebook_mode(connected=True)
    plo.iplot({
        "data": [trace],
        "layout": go.Layout(title="Task #3")
    })


# In[107]:


def get_vector(array, col):
    return [array[i][col] for i in range(len(array))]


# In[108]:


def task3(array2, method):
    draw_dots(get_vector(array2, 0), get_vector(array2, 1))
    return get_distance(array2, method)


# In[109]:


array = get_random_array(10, 2)
array


# In[110]:


res = task3(array, 1)


# In[111]:


res


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




