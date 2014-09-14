"use strict"

angular.module "brasFeApp"
.controller "DaUsGroupsCtrl", ($scope, $state, userGroup) ->
  state_base = "dashboard.user"
  ug = userGroup
  $scope.data = ug.data

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    ""
    #if $state.is "#{state_base}"
      #console.log sessionServ.user

  $scope.join_form_visible = ()->
    ug.data.join.show

  $scope.join_grp = ()->
    ug.data.join.show = !ug.data.join.show
