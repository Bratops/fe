'use strict'

angular.module 'brasFeApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'task',
    url: '/task'
    templateUrl: 'app/task/task.html'
    controller: 'TaskCtrl'
