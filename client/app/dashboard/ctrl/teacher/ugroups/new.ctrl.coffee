"use strict"
angular.module("brasFeApp").classy.controller
  name: "teacher.ugroups.NewCtrl"

  inject:
    $scope: "$"
    $state: "st"
    teacherUgroup: "m"

  _teacher_ugroup_created: (e, d)->
    @st.go("dashboard.teacher.ugroups")
    @m.new()

  init: ->
    @$.data = @m.data
    @m.init()
    @$.$on "teacher:ugroup:created", @_teacher_ugroup_created

  create: (form)->
    @m.create() if form.$valid
    #enroll_form.$setDirty()

  is_edit: ->
    false

