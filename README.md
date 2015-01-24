lo_carb_assistent
=================
This app is meant to be a multi-platform food info app that can be used by diabetes patients to calculate their intake.
It is very important that the app has:
* many product inside
* is easy to use
* can be used offline

As to the initial versions, the app will have to run on the following platforms:
* iOS
* android
* Windows phone

Not willing to pay the developper fee for all these platforms, the app will be distributes as webpage on all platforms,
and it will be ready to be deployed as a phonegap app too as offline pages are not something the windows phone platform supports.
In the beginning, the index will simply be hosted on github as http://rawgit.com/bertBruynooghe/lo_carb_assistent/master/index.html
As for the data of the program, there will be two ways of filling in the data which will be stored in the local database as well:
* manual entry
* suggestions taken from http://ndb.nal.usda.gov/ndb/doc/index

In the mean time, the minimal viable product strategy changed.
This are the steps:

1. develop as a straight Rails application using scaffolding. Model structure as follows:
    * account has many meals
    * meal(date) has many dosed_ingredients
    * dosed_ingredient(quantity) has one ingredient
    * ingredient(name, calories, carbs, proteins, fat)
2. authn and accounts
3. versioned API
4. single page app using backbone
5. using dualStorage