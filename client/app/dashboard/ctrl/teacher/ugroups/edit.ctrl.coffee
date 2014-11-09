"use strict"
angular.module("brasFeApp").classy.controller
  name: "teacher.ugroups.EditCtrl"

  inject:
    $scope: "$"
    $state: "st"
    teacherUgroup: "m"

  _teacher_ugroup_updated: (e, d)->
    @st.go("dashboard.teacher.ugroups")
    @m.new()

  _status_changed: (event, toState, toParams, fromState, fromParams)->
    @m.load_ugroup(toParams.id, true)

  init: ->
    @$.data = @m.data
    @m.init()
    @$.$on "$stateChangeSuccess", @_status_changed
    @$.$on "teacher:ugroup:updated", @_teacher_ugroup_updated

  update: (form)->
    @m.update() if form.$valid

  reset_pass: ->
    @m.reset_pass()

  is_edit: ->
    true

