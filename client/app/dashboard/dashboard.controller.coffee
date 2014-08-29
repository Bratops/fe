'use strict'

angular.module 'brasFeApp'
.controller 'DashboardCtrl', ($scope, sessionServ) ->
  sessionServ.warm_up()

  $scope.message = 'Hello'
