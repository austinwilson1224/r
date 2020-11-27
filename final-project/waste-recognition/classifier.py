
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



'''
path =  "/Users/austinwilson/coding/r/final-project/waste-recognition/DATASET"
path_train = "/Users/austinwilson/coding/r/final-project/waste-recognition/DATASET/TRAIN"
path_test = "/Users/austinwilson/coding/r/final-project/waste-recognition/DATASET/TEST"

path_train_o = path + '/TRAIN/O'
path_train_r = path + '/TRAIN/R'

path_test_o = path + '/TEST/O'
path_test_r = path + '/TEST/R'





# class names
# class_names = os.listdir(path_train)[1:] # 
class_names = ['R','O']
class_names

# image names
o_images_names_train = os.listdir(path_train + "/O")
r_images_names_train = os.listdir(path_train + "/R")

o_images_names_test = os.listdir(path_test + "/O")
r_images_names_test = os.listdir(path_test + "/R")


# size of image set 
o_len_train = len(o_images_names_train)
r_len_train = len(r_images_names_train)

o_len_test = len(o_images_names_test)
r_len_test = len(r_images_names_test)

# number of images in train and test sets
o_len_train # 12565
r_len_train # 9999

o_len_test # 1401
r_len_test # 1112


organic_images_train = []
recyclable_images_train = []
organic_images_test = []
recyclable_images_test = []
img_size = (128,128)


# organic images as float64 numpy array
subset = 1000
'''

path_train = "/Users/austinwilson/coding/r/final-project/waste-recognition/DATASET/TRAIN"
path_test = "/Users/austinwilson/coding/r/final-project/waste-recognition/DATASET/TEST"
# write a function do this 

'''
function 

this is the function to get all images and store them in a numpy array
'''

def img_array2(path, img_size = (128, 128)):
    all_img_array = []
    for img_name in os.listdir(path):
        img = Image.open(path + img_name).convert("RGB")
        img.resize(img_size)
        img_array = np.asarray(img)
        all_img_array.append(img_array)
    return np.asarray(all_img_array, dtype="float64")



def get_numpy_image_array(path):
    image_names_o = os.listdir(path + "/O")
    image_names_r = os.listdir(path + "/R")
    numpy_img_array_o = []
    numpy_img_array_r = []

    # for the images in O category 
    for img_name in image_names_o:
        # some images in grey scale
        img = Image.open(path + "/O/" + img_name).convert("RGB")
        img = img.resize(img_size)
        img_array = np.asarray(img)
        if img.size == (128,128):
            numpy_img_array_o.append(img_array)

    # for the images in R category 
    for img_name in image_names_r:
        # some images in grey scale
        img = Image.open(path + "/R/" + img_name).convert("RGB")
        img = img.resize(img_size)
        img_array = np.asarray(img)
        if img.size == (128,128):
            numpy_img_array_r.append(img_array)



    return np.asarray(numpy_img_array_o, dtype="float64"), np.asarray(numpy_img_array_r, dtype="float64")

organic_images_train, recyclable_images_train = get_numpy_image_array(path_train)
organic_images_test, recyclable_images_test = get_numpy_image_array(path_test)






'''
# building a numpy array for all the images in the training data
for img_name in o_images_names_train:

    # some images in grey scale
    img = Image.open(path + "/TRAIN/O/" + img_name).convert("RGB")
    img = img.resize(img_size)
    img_array = np.asarray(img)
    if img.size == (128,128):
        organic_images_train.append(img_array)
organic_images_train2 = np.asarray(organic_images_train, dtype = "float64")

organic_images_train == organic_images_train2

# building a numpy array for all the images in the test data
for img_name in o_images_names_test:

    # some images in grey scale
    img = Image.open(path + "/O/" + img_name).convert("RGB")
    img = img.resize(img_size)
    img_array = np.asarray(img)
    if img.size == (128,128):
        organic_images_test.append(img_array)
organic_images_test = np.asarray(organic_images_test, dtype = "float64")




# recyclable images as float64 np array
for img_name in r_images_names:

    # some images in grey scale
    img = Image.open(path + "/R/" + img_name).convert("RGB")
    img = img.resize(img_size)
    img_array = np.asarray(img)
    if img.size == (128,128):
        recyclable_images_train.append(img_array)
recyclable_images_train = np.asarray(recyclable_images_train, dtype = "float64")

'''

