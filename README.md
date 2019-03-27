# Meetuper

Demo project that shows how you can achieve the same functionaliuty of fetching data from meetup API through sync and async requests.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

* Ruby 2.6.0
* Rails 5.2.2
* Redis 5.0.3

## Install

### Clone the repository

```shell
git clone git@github.com:cupuycblack/meetuper.git
cd meetuper
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.5.1`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.6.0
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle
```

## Serve

```shell
rails s
```

To execute queries asynchromously run the background job

```shell
QUEUE=* rake resque:work
```

## Running the tests

```shell
rspec spec
```
