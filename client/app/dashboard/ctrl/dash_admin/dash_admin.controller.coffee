'use strict'

angular.module 'brasFeApp'
.controller 'DashAdminCtrl', ($scope, $state, dashUser, menu, sessionServ) ->
  session = sessionServ
  state_base = "dashboard.admin"

  reorder_menu_pos = (evt)->
    items = evt.source.nodesScope.$modelValue
    i = 0
    _.each items, (item)->
      item.pos = i
      i = i + 1

  menu_before_drag = (evt)->
    evt.$element.addClass("dragging")

  $scope.data =
    menu:
      serv: menu.data
      selected: {}
    menuTree:
      beforeDrag: menu_before_drag
      dropped: reorder_menu_pos
    users: {}
    edit_role: ""
  $scope.userGrid =
    data: "data.users"

# events
  $scope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams)->
    session.auth_state(event, toState)

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    return unless session.is_valid_state($state)
    if toState.name is "#{state_base}.users"
      dashUser.load_users()
    else if toState.name is "#{state_base}.tasks"
      dashUser.load_users()

  $scope.$on "users_loaded", ()->
    $scope.data.users = dashUser.users

  $scope.$watch "data.edit_role", (nv, ov)->
    if nv
      menu.get_menu_list nv

  $scope.$on "cfpLoadingBar:loading", (evt, data)->
    #console.log 'here lodaing', data

  $scope.not_in_base = ()->
    return false unless $scope.user?
    !$state.is("dashboard.#{$scope.user.role.name}")

# menus
  $scope.show_menu_item = (item_scope)->
    item = item_scope.$modelValue
    $scope.data.menu.selected = item

  $scope.menu_item_selected = (item)->
    $scope.data.menu.selected == item

  $scope.menu_cancel_edit = ()->
    $scope.data.menu.selected = {}
    $scope.data.menu.serv.raw = {}
    $state.go(state_base)

  $scope.menu_save = ()->
    menu.update_raw($scope.data.edit_role)

  $scope.menu_mark_as_remove = (scope)->
    item = scope.$modelValue
    item.destroy = !!!item.destroy

  $scope.menu_add = ()->
    rl = $scope.data.menu.serv.raw.length
    $scope.data.menu.serv.raw.push
      id: -1
      name: "New item"
      pos: rl
      nodes: []
