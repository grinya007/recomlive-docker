# recomlive-docker
Recom.live — the real-time recommendation system

## tl;dr
Install and run Recom.live server:
```
git clone https://github.com/grinya007/recomlive-docker.git
cd recomlive-docker
make
make start
```

Ckeck out Recom.live client:
```
cd ..
git clone https://github.com/grinya007/recomlive-client.git
cd recomlive-client
```

Run evaluation script:
```
time zcat data/document_person.csv.gz | ./evaluate.py
Total visits:    200000
Tries to guess:  40486
Guesses:         8219
CTR:             20.30%

real    5m23.854s
user    0m29.936s
sys     0m47.922s
```
By the way, on MacBook Pro 2014 Recom.live mills 600 vizits per second

Client usage example:
```
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
```

To stop and remove Recom.live:
```
cd ../recomlive-docker
make stop
make clean
```
