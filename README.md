CyTras-Server by team MegumiKato.
====
We are developing this application for our course (enPiT) in University of Tsukuba.
Our project's goal is making a device which prevents the user's bicycle from theft.  

## Elevator pitch
"I am afraid of bicycle theft...😨"  
"My bicycle is stolen!😡  Where on earth is my bicycle?"  
We proposed CyTras to cope with these problems. You use a saddle, which is called CyTras-Saddle, with GPS function. CyTras-Saddle sends positional information by GPS. Thereby, you can easily check the position of your bicycle from your web browser and Android app.  
It is CyTras that is an assistant to protect your bicycle.

## URL
- [Service URL](http://www12450ue.sakura.ne.jp/positions)

## Member
- [Toshiyuki Ando](https://github.com/ToshiyukiAndo)
- [Koshi Ikegawa](https://github.com/ikegawa-koshi)
- [Kazuya Oharada](https://github.com/prpr-man)
- [Koki Kobayashi](https://github.com/KokiKobayashi)

## Setup
### Requirements
- postgresql (production)

### Get Started
- without docker
```console
$ git clone https://github.com/enpitut2017/MegumiKato.git
$ bundle install
$ bundle exec rails server
```

- use docker
```console
$ git clone https://github.com/enpitut2017/MegumiKato.git
$ docker-compose build
$ docker-compose up
```

## Other components
- [Megumi-Saddle](https://github.com/enpitut2017/MegumiKato_Hardware)
- [Megumi-App](https://github.com/enpitut2017/MegumiKato_android)

