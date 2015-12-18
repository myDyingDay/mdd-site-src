my dyingDay
===

This is the source code for `my dyingDay`'s website, http://mydyingdayrocks.com.

It is build locally with Grunt & Jekyll, and deployed to `mydyingday.github.io`


## Setup

You'll need `npm` & `grunt` to be installed on your system. 

Download or clone this repository, then `cd` into the dir and run:

`$ npm install` *sudo* might be required. Installs [required dependencies](package.json)

`$ bower install` Installs [required bower dependencies](bower.json)


## Run

`$ grunt serve` Builds everything, boots up webserver and opens browser at [127.0.0.1:3000](http://127.0.0.1:3000), then watches for file changes and responds accordingly.


## Edit content

Most content is stored in .yml datafiles under [app/_data/](app/_data/).

* [Albums](app/_data/albums.yml)
* [Videos](app/_data/videos.yml)
* [Dates](app/_data/dates.yml)
* [Timeline](app/_data/timeline.yml)
* [Members](app/_data/members.yml)


## Deploy

`$ grunt deploy` Builds everything and deploys to `master` branch on `mydyingday.github.io`




