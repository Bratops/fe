"use strict"

capital = (name)->
  name[0].toUpperCase() + name.slice(1)

dash_router =
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
    base = dash_router.base(role)
    base.parent = "dashboard.#{role}"
    base.url = "/#{action}"
    base.views =
      box:
        templateUrl: "app/dashboard/view/#{role}/#{action}.html"
    base
  groups: (sub_action)->
    role = "teacher"
    base = dash_router.extend(role, "groups")
    base.parent = "dashboard.#{role}.groups"
    base.url = "/:id/#{sub_action}"
    base.views =
      details:
        templateUrl: "app/dashboard/view/#{role}/groups/#{sub_action}.html"
        controller: "DaTeEnrollmentsCtrl"
    base
  magic: (role, action)->
    unless action?
      dash_router.base(role)
    else
      st = dash_router.extend(role, action)
      roles = ["manager", "teacher", "user"]
      if _.include(roles, role)
        ctrl = "Da#{capital(role.substr(0,2))}#{capital(action)}Ctrl"
        st.views.box.controller = ctrl
      st
  m: (r, a)->
    dash_router.magic(r, a)
  admin:   "dashboard.admin"
  manager: "dashboard.manager"
  teacher: "dashboard.teacher"
  student: "dashboard.student"
  user:    "dashboard.user"
  dbmain:
    url: "dashboard"
    parent: "root"
    abstract: true
    views:
      main:
        templateUrl: "app/dashboard/view/base.html"
        controller: "DashboardCtrl"

dr = dash_router

# order is important
angular.module 'brasFeApp'
.config ($stateProvider) ->
  $stateProvider
  .state "dashboard", dr.dbmain
  .state dr.student,  dr.m("student")
  .state dr.user, dr.m("user")
  .state "#{dr.user}.groups", dr.m("user", "groups")
  .state dr.teacher, dr.m("teacher")
  .state "#{dr.teacher}.groups", dr.m("teacher", "groups")
  .state "#{dr.teacher}.groups.enrollments", dr.groups("enrollments")
  .state dr.manager, dr.m("manager")
  .state "#{dr.manager}.bulletin", dr.m("manager", "bulletin")
  .state "#{dr.manager}.users", dr.m("manager", "users")
  .state dr.admin, dr.m("admin")
  .state "#{dr.admin}.users", dr.m("admin", "users")
  .state "#{dr.admin}.tasks", dr.m("admin", "tasks")
  .state "#{dr.admin}.menu",  dr.m("admin", "menu")
