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
        controller: "#{role}.baseCtrl"
  extend: (role, action)->
    url: "/#{action}"
    parent: "dashboard.#{role}"
    views:
      box:
        templateUrl: "app/dashboard/view/#{role}/#{action}.html"
        controller: class_ctrl_form(role, action)
  sub: (role, sub, sub_action)->
    url = if sub_action is "new" then "/#{sub_action}" else "/:id/#{sub_action}"
    url: url
    parent: "dashboard.#{role}.#{sub}"
    views:
      scroll:
        templateUrl: "app/dashboard/view/#{role}/#{sub}/#{sub_action}.html"
        controller: subclass_ctrl_form(role, sub, sub_action)

dr = dash_router

dr.action = (role, action)->
  unless action?
    dr.base(role)
  else
    dr.extend(role, action)

dr.mk_route = (role, action, sub)->
  rt = "dashboard.#{role}"
  rt += if action? then ".#{action}" else ""
  rt += if sub? then ".#{sub}" else ""
  rt

dr.gt_state = (role, action, sub)->
  if sub?
    dr.sub(role, action, sub)
  else if action?
    dr.action(role, action)
  else
    dr.base(role)

dr.mk_state = (stp, role, action, sub)->
  route = dr.mk_route(role, action, sub)
  state = dr.gt_state(role, action, sub)
  stp.state route, state

dr.ms = (stp, role, action, sub)->
  dr.mk_state(stp, role, action, sub)

# order is important
angular.module 'brasFeApp'
.config ($stateProvider) ->
  s = $stateProvider.state "dashboard", dr.dbmain
  state = (role, action, sub)->
    dr.ms s, role, action, sub
  state "teacher"
  state "teacher", "personal"
  state "teacher", "groups"
  state "teacher", "groups", "enrollments"
  state "teacher_applicant"
  state "user"
  #state "user", "groups"
  state "user", "contests"
  state "user", "contest"
  state "user", "survey"
  state "user", "scores"
  state "manager"
  state "manager", "bulletin"
  state "manager", "edus"
  state "manager", "edus", "details"
  state "manager", "users"
  state "manager", "files"
  state "manager", "tasks"
  state "manager", "tasks", "new"
  state "manager", "tasks", "edit"
  state "manager", "contests"
  state "manager", "contests", "new"
  state "manager", "contests", "edit"
  state "manager", "surveys"
  state "manager", "surveys", "new"
  state "manager", "surveys", "edit"
  state "admin"
  state "admin", "users"
  state "admin", "tasks"
  state "admin", "menu"
