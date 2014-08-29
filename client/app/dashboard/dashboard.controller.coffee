'use strict'

angular.module 'brasFeApp'
.controller 'DashboardCtrl', ($scope, sessionServ) ->
  sessionServ.check_local()

  $scope.message = 'Hello'
