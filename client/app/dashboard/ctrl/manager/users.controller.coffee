"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.UsersCtrl"
  inject:
    $scope: "$"
    managerUsers: "mu"

  _state_base: "dashboard.admin"

  init: ->
    @$.data = @mu.data

  load_user: (kind)->
    @$.list_mod = if kind is "teacher_applicant" then "ta" else ""
    @mu.load_users(kind)

  user_style: (user)->
    @$.data.mod

  watch:
    "data.pager.page": (nv, ov)->
      if nv != ov
        mu.load_users()
    "data.pager.per_page": (nv, ov)->
      if nv != ov and mu.data.mod isnt ""
        mu.load_users()

  is_teacher_applicant: (u)->
    u.role.name == "teacher_applicant"

  is_loading: ->
    @mu.data.loading || "no data"

  mark_teacher: (user)->
    @mu.mark_teacher(user)
