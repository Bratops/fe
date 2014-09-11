"use strict"

angular.module "brasFeApp"
.controller "TeacherEnrollmentsCtrl", ($scope, $stateParams, studentEnrollments) ->
  state_base = "dashboard.teacher"
  $scope.data = studentEnrollments.data

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    $scope.data.gid = $stateParams.id
    #if toState.name is "#{state_base}.groups"
      #dashTeacher.load_groups()

  $scope.import_users = ()->
    console.log 'ok'
