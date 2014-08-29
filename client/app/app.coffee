"use strict"

angular.module "brasFeApp", [
  "ngCookies",
  "ngResource",
  "ngAnimate",
  "ngSanitize",
  "ui.router",
  "ui.bootstrap",
  "restangular",
  "duScroll",
  "angular-growl",
  "timer",
]

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

.config (RestangularProvider) ->
  RestangularProvider.setBaseUrl "http://bebras01.csie.ntnu.edu.tw/"
  #RestangularProvider.setExtraFields ["name"]
  #RestangularProvider.setResponseExtractor (response, operation) ->
  #  response.data
  #RestangularProvider.addElementTransformer "accounts", false, (element) ->
  #  element.accountName = "Changed"
  #  element
  RestangularProvider.setDefaultHttpFields
    cache: true,
    withCredentials: true #allow cookies, sessions
  #RestangularProvider.setMethodOverriders [
  #  "put"
  #  "patch"
  #]
  # In this case we are mapping the id of each element to the _id field.
  # We also change the Restangular route.
  # The default value for parentResource remains the same.
  RestangularProvider.setRestangularFields
    id: "_id"
    route: "restangularRoute"
    selfLink: "self.href"
  #RestangularProvider.setRequestSuffix ".json"
  # Use Request interceptor
  #RestangularProvider.setRequestInterceptor (element, operation, route, url) ->
  #  delete element.name
  #  element
  # ..or use the full request interceptor, setRequestInterceptor's more powerful brother!
  #RestangularProvider.setFullRequestInterceptor (element, operation, route, url, headers, params, httpConfig) ->
  #  delete element.name
  #  element: element
  #  params: _.extend(params,
  #    single: true
  #  )
  #  headers: headers
  #  httpConfig: httpConfig
  #set default header "token"
  RestangularProvider.setDefaultHeaders
    "Content-Type": "application/json",
    "X-Requested-With": "XMLHttpRequest",
    "Accept": "application/bebras.tw; ver=1"
  return
