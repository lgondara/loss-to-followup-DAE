# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Oct 13 20:21:56 2016

@author: Lovedeep Gondara
"""
# Two lines below, if you have a GPU
import os
os.environ["THEANO_FLAGS"] = "device=gpu,floatX=float32,nvcc.flags=-D_FORCE_INLINES,lib.cnmem=0.7"
# Import required libraries
import theano
from keras.layers import Input, Dense, Convolution1D, MaxPooling1D, UpSampling1D, Dropout,BatchNormalization
from keras.models import Model
from keras import regularizers
from keras.layers import advanced_activations
import numpy as np
from sklearn.preprocessing import StandardScaler
import csv
import matplotlib.pyplot as plt
import matplotlib
from numpy import inf

# Read in test and train, clean and noisy datasets
x_train = np.float32(np.genfromtxt ('path to train', delimiter=","))
x_test = np.float32(np.genfromtxt ('path to test', delimiter=","))


x_train_noisy=np.float32(np.genfromtxt ('path to noisy train', delimiter=","))
x_test_noisy=np.float32(np.genfromtxt ('path to noisy test', delimiter=","))

# Replace missing values with 0 to start
nans_train= np.isnan(x_train_noisy)
x_train_noisy[nans_train] = 0

nans_test= np.isnan(x_test_noisy)
x_test_noisy[nans_test] = 0

# only use the piece of code below if your dataset needs standardizing
standard_scaler = StandardScaler()
xtrn = standard_scaler.fit_transform(x_train)
xtst = standard_scaler.transform(x_test)
xtrnoisy = standard_scaler.transform(x_train_noisy)
xtstnoisy = standard_scaler.transform(x_test_noisy)


# this is our input placeholdr
input_data = Input(shape=(32,))
# "encoded" is the encoded representation of the input
encoded = Dense(32, activation='relu' )(input_data)
encoded=BatchNormalization()(encoded)
encoded = Dense(37, activation='relu')(encoded)
encoded=BatchNormalization()(encoded)
encoded=Dropout(0.2)(encoded)
encoded = Dense(42, activation='relu')(encoded)
encoded=BatchNormalization()(encoded)
encoded=Dropout(0.2)(encoded)
encoded = Dense(47, activation='relu')(encoded)
encoded=BatchNormalization()(encoded)
encoded=Dropout(0.2)(encoded)
encoded = Dense(52, activation='relu')(encoded)
encoded=BatchNormalization()(encoded)
encoded=Dropout(0.2)(encoded)

# "decoded" is the decoded representation of encoded input
decoded = Dense(52,activation='relu',)(encoded)
decoded=BatchNormalization()(decoded)
decoded=Dropout(0.2)(decoded)
decoded = Dense(47, activation='relu')(decoded)
decoded=BatchNormalization()(decoded)
decoded=Dropout(0.2)(decoded)
decoded = Dense(42, activation='relu')(decoded)
decoded=BatchNormalization()(decoded)
decoded=Dropout(0.2)(decoded)
decoded = Dense(37, activation='relu')(decoded)
decoded=BatchNormalization()(decoded)
decoded=Dropout(0.2)(decoded)
decoded = Dense(32,activation='relu')(decoded)


# this model maps an input to its reconstruction
autoencoder = Model(input=input_img, output=decoded)

# compile using mse loss
autoencoder.compile(optimizer='adam', loss='mse')

# validation data is just there to show progress, does not affect the training, i.e. is isolated from training
model=autoencoder.fit(x_train_noisy, x_train,
                nb_epoch=500,
                batch_size=500,
                shuffle=True,
                validation_data=(x_test_noisy, x_test))

# predict data with missing values
decoded_data = autoencoder.predict(x_test_noisy)

# only use the below line if you standardized your data and need to back transform imputed data to original scale
decoded=standard_scaler.inverse_transform(decoded_data)

# save results to external file
np.savetxt("path to output", decoded_data, delimiter=",")
