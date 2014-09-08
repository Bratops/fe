"use strict"

angular.module "brasFeApp", [
  "ngCookies",
  "LocalStorageModule",
  "ngResource",
  "ngAnimate",
  "ngSanitize",
  "ui.router",
  "ui.bootstrap",
  "restangular",
  "duScroll",
  "angular-growl",
  "timer",
  "ngGrid",
  "ui.tree",
  "angular-loading-bar",
]

.config (localStorageServiceProvider)->
  localStorageServiceProvider.setPrefix("user")

.config (cfpLoadingBarProvider)->
  cfpLoadingBarProvider.includeSpinner = false
  cfpLoadingBarProvider.includeBar = true
  cfpLoadingBarProvider.latencyThreshold = 1000

.config (growlProvider) ->
  growlProvider.globalTimeToLive 10*1000
  growlProvider.onlyUniqueMessages false
  growlProvider.globalReversedOrder true
  growlProvider.globalDisableCountDown true

.config ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $urlRouterProvider
  .otherwise "/"
  $locationProvider.html5Mode true

.config ($httpProvider) ->
  $httpProvider.interceptors.push "errorHandler"
  #$httpProvider.interceptors.push "sessionInjector"

