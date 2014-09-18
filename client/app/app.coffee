"use strict"

angular.module "brasFeApp", [
  "classy",
  "ngCookies",
  "ngResource",
  "ngAnimate",
  "ngSanitize",
  "LocalStorageModule",
  "ui.event",
  "ui.router",
  "ui.bootstrap",
  "ui.tree",
  "restangular",
  "duScroll",    # click then scroll
  "timer",
  "xeditable",
  "youtube-embed",
  "checklist-model",
  "flow",   # file upload
  "angular-growl",
  "angular-loading-bar",
  "ngGrid",
]

.config (flowFactoryProvider) ->
    flowFactoryProvider.defaults =
      target: ""
      permanentErrors: [
        404
        500
        501
      ]
    flowFactoryProvider.on "catchAll", (event) ->
      # You can also set default events:
      ""

# Can be used with different implementations of Flow.js
# flowFactoryProvider.factory = fustyFlowFactory;
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

