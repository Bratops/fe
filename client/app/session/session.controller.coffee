'use strict'

angular.module 'brasFeApp'
.controller 'SessionCtrl', ($scope, $state, $stateParams, $timeout, $location, sessionServ) ->
  #sessionServ.warm_up()
  $scope.form =
    submitted: false
  #$scope.redirect = sessionServ.redirect
# core
  $scope.onTimeout = ()->
    $scope.form.password = ""
    $scope.form.password_confirmation = ""
    $scope.timer = $timeout($scope.onTimeout, 90000)

  $scope.timer = $timeout($scope.onTimeout, 90000)

  $scope.stop = ->
    $timeout.cancel($scope.timer)

# events
  $scope.$on "$stateChangeStart",
  (event, toState, toParams, fromState, fromParams)->
    $scope.stop()
    $scope.form.submitted = false

  $scope.$on "redirect", (event, data)->
    $state.go(data)

  $scope.$on "httpError", (event)->
    $scope.form.submitted = false

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    sessionServ.auth($stateParams) if toState.name is "session.auth"

  $scope.$on "$viewContentLoaded", (event)->
    rpt = "reset_password_token"
    if $state.current.name is "sessionServ.reset"
      if !(rpt of $stateParams) or !$stateParams[rpt] or $stateParams[rpt] is "true"
        $state.go("landing")

  $scope.$watch "school", (nv, ov)->
    if nv and (typeof nv is "object") and "moeid" of nv
      $scope.form.moeid = nv.moeid

# view
  $scope.reset = ()->
    $scope.form.submitted = true
    oc = _.clone $scope.form
    obj = _.extend(oc, $stateParams)
    sessionServ.reset_pw(obj)

  $scope.register = (form)->
    $scope.form.submitted = true
    sessionServ.register($scope.form)

  $scope.login = ()->
    $scope.form.submitted = true
    sessionServ.login($scope.form)

  $scope.aquire_new_pw = ()->
    sessionServ.request_link($scope.form)

  $scope.moeid_not_set = ()->
    !("moeid" of $scope.form) or !$scope.form.moeid

  $scope.get_school_list = (query)->
    sessionServ.sclist(query).then (resp) ->
      resp

  $scope.password_matched = (form)->
    form.password == form.password_confirm

  $scope.loginable = (form)->
    !$scope.form.submitted and (form.$valid)

  $scope.resetable = (form)->
    !$scope.form.submitted and
    (form.$valid and !$scope.password_matched(form))

  $scope.registerable = (form)->
    !$scope.form.submitted and
    (form.$valid and !$scope.moeid_not_set())

  $scope.auth = (provider)->
    $scope.form.submitted = true
    base = "http://#{sessionServ.host}"
    window.location.href = "#{base}/users/auth/#{provider}"
