# recomlive-docker
Recom.live — a real-time recommendation system

## tl;dr
```
git clone https://github.com/grinya007/recomlive-docker.git
cd recomlive-docker
make
make start
cd ..
git clone https://github.com/grinya007/recomlive-client.git
cd recomlive-client
python3
>>> from recommender import Client
>>> c = Client('localhost', 5005)
>>> c.record_recommend('d1', 'p1')
[]
>>> c.record_recommend('d1', 'p2')
[]
>>> c.record_recommend('d2', 'p2')
[]
>>> c.record_recommend('d2', 'p3')
['d1']
>>> quit()
cd ../recomlive-docker
make stop
make clean
```
