'use strict'

angular.module 'brasFeApp'
.controller 'SessionCtrl', ($scope, $state, $stateParams, sessionServ) ->
  $scope.form =
    submitted: false

  $scope.get_school_list = (query)->
    sessionServ.sclist(query).then (resp) ->
      resp

  $scope.reset = ()->
    sessionServ.reset_pw()

  $scope.registerable = (form)->
    !$scope.form.submitted and
    (form.$valid and !$scope.moeid_not_set())

  $scope.register = (form)->
    $scope.form.submitted = true
    sessionServ.register($scope.form)

  $scope.login = ()->
    sessionServ.login()

  $scope.$watch "sessionServ.redirect", (nv, ov)->
    console.log "watching session redirect"
    console.log nv

  $scope.$on "$viewContentLoaded", (event)->
    rpt = "reset_password_token"
    if $state.current.name is "sessionServ.reset"
      if !(rpt of $stateParams) or !$stateParams[rpt] or $stateParams[rpt] is "true"
        $state.go("landing")

  $scope.$watch "school", (nv, ov)->
    if nv and (typeof nv is "object") and "moeid" of nv
      $scope.form.moeid = nv.moeid

  $scope.set_moeid = (i, m, l)->
    #$scope.form.moeid = i.moeid

  $scope.moeid_not_set = ()->
    !("moeid" of $scope.form) or !$scope.form.moeid
