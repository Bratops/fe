"use strict"

capital = (name)->
  name[0].toUpperCase() + name.slice(1)

plain_ctrl_form = (role, action)->
  "Da#{capital(role.substr(0,2))}#{capital(action)}Ctrl"

class_ctrl_form = (role, action)->
  "#{role}.#{capital(action)}Ctrl"

subclass_ctrl_form = (role, sub, sub_action)->
  "#{role}.#{sub}.#{capital(sub_action)}Ctrl"

dash_router =
  dbmain:
    url: "dashboard"
    parent: "root"
    abstract: true
    views:
      main:
        templateUrl: "app/dashboard/view/base.html"
        controller: "DashboardCtrl"
  base: (role)->
    url: ""
    templateUrl: "app/dashboard/view/base.html"
    parent: "dashboard"
    views:
      menu:
        templateUrl: "app/dashboard/view/menu.html"
        controller: "DashMenuCtrl"
      panel:
        templateUrl: "app/dashboard/view/#{role}/base.html"
        controller: "Dash#{capital(role)}Ctrl"
  extend: (role, action)->
    url: "/#{action}"
    parent: "dashboard.#{role}"
    views:
      box:
        templateUrl: "app/dashboard/view/#{role}/#{action}.html"
        #TODO generalize ctrls here
  sub: (role, sub, sub_action)->
    url = if sub_action is "/new" then sub_action else "/:id/#{sub_action}"
    url: url
    parent: "dashboard.#{role}.#{sub}"
    views:
      scroll:
        templateUrl: "app/dashboard/view/#{role}/#{sub}/#{sub_action}.html"
        controller: subclass_ctrl_form(role, sub, sub_action)
  magic: (role, action, _ctrl_form)->
    unless action?
      dash_router.base(role)
    else
      st = dash_router.extend(role, action)
      roles = ["manager", "teacher", "user"]
      #TODO remove after refactor
      if _.include(roles, role)
        ctrl = _ctrl_form(role, action)
        st.views.box.controller = ctrl
      st
  m: (r, a)->  #TODO remove after refactor
    dash_router.magic(r, a, class_ctrl_form)
  mk_route: (role, action, sub)->
    rt = "dashboard.#{role}"
    rt += if action? then ".#{action}" else ""
    rt += if sub? then ".#{sub}" else ""
    rt
  gt_state: (role, action, sub)->
    if sub?
      dash_router.sub(role, action, sub)
    else if action?
      dash_router.m(role, action)
    else
      dash_router.base(role)
  mk_state: (stp, role, action, sub)->
    route = dash_router.mk_route(role, action, sub)
    state = dash_router.gt_state(role, action, sub)
    stp.state route, state
  ms: (stp, role, action, sub)->
    dash_router.mk_state(stp, role, action, sub)

dr = dash_router

# order is important
angular.module 'brasFeApp'
.config ($stateProvider) ->
  s = $stateProvider.state "dashboard", dr.dbmain
  state = (role, action, sub)->
    dr.ms s, role, action, sub
  state "student"
  state "user"
  state "user", "groups"
  state "teacher"
  state "teacher", "groups"
  state "teacher", "groups", "enrollments"
  state "manager"
  state "manager", "bulletin"
  state "manager", "users"
  state "manager", "tasks"
  state "manager", "tasks", "new"
  state "admin"
  state "admin", "users"
  state "admin", "tasks"
  state "admin", "menu"
