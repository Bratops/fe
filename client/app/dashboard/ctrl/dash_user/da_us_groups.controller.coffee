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

  $scope.join_grp = (form)->
    ug.data.join.show = !ug.data.join.show
    unless ug.data.join.show
      form.$setPristine()
      $scope.school = ""
      ug.new_join()

  $scope.cancel = (form)->
    $scope.join_grp(form)

  $scope.get_school_list = (query)->
    ug.sclist(query).then (resp) ->
      resp

  $scope.$watch "school", (nv, ov)->
    uf = ug.data.join.form
    if (typeof nv is "string")
      delete uf.moeid
    if nv and (typeof nv is "object") and "moeid" of nv
      uf.moeid = nv.moeid

  $scope.set_moeid = (item, model, form)->
    uf = ug.data.join.form
    uf.moeid = item.moeid

  $scope.field_not_set = (field, form)->
    uf = ug.data.join.form
    unset = !(field of uf and uf[field]?)
    unset and !form[field].$pristine

  $scope.join = (form)->
    ug.join()
