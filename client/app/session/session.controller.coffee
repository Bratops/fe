'use strict'

angular.module 'brasFeApp'
.controller 'SessionCtrl', ($scope, session) ->
  $scope.moeid = null

  $scope.get_school_list = (query)->
    session.sclist(query).then (resp) ->
      resp
