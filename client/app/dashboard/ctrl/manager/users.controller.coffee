"use strict"

angular.module "brasFeApp"
.controller "manager.UsersCtrl", ($scope, managerUsers) ->
  mu = managerUsers
  $scope.data = mu.data

  $scope.load_user = (kind)->
    mu.load_users(kind)

  $scope.user_style = (user)->
    $scope.data.mod

  $scope.$watch "data.pager.page", (nv, ov)->
    if nv != ov
      mu.load_users()

  $scope.$watch "data.pager.per_page", (nv, ov)->
    if nv != ov and mu.data.mod isnt ""
      mu.load_users()

  $scope.is_teacher_applicant = (u)->
    u.role.name == "teacher_applicant"

  $scope.mark_teacher = (user)->
    mu.mark_teacher(user)
