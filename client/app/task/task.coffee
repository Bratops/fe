'use strict'

angular.module 'brasFeApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'tasks',
    url: '/tasks'
    templateUrl: 'app/task/task.html'
    controller: 'TaskCtrl'
