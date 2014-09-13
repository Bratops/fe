"use strict"

angular.module "brasFeApp"
.controller "DaMaUsersCtrl", ($scope, managerUsers) ->
  mu = managerUsers
  $scope.data = mu.data

  $scope.teachers = ()->
    mu.load_users("teacher")

  $scope.students = ()->
    mu.load_users("student")

  $scope.user_style = (user)->
    $scope.data.mod

  $scope.$watch "data.pager.page", (nv, ov)->
    if nv != ov
      mu.load_users()

  $scope.$watch "data.pager.per_page", (nv, ov)->
    if nv != ov and mu.data.mod isnt ""
      mu.load_users()