# confirming structural integrity of data
print(organic_images_train.shape)
print(organic_images_train.dtype)
print(recyclable_images_train.shape)
print(recyclable_images_train.dtype)











o_len_train = len(organic_images_train)
o_len_train
r_len_train = len(recyclable_images_train)
r_len_train

o_len_test = len(organic_images_test)
r_len_test = len(recyclable_images_test)




# making a column for y
y_organic_train = np.repeat("O",o_len_train)
y_organic_train.shape
y_recycle_train = np.repeat("R",r_len_train)
y_recycle_train.shape

y_organic_test = np.repeat("O",o_len_test)
y_recycle_test = np.repeat("R",r_len_test)

# final data to be sent into the model 
x = np.concatenate([organic_images_train,recyclable_images_train])
x.shape

x_train = np.concatenate([organic_images_train,recyclable_images_train])
x_test = np.concatenate([organic_images_test,recyclable_images_test])



y = np.concatenate([y_organic_train,y_recycle_train])
y.shape
y_train = np.concatenate([y_organic_train,y_recycle_train])
y_test = np.concatenate([y_organic_test,y_recycle_test])

# check the shape 
# x.shape
# y.shape


# setting up y values 
le = LabelEncoder()
y = le.fit_transform(y)
y = tf.keras.utils.to_categorical(y)

le_1 = LabelEncoder()
le_2 = LabelEncoder()
y_train = le_1.fit_transform(y_train)
y_train = tf.keras.utils.to_categorical(y_train)
y_test = le_2.fit_transform(y_test)
y_test = tf.keras.utils.to_categorical(y_test)

# normalize the data
x = x / 255

x_train = x_train / 255
x_test = x_test / 255


# train test split 
x_train, x_test, y_train,y_test = train_test_split(x, y, test_size = .2, random_state = 42)


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
path_to_model = '/Users/austinwilson/coding/r/final-project/waste-recognition/models/'
monitor = EarlyStopping(monitor='val_loss',min_delta=1e-3,patience=2,verbose=2,mode='auto')
checkpointer = ModelCheckpoint(filepath=path_to_model+'model_simple2.hdf5',verbose=0,save_best_only=True)
# checkpointer256 = ModelCheckpoint(filepath='/content/drive/My Drive/180/final project/dnn/modelo256.hdf5',verbose=0,save_best_only=True)


# training!!
model_simple.fit(x_train ,y_train,
                   batch_size = 20,
                   epochs = 20,
                   verbose=2,
                   callbacks=[monitor, checkpointer],
                   validation_data=(x_test,y_test))


y_true = np.argmax(y_test,axis = 1)
y_pred = model_simple.predict(x_test)
y_pred = np.argmax(y_pred,axis = 1)
report = metrics.classification_report(y_true,y_pred)

f1_simple = metrics.f1_score(y_true,y_pred,average='weighted')
f1_simple



'''
asdfasfsadfasdfasdfasdf MODEL 2!!!!!


'''

vgg19_128 = VGG19(weights='imagenet',include_top=False,input_shape=(128,128,3))

model_19_128 = Sequential()
for layer in vgg19_128.layers:
  model_19_128.add(layer)
for layer in model_19_128.layers:
  layer.trainable = False


model_19_128.add(Flatten())
model_19_128.add(Dense(2,activation='softmax'))


checkpointer_vgg19_128 = ModelCheckpoint(filepath='path_to_model/vgg19_1.hdf5',verbose=0,save_best_only=True)
monitor = EarlyStopping(monitor='val_loss',min_delta=1e-3,patience=2,verbose=2,mode='auto')
model_19_128.compile(optimizer='adam',loss='categorical_crossentropy')

# for i in range(5):
model_19_128.fit(x_train,y_train,
            batch_size=32,
            epochs=20,
            verbose=2,
            callbacks=[monitor,checkpointer_vgg19_128],
            validation_data=(x_test,y_test))

y_true = np.argmax(y_test,axis = 1)
y_pred = model_19_128.predict(x_test)
y_pred = np.argmax(y_pred,axis = 1)
f1_vgg19 = metrics.f1_score(y_true,y_pred,method="weighted")