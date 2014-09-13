"use strict"

angular.module "brasFeApp"
.controller "DaMaBulletinCtrl", ($scope, bulletin) ->
  state_base = "dashboard.manager.bulletin"
  $scope.data = bulletin.data

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    bulletin.load()
    #if toState.name is "#{state_base}.bulletin"

  $scope.$watch "data.msg.start_time", (nv, ov)->
    bulletin.ensure_end(nv)

  $scope.msg_editor_visible = ()->
    $scope.data.new || $scope.data.edit

  $scope.cancel_editor = ()->
    $scope.data.new = false
    $scope.data.edit = false
    bulletin.cancel_edit()

  $scope.new_msg = ()->
    $scope.data.new = true
    $scope.data.edit = false
    bulletin.set_msg()

  $scope.del_msg = (msg)->
    if(confirm("確定移除？"))
      bulletin.del_msg(msg)

  $scope.edit_msg = (msg)->
    $scope.data.new = false
    $scope.data.edit = true
    bulletin.set_msg(msg)

  $scope.add_msg = ()->
    $scope.data.new = false
    bulletin.add_msg()

  $scope.update_msg = ()->
    $scope.data.edit = false
    bulletin.update_msg()

  $scope.open_calendar = (e, key)->
    e.preventDefault()
    e.stopPropagation()
    if key is "edate_opt"
      $scope.data[key].minDate = $scope.data.msg.start_time
    $scope.data[key].open = !$scope.data[key].open

  $scope.msg_start_cal_disable = (date, mode)->
    false

  $scope.msg_end_cal_disable = (date, mode)->
    false
