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
  "ngTagsInput",
  "flow",   # file upload
  "angular-growl",
  "angular-loading-bar",
  "ngGrid",
]

.constant "Config",
  host: "brasbe.dev" #"bebras01.csie.ntnu.edu.tw:88" #"localhost:3000"

.config (tagsInputConfigProvider) ->
  tagsInputConfigProvider.setDefaults("tagsInput",
    placeholder: "新增標記"
    addOnEnter: true
  ).setDefaults("autoComplete",
    maxResultsToShow: 10
    debounceDelay: 1000
  ).setActiveInterpolation("tagsInput",
    placeholder: true
    addOnEnter: true
    removeTagSymbol: true
  ).setTextAutosizeThreshold 40

.config (flowFactoryProvider) ->
    flowFactoryProvider.defaults =
      target: ""
      simultaneousUploads: 4
      permanentErrors: [
        404
        500
        501
      ]
    flowFactoryProvider.on "catchAll", (event) ->
      ""
      # You can also set default events:

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

