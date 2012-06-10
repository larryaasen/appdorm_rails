# The AppDorm project - a private market for Android apps

This project is designed to produce a website that can be used to setup private Android app markets quickly and easily. The code is open source and can be used by small companies, large companies, government agencies, and private individuals.

## Help Wanted

The code for AppDorm is written by volunteers and we need your help.

Architect - We need an experience architect to design the website software for AppDorm. Please contact the admin with your details.

Developer - We need Ruby on Rails developers who can implement the features of this website. You will work closely with the Architect to build core features and the front end. Please contact the admin with your details.

Designer - We need an experience website designer who can quickly design a theme for this website. You will work closely with the Architect to create a design that is appealing and user friendly. Please contact the admin with your details.

## Contributors

This project wouldn't exist without all of our awesome users and contributors.

* [View our growing list of contributors](https://github.com/larryaasen/appdorm_rails/contributors)

Thank you so much!


# AppDorm Rails Application Notes

NoteProduction: The production environment is configured for Heroku, host: radiant-lightning-7681

## Layers

    |-- Build Architecture
    |
    |-- view: app/views/builds/show.html.erb
    |
    |-- controller: app/controllers/builds_controller.rb
    |
    |-- model:    app/models/build.rb
    |
    |-- database: db/schema.rb
    |

## Description of Contents

The default directory structure of a generated Ruby on Rails application:

    |-- app
    |   |-- assets
    |       |-- images
    |       |-- javascripts
    |       `-- stylesheets
    |   |-- controllers
    |   |-- helpers
    |   |-- mailers
    |   |-- models
    |   `-- views
    |       `-- layouts
    |-- config
    |   |-- environments
    |   |-- initializers
    |   `-- locales
    |-- db
    |-- doc
    |-- lib
    |   `-- tasks
    |-- log
    |-- public
    |-- script
    |-- test
    |   |-- fixtures
    |   |-- functional
    |   |-- integration
    |   |-- performance
    |   `-- unit
    |-- tmp
    |   |-- cache
    |   |-- pids
    |   |-- sessions
    |   `-- sockets
    `-- vendor
        |-- assets
            `-- stylesheets
        `-- plugins

app
  Holds all the code that's specific to this particular application.

app/assets
  Contains subdirectories for images, stylesheets, and JavaScript files.

app/controllers
  Holds controllers that should be named like weblogs_controller.rb for
  automated URL mapping. All controllers should descend from
  ApplicationController which itself descends from ActionController::Base.

app/models
  Holds models that should be named like post.rb. Models descend from
  ActiveRecord::Base by default.

app/views
  Holds the template files for the view that should be named like
  weblogs/index.html.erb for the WeblogsController#index action. All views use
  eRuby syntax by default.

app/views/layouts
  Holds the template files for layouts to be used with views. This models the
  common header/footer method of wrapping views. In your views, define a layout
  using the <tt>layout :default</tt> and create a file named default.html.erb.
  Inside default.html.erb, call <% yield %> to render the view using this
  layout.

app/helpers
  Holds view helpers that should be named like weblogs_helper.rb. These are
  generated for you automatically when using generators for controllers.
  Helpers can be used to wrap functionality for your views into methods.

config
  Configuration files for the Rails environment, the routing map, the database,
  and other dependencies.

db
  Contains the database schema in schema.rb. db/migrate contains all the
  sequence of Migrations for your schema.

doc
  This directory is where your application documentation will be stored when
  generated using <tt>rake doc:app</tt>

lib
  Application specific libraries. Basically, any kind of custom code that
  doesn't belong under controllers, models, or helpers. This directory is in
  the load path.

public
  The directory available for the web server. Also contains the dispatchers and the
  default HTML files. This should be set as the DOCUMENT_ROOT of your web
  server.

script
  Helper scripts for automation and generation.

test
  Unit and functional tests along with fixtures. When using the rails generate
  command, template test files will be generated for you and placed in this
  directory.

vendor
  External libraries that the application depends on. Also includes the plugins
  subdirectory. If the app has frozen rails, those gems also go here, under
  vendor/rails/. This directory is in the load path.
