"use strict"

angular.module "brasFeApp"
.config ($stateProvider) ->
  $stateProvider
  .state "session",
    url: ""
    parent: "root"
    views:
      main:
        templateUrl: "app/landing/landing.html"
  .state "session.login",
    url: "login"
    views:
      control:
        templateUrl: "components/form/session/login.html"
        controller: "SessionCtrl"
  .state "session.student",
    url: "student"
    views:
      control:
        templateUrl: "components/form/session/student.html"
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
    url: "oauth/{provider}?code&state"
    views:
      control:
        template: "<h2></h2><h2>Loading...</h2>"
        controller: "SessionCtrl"
  .state "session.gauth",
    url: "gauth?key&login&role&role_id"
    views:
      control:
        template: "<h2></h2><h2>Loading...</h2>"
        controller: "SessionCtrl"
