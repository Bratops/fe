'use strict'

angular.module 'brasFeApp'
.config ($stateProvider) ->
  $stateProvider
  .state "dashboard",
    url: "/dashboard"
    templateUrl: "app/dashboard/view/user.html"
    controller: "DashboardCtrl"
