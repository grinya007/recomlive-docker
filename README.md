# Recom.live — the real-time recommendation system
This docker image is based upon [debian:stretch-slim](https://github.com/debuerreotype/docker-debian-artifacts/blob/064f343bfa6ebf043aac2bbd4c870256cfe82f5a/stretch/slim/Dockerfile), [python3](https://packages.debian.org/stretch/python3) and [Recom.live core](https://github.com/grinya007/recomlive)
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
By the way, on MacBook Pro 2014 Recom.live mills 600 visits per second

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

## What it's all about?
Recom.live is the real-time shallow-learning unsupervised item-based collaborative filtering recommendation system. It takes advantage of ARC algorithm to keep up the actual state of visitors interest, TFIDF-alike statistic to align visitors and documents importance and Cosine similarity measure to come up with recommendations.

## What problem does it solve?
Let's assume you have a news website, where recommendations block below articles is driven by the smart batch-model recommendation system. Whenever another training iteration is finished, fresh recommendations bring you a superior CTR. But how long does it take to collect another batch, sufficient for training? What recommendations would you show underneath a breaking news article, which is facing views spike if it happens to be published in 10 minutes before the next training iteration is finished? Such a situation, where good recommendations for breaking news arrive too late, is quite common. Just imagine how many page views and engaged readers your website loses. To smooth it out usual practice is to populate recommendations block with links to the most popular articles while proper recommendations are on their way. This solution is better than nothing. But if the described situation is to some extent relevant to what you have—you must give a try to Recom.live! Its intention is to fill that gap before a smarter but unhurried recommendation system kicks in.
