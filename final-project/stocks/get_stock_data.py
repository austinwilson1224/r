# extract stock data using pandas data reader 


import datetime as dt  
# import matplotlib.pyplot as plt 
# from matplotlib import style
# from mpl_finance import candlestick_ochl
# import matplotlib.dates as mdates
import pandas as pd 
import pandas_datareader as pdr 
import pandas_datareader.data as web
import numpy as np
# from collections import Counter
import os
# import bs4 as bs 
# import pickle
# import requests 
# from sklearn import svm, neighbors
# from sklearn.model_selection import cross_validate
# from sklearn.model_selection import train_test_split
# from sklearn.ensemble import VotingClassifier, RandomForestClassifier


# these are the tickers stored in tickers.txt add whatever companies you want 
tickers = open("tickers.txt","r").read().split("\n")
tickers

######### get the data for each time period of the corresponding pandemic 
def get_data_from_yahoo_pandemic(start = dt.datetime(year = 2020, month = 10, day = 1), end = dt.datetime(year = 2020, month = 11, day = 1)):
    # with open('sp500tickers.pickle','rb') as f:
    #         tickers = pickle.load(f)
    if not os.path.exists('stock_dfs'):
        os.makedirs('stock_dfs')

    # tickers = ['AAPL','AXP','NKE','CVX','JNJ','F','ALK']
    # start = dt.datetime(2002,10,1)
    # end = dt.datetime(2003,9,1)


    # to test use tickers[:10] so you don't have to wiat for all 500
    # tickers = ["GOOG"]

    for ticker in tickers:
        print(ticker)
        if not os.path.exists('stock_dfs/{}.csv'.format(ticker)):
            try:
                df = web.DataReader(ticker,'yahoo',start,end)
                df.to_csv('stock_dfs/{}.csv'.format(ticker))
            except KeyError:
                pass
        else:
            print('Already have {}'.format(ticker))


get_data_from_yahoo_pandemic()