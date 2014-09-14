"use strict"

angular.module "brasFeApp"
.config ($stateProvider) ->
  $stateProvider
  .state "root",
    url: "/"
    abstract: true
    templateUrl: "app/landing/root.html"
    controller: "LandingCtrl"
  .state "landing",
    url: ""
    parent: "root"
    views:
      main:
        templateUrl: "app/landing/landing.html"
