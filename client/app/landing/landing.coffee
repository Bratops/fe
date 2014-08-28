"use strict"

angular.module "brasFeApp"
.config ($stateProvider) ->
  $stateProvider
  .state "landing",
    url: "/"
    templateUrl: "app/landing/landing.html"
    controller: "LandingCtrl"
