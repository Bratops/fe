"use strict"
angular.module "brasFeApp"
.controller "teacher.GroupsCtrl", ($scope, dashTeacher) ->
  state_base = "dashboard.teacher"
  $scope.data = dashTeacher.data

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    dashTeacher.load_groups()

# groups
  $scope.group_new = ()->
    ddg = dashTeacher.data.groups.new
    dashTeacher.data.groups.new = !ddg

  $scope.cant_add_group = (form)->
    ($scope.data.groups.new_submitted or form.$invalid)

  $scope.cant_update_group = (form)->
    ($scope.data.groups.edit_submitted or form.$invalid)

  $scope.group_update = (form)->
    $scope.data.groups.edit = false
    dashTeacher.update_group()
    form.$setPristine();

  $scope.group_add = (form)->
    $scope.data.groups.new = false
    dashTeacher.add_group()
    form.$setPristine();

  $scope.del_group = (g)->
    if(confirm("確定移除？"))
      dashTeacher.del_group(g)

  $scope.group_new_cancel = ()->
    $scope.data.groups.new_submitted = false
    $scope.data.groups.new = false
    $scope.data.groups.edit = false

  $scope.open_calendar = (e)->
    e.preventDefault()
    e.stopPropagation()
    $scope.data.groups.exdate_opt.open = !$scope.data.groups.exdate_opt.open

  $scope.group_exdate_cal_disable = (date, mode)->
    dv = date.getDay()
    ((mode is "day") and ( dv is 0 || dv is 6 ))

  $scope.form_invalid = (field)->
    field.$invalid && !field.$pristine

  $scope.reload_groups = ()->
    dashTeacher.load_groups(true)

  $scope.klass_str = (k)->
    dg = dashTeacher.find_local(k, "klasses")
    dg.name

  $scope.extime_str = (k)->
    dg = dashTeacher.find_local(k, "time_sec")
    dg.name

  $scope.edit_group = (g)->
    dgu = $scope.data.groups.edit
    $scope.data.groups.edit = !dgu
    unless dgu
      dashTeacher.edit_group(g)

