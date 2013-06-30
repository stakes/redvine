# Redvine

A simple Ruby wrapper for the totally unofficial and undocumented [Vine](http://vine.co) API. Everyone loves Vine these days, and [this pretty much sums up why](http://www.youtube.com/watch?v=sdSJ1--kBZ4).

Very heavily inspired by [Vino](https://github.com/tlack/vino), and made possible by the super sleuthing documented on [khakimov.com](http://khakimov.com/blog/2013/03/12/vines-undocumented-api/).

It pretty much goes without saying that this wasn't authorized by Vine or anyone who works at Vine, so don't blame me if you try to use it and Vine gets mad at you. 

## Installation

    gem install redvine

## Usage

    require 'rubygems'
    require 'redvine'

    client = Redvine.new

    # Connect to Vine with an email and password
    client.connect(email: 'your@email.com', password: 'your_vine_password')

    # Get your own timeline
    client.timeline

    # Find videos by tag
    client.search('cats')

    # Find user profiles by user ID 
    client.user_profile('908082141764657152')

    # Get a user's timeline by their user ID
    client.user_timeline('908082141764657152')

    # Get popular and promoted videos
    client.popular
    client.promoted

## Things To Do

* Learn more about the API responses and objects
* Response pagination
* Make it easier to access attributes of common objects (videos and users)
* Include all of the discovered API endpoints


