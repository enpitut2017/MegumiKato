Megumi-Server by team MegumiKato.
====
We are developing this application for our course (enPiT) in University of Tsukuba.
Our project's goal is making a device which prevents the user's bicycle from theft.  

## Elevator pitch
"I am afraid of bicycle theft...😨"  
"My bicycle is stolen!😡  Where on earth is my bicycle?"  
We proposed Megumi system to cope with these problems. You use a saddle, which is called Megumi-Saddle, with GPS function. Megumi-Saddle sends positional information by GPS. Thereby, you can easily check the position of your bicycle from your web browser and Android app.  
It is Megumi that is an assistant to protect your bicycle.

## URL
- [Service URL](https://megumi-kato-20170802.herokuapp.com)

## Member
- [Toshiyuki Ando](https://github.com/ToshiyukiAndo)
- [Koshi Ikegawa](https://github.com/ikegawa-koshi)
- [Kazuya Oharada](https://github.com/prpr-man)
- [Koki Kobayashi](https://github.com/KokiKobayashi)

## Setup
### Requirements
- postgresql (production)

### Get Started
```console (without docker)
$ git clone https://github.com/enpitut2017/MegumiKato.git
$ bundle install
$ bundle exec rails server
```

```console (with docker)
$ git clone https://github.com/enpitut2017/MegumiKato.git
$ docker-compose build
$ docker-compose up
```
