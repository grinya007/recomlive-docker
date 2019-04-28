# Recom.live — the real-time recommendation system
This docker image is based upon [debian:stretch-slim](https://github.com/debuerreotype/docker-debian-artifacts/blob/064f343bfa6ebf043aac2bbd4c870256cfe82f5a/stretch/slim/Dockerfile), [python3](https://packages.debian.org/stretch/python3) and [Recom.live core](https://github.com/grinya007/recomlive)
## Quick installation guide
Install and run [Recom.live server](https://github.com/grinya007/recomlive):
Before "make"-ing you might want to edit the [.env file](https://github.com/grinya007/recomlive-docker/blob/master/.env). It contains a few settings that are explained in the comments inside of the file
```
git clone https://github.com/grinya007/recomlive-docker.git
cd recomlive-docker
make
make start
```

Ckeck out [Recom.live client](https://github.com/grinya007/recomlive-client):
```
cd ..
git clone https://github.com/grinya007/recomlive-client.git
cd recomlive-client
```

Run evaluation script:
```
# assuming, you're running server on the same machine and you haven't changed the default port number
time zcat data/document_person.csv.gz | ./evaluate.py localhost:5005
Total visits:    200000
Tries to guess:  40486
Guesses:         8219
CTR:             20.30%

real    5m23.854s
user    0m29.936s
sys     0m47.922s
# by the way, on MacBook Pro 2014 Recom.live mills 600 visits per second
```

Client usage example:
```
python3
>>> from recommender import Client

# it would make sense to preserve a Client instance as a singleton
# throughout your web application lifecycle
>>> c = Client('localhost', 5005)

# now you can start pouring pairs of document_id, person_id
# into Recom.live server on every visit of your website
# and receive recommendations
>>> c.record_recommend('d1', 'p1')
[]
>>> c.record_recommend('d2', 'p1')
[]
>>> c.record_recommend('d1', 'p2')
[]
>>> c.record_recommend('d2', 'p2')
[]
>>> c.record_recommend('d2', 'p3')
['d1']
>>> c.record('d2', 'p4')
10 # the return value of socket.sendto() method
>>> c.recommend('d2', 'p4')
['d1']
>>> c.person_history('p2')
['d1', 'd2']

# please keep in mind that all document_ids that get to recommender server
# have a chance to be recommended, although, it's unlikely that you would
# ever want to show homepage or some other non-article pages in recommendations,
# you can either filter such pages from Recom.live's output, or just never
# record visits to these pages
>>> quit()
```

To stop and remove Recom.live:
```
cd ../recomlive-docker
make stop
make clean
```
