"use strict"

angular.module "brasFeApp"
.config ($stateProvider) ->
  $stateProvider
  .state "landing",
    url: "/"
    templateUrl: "app/landing/landing.html"
    controller: "LandingCtrl"
  .state "landing.login",
    url: "login"
    views:
      control:
        templateUrl: "components/form/session/login.html"
        controller: "SessionCtrl"
  .state "landing.register",
    url: "register"
    views:
      control:
        templateUrl: "components/form/session/register.html"
        controller: "SessionCtrl"
