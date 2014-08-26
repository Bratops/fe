'use strict'

angular.module 'brasFeApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'landing',
    url: '/'
    templateUrl: 'app/landing/landing.html'
    controller: 'LandingCtrl'
  .state 'landing.login',
    url: '/login'
    templateUrl: 'app/landing/login.html'
    controller: 'SessionCtrl'
