'use strict'

angular.module 'brasFeApp'
.controller 'SessionCtrl', ($scope, $state, $stateParams, $timeout, sessionServ) ->
  #sessionServ.warm_up()

  $scope.form =
    submitted: false

  $scope.redirect = sessionServ.redirect

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
    k = !$scope.form.submitted and
    (form.$valid and !$scope.moeid_not_set())
    console.log k, 'aa'

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

  $scope.$on "redirect", (event, data)->
    $state.go(data)

  $scope.$on "httpError", (event)->
    $scope.form.submitted = false

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

  $scope.onTimeout = ()->
    $scope.form.password = ""
    $scope.form.password_confirmation = ""
    $scope.timer = $timeout($scope.onTimeout, 90000)

  $scope.timer = $timeout($scope.onTimeout, 90000)

  $scope.stop = ->
    $timeout.cancel($scope.timer)

  $scope.$on "$stateChangeStart",
  (event, toState, toParams, fromState, fromParams)->
    $scope.stop()
    $scope.form.submitted = false

