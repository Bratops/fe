'use strict'

angular.module 'brasFeApp'
.controller 'DashManagerCtrl', ($scope, bulletin) ->
  $scope.data = bulletin.data

  $scope.$watch "data.msg.start", (nv, ov)->
    bulletin.ensure_end(nv)

  $scope.msg_editor_visible = ()->
    $scope.data.new || $scope.data.edit

  $scope.cancel_editor = ()->
    $scope.data.new = false
    $scope.data.edit = false
    bulletin.cancel_edit()

  $scope.new_msg = ()->
    $scope.data.new = true

  $scope.edit_msg = ()->
    $scope.data.edit = true

  $scope.add_msg = ()->
    bulletin.add_msg()

  $scope.open_calendar = (e, key)->
    e.preventDefault()
    e.stopPropagation()
    if key is "edate_opt"
      $scope.data[key].minDate = $scope.data.msg.start
    $scope.data[key].open = !$scope.data[key].open

  $scope.msg_start_cal_disable = (date, mode)->
    false

  $scope.msg_end_cal_disable = (date, mode)->
    #ds = $scope.data.msg.start
    #((mode is "day") and date < ds )
    false
