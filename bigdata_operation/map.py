import os 
import pymysql
import pandas as pd 
import matplotlib.pyplot as plt
host="localhost"
port="3306"
user="root"
password="zhuyangjian22"
database="zhuyangjian"

conn=pymysql.connect(host=host, port=int(port), user=user, password=password, db=database, charset="utf8mb4")
datasets=pd.read_sql_query("select houjin_num,houjin_name,address from zhuyangjian.kihon1 where left(setsuriritsu, 4)='2000'&&left(address, 3)='東京都'",conn)

import urllib
import urllib.request as request
import json
import time
url="https://msearch.gsi.go.jp/address-search/AddressSearch?q=" #api对象
temp4=pd.DataFrame()
for i, n in enumerate(datasets.address):
    url="https://msearch.gsi.go.jp/address-search/AddressSearch?q="
    url2=url+urllib.parse.quote(n) # address 里面的内容是日语需要用quote函数转换成ASCII字符 url可以读取的字符
    
    try:
        response=urllib.request.urlopen(url2)
        contents=response.read()
        #print(contents.decode())
        temp2=json.loads(contents.decode())
        temp3=pd.json_normalize(temp2)
        temp4=pd.concat([temp4,temp3],axis=0)
        response.close()
        time.sleep(0.1)
    except urllib.error.HTTPError:
        print('not available')
    else:
        pass
latlng=pd.DataFrame()
for i, n in enumerate(temp4["geometry.coordinates"]):
    tmp=str(n).strip()
    tmp2=str(tmp).strip("[")
    tmp3=str(tmp2).strip("]")
    tmp4=tmp3.split(',')
    lat_tmp=float(tmp4[1])
    print(lat_tmp)
    print(lng_tmp)
    lng_tmp=float(tmp4[0])
    latlng_tmp=pd.concat([pd.Series(lat_tmp),pd.Series(lng_tmp)],axis=1)
    print(latlng_tmp)

    latlng=pd.concat([latlng,latlng_tmp],axis=0, ignore_index=True)

import folium
import geocoder
from folium.plugins import HeatMap
location='東京駅'
address2=geocoder.osm(location,timeout=1)
address2.latlng
map2=folium.Map(location=address2.latlng, zoom_start=0)
HeatMap(latlng, radius=10, blur=5).add_to(map2)