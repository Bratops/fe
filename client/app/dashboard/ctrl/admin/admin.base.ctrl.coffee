"use strict"
angular.module("brasFeApp").classy.controller
  name: "admin.baseCtrl"
  inject:
    $scope: "$"
    $state: "st"
    dashUser: "du"
    menu: "menu"
    sessionServ: "session"

  _state_base: "dashboard.admin"

  init: ->
    @$.data =
      menu:
        serv: @menu.data
        selected: {}
      menuTree:
        beforeDrag: @_menu_before_drag
        dropped: @_reorder_menu_pos
      users: {}
      edit_role: ""

    @$.userGrid =
      data: "data.users"

    @$.$on "$stateChangeStart", @_sc_start
    @$.$on "$stateChangeSuccess", @_sc_succ
    @$.$on "users_loaded", @_evt_users_loaded

  _sc_start: (event, toState, toParams, fromState, fromParams)->
    @session.auth_state(event, toState.name)

  _sc_succ: (event, toState, toParams, fromState, fromParams)->
    return unless @session.is_valid_state(@st)
    if toState.name is "#{@_state_base}.users"
      @du.load_users()
    else if toState.name is "#{@_state_base}.tasks"
      @du.load_users()

  _evt_users_loaded: ()->
    @$.data.users = @du.users

  _reorder_menu_pos: (evt)->
    items = evt.source.nodesScope.$modelValue
    i = 0
    _.each items, (item)->
      item.pos = i
      i = i + 1

  _menu_before_drag: (evt)->
    evt.$element.addClass("dragging")

  watch:
    "data.edit_role": (nv, ov)->
      if nv
        @menu.get_menu_list nv

  not_in_base: ()->
    return false unless @$.user?
    !@st.is("dashboard.#{@$.user.role.name}")

# menus
  show_menu_item: (item_scope)->
    item = item_scope.$modelValue
    @$.data.menu.selected = item

  menu_item_selected: (item)->
    @$.data.menu.selected == item

  menu_cancel_edit: ()->
    @$.data.menu.selected = {}
    @$.data.menu.serv.raw = {}
    @st.go(state_base)

  menu_save: ()->
    @menu.update_raw(@$.data.edit_role)

  menu_mark_as_remove: (scope)->
    item = scope.$modelValue
    item.destroy = !!!item.destroy

  menu_add: ()->
    rl = @$.data.menu.serv.raw.length
    @$.data.menu.serv.raw.push
      id: -1
      name: "New item"
      pos: rl
      nodes: []
