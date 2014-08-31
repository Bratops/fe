"use strict"

angular.module "brasFeApp"
.config ($stateProvider) ->
  $stateProvider
  .state "session",
    abstract: true
    url: "/"
    templateUrl: "app/landing/landing.html"
    controller: "LandingCtrl"
  .state "session.login",
    url: "login"
    views:
      control:
        templateUrl: "components/form/session/login.html"
        controller: "SessionCtrl"
  .state "session.register",
    url: "register"
    views:
      control:
        templateUrl: "components/form/session/register.html"
        controller: "SessionCtrl"
  .state "session.reset",
    url: "password/edit?reset_password_token"
    views:
      control:
        templateUrl: "components/form/session/pw_reset.html"
        controller: "SessionCtrl"
  .state "session.auth",
    url: "auth?provider&code&state"
    views:
      control:
        template: "<h2>Loading...</h2>"
        controller: "SessionCtrl"
