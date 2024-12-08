import requests
from bs4 import BeautifulSoup
ur1='https://www.thebeatles.com/albums'

response= requests.get(ur1)
print(response.status_code)