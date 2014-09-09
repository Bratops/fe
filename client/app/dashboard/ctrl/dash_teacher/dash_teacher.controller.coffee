'use strict'

angular.module 'brasFeApp'
.controller 'DashTeacherCtrl', ($scope, dashTeacher) ->

  $scope.data = dashTeacher.data
# groups
  $scope.group_new = ()->
    dashTeacher.data.groups.new = true

  $scope.group_add = ()->
    console.log "add"

  $scope.group_new_cancel = ()->
    $scope.data.groups.new = false

  $scope.open_calendar = (e)->
    e.preventDefault()
    e.stopPropagation()
    $scope.data.groups.exdate_opt.open = !$scope.data.groups.exdate_opt.open

  $scope.cal_disable = (date, mode)->
    dv = date.getDay()
    ((mode is "day") and ( dv is 0 || dv is 6 ))
