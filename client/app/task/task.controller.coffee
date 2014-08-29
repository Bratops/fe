'use strict'

angular.module 'brasFeApp'
.controller 'TaskCtrl', ($scope, sessionServ, sestangular) ->
  sessionServ.check_local()
  ses = sessionServ

  $scope.$on "$viewContentLoaded", (event, viewConfig) ->
    task = ses.rest.all "task"
    task.all("list").getList().then (resp) ->
      $scope.task_list = resp

  $scope.$watch "task_token", (nv, ov)->
    return if !nv
    task = ses.rest.all "task"
    task.one(nv.qid).get().then (resp) ->
      $scope.cur_task = resp
