'use strict'

angular.module 'brasFeApp'
.controller 'TaskCtrl', ($scope, Restangular) ->

  $scope.$on "$viewContentLoaded", (event, viewConfig) ->
    console.log 'here'
    task = Restangular.all "task"
    task.all("list").getList().then (resp) ->
      $scope.task_list = resp

  $scope.$watch "task_token", (nv, ov)->
    return if !nv
    task = Restangular.all "task"
    task.one(nv.qid).get().then (resp) ->
      $scope.cur_task = resp
