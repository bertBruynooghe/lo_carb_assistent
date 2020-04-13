lo_carb_assistent
=================
[![Build Status](http://img.shields.io/travis/bertBruynooghe/lo_carb_assistent.svg)](https://travis-ci.org/bertBruynooghe/lo_carb_assistent)
[![Dependency Status](https://img.shields.io/gemnasium/bertBruynooghe/lo_carb_assistent.svg)](https://gemnasium.com/bertBruynooghe/lo_carb_assistent)
[![Code Climate](http://img.shields.io/codeclimate/github/bertBruynooghe/lo_carb_assistent.svg)](https://codeclimate.com/bertBruynooghe/lo_carb_assistent/cmis-ruby)
[![Coverage Status](https://img.shields.io/coveralls/bertBruynooghe/lo_carb_assistent.svg)](https://coveralls.io/r/bertBruynooghe/lo_carb_assistent)

This app is meant to be a multi-platform food info app that can be used by diabetes patients to calculate their intake.
It is very important that the app has:
* many product inside
* is easy to use
* can be used offline

As to the initial versions, the app will have to run on the following platforms:
* iOS
* android
* Windows phone

Not willing to pay the developer fee for all these platforms, the app will be distributed as a webpage on all platforms,
and it will be ready to be deployed as a phonegap app too as offline pages are not something the windows phone platform supports.
For now, the app will be hosted on heroku, and sign up is restricted. (In later versions, there will be support for multiple users.)
As for the data of the program, there will be two ways of filling in the data which will be stored in the local database as well:
* manual entry
* suggestions taken from http://ndb.nal.usda.gov/ndb/doc/index

In the mean time, the minimal viable product strategy changed.
This are the steps:

* develop as a straight Rails application using scaffolding. Model structure as follows:
    * account has many meals
    * meal(date) has many ingredients
    * ingredient(quantity)
    * nutrient(name, calories, carbs, proteins, fat)
* heroku backup
* product lookup
* product image Bing 5000 free transactions per month, matches ndb quite well
* product translation Bing
2. authn and accounts
3. versioned API
4. single page app using backbone
5. using dualStorage

As the app has been tested in real-life situations, a number of issues came out:
* landing screen is currently the overview screen. It would probably be better to have the landing screen to be the new dosed nutrient screen, but not yet bound to a meal. (As it is sometimes convenient just to look up an nutrient without calculating a complete meal.) It should have a pageable dropdown (select2) which allows to add the add the nutrient to a new or existing meal.
* it would be very convenient to add activities and insuline doses to the system too. I guess there should be a direct link for on a number of screens, and especially on the landing screen.
* navigating to and searching through the favorites should also be more convenient. (Search box from collapsed menu that triggers a select2 box?) Or should we have the carbs/fat/proteins/kCal displayed directly along with the name in the select2 box?
* graph support
* support for input data from glucose measurements.
* decimal separator support in windows phone is still quite clunky.
