
# WASTE RECOGNITION PROJECT 
# https://www.kaggle.com/techsash/waste-classification-data


import pandas as pd 
import numpy as np 
import os
import requests
import urllib
from PIL import Image

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn import metrics

import tensorflow as tf 
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout, Activation, Flatten, Conv2D, MaxPooling2D
from tensorflow.keras.callbacks import EarlyStopping, ModelCheckpoint
from tensorflow.keras.applications.vgg16 import VGG16
from tensorflow.keras.applications.vgg19 import VGG19


path =  "/Users/austinwilson/coding/r/final-project/waste-recognition/DATASET/TRAIN"
download_link = "https://www.kaggle.com/techsash/waste-classification-data/download"
req = requests.get(download_link, allow_redirects = True)
req.content

open(req.content,"wb")

urllib.urlretrieve(download_link,"/Users/austinwilson/coding/r/final-project/waste-recognition/data2")
open("data2", "wb").write(req.content)


# class names
class_names = os.listdir(path)[1:]
class_names

# image names
o_images_names = os.listdir(path + "/O")
r_images_names = os.listdir(path + "/R")


organic_images = []
recyclable_images = []
img_size = (128,128)


# organic images as float64 numpy array
subset = 1000
for img_name in o_images_names[0:subset]:

    # some images in grey scale
    img = Image.open(path + "/O/" + img_name).convert("RGB")
    img = img.resize(img_size)
    img_array = np.asarray(img)
    if img.size == (128,128):
        organic_images.append(img_array)
organic_images = np.asarray(organic_images, dtype = "float64")


# recyclable images as float64 np array
for img_name in r_images_names[0:subset]:

    # some images in grey scale
    img = Image.open(path + "/R/" + img_name).convert("RGB")
    img = img.resize(img_size)
    img_array = np.asarray(img)
    if img.size == (128,128):
        recyclable_images.append(img_array)
recyclable_images = np.asarray(recyclable_images, dtype = "float64")



# confirming structural integrity of data
print(organic_images.shape)
print(organic_images.dtype)
print(recyclable_images.shape)
print(recyclable_images.dtype)


# making a column for y
y_organic = np.repeat("O",subset)
y_recycle = np.repeat("R",subset)

# final data to be sent into the model 
x = np.concatenate([organic_images,recyclable_images])
y = np.concatenate([y_organic,y_recycle])

# setting up y values 
le = LabelEncoder()
y = le.fit_transform(y)
y = tf.keras.utils.to_categorical(y)





x_train, x_test, y_train,y_test = train_test_split(x, y, test_size = .2, random_state = 42)

############
            #NORMALIZE THE DATA! -- divide everything by 255
############

# double check the size
print(x_train.shape)
print(y_train.shape)

print(x_test.shape)
print(y_test.shape)



# creating the model 
model_simple = Sequential()
model_simple.add(Dense(32,input_shape=(128,128,3),activation='relu'))
model_simple.add(Flatten())
model_simple.add(Dense(2,activation='softmax'))
model_simple.compile(loss='categorical_crossentropy',optimizer='adam')

# early stopping
monitor = EarlyStopping(monitor='val_loss',min_delta=1e-3,patience=2,verbose=2,mode='auto')


# training!!
model_simple.fit(x_train ,y_train,
                   batch_size = 20,
                   epochs = 20,
                   verbose=2,
                   callbacks=[monitor],
                   validation_data=(x_test,y_test))


y_true = np.argmax(y_test,axis = 1)
y_pred = model_simple.predict(x_test)
y_pred = np.argmax(y_pred,axis = 1)
report = metrics.classification_report(y_true,y_pred)

f1_simple = metrics.f1_score(y_true,y_pred,average='weighted')
f1_simple