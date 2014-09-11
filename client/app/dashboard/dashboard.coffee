"use strict"

dash_router =
  base: (role)->
    url: ""
    templateUrl: "app/dashboard/view/base.html"
    views:
      menu:
        templateUrl: "app/dashboard/view/menu.html"
        controller: "DashMenuCtrl"
      panel:
        templateUrl: "app/dashboard/view/#{role}/base.html"
        controller: "Dash#{role[0].toUpperCase() + role.slice(1)}Ctrl"
  extend: (role, action)->
    base = dash_router.base(role)
    base.url = "/#{action}"
    base.views =
      box:
        templateUrl: "app/dashboard/view/#{role}/#{action}.html"
    base
  groups: (sub_action)->
    role = "teacher"
    base = dash_router.extend(role, "groups")
    base.url = "/:id/#{sub_action}"
    base.views =
      details:
        templateUrl: "app/dashboard/view/#{role}/groups/#{sub_action}.html"
        controller: "TeacherEnrollmentsCtrl"
    base
  magic: (role, action)->
    unless action?
      dash_router.base(role)
    else
      dash_router.extend(role, action)
  dash_admin: (action)->
    dash_router.magic "admin", action
  dash_teacher: (action)->
    dash_router.magic "teacher", action
  dash_manager: (action)->
    dash_router.magic "manager", action
  dash_student: (action)->
    dash_router.magic "student", action
  dash_user: (action)->
    dash_router.magic "user", action
  admin: "dashboard.admin"
  manager: "dashboard.manager"
  teacher: "dashboard.teacher"

dr = dash_router

angular.module 'brasFeApp'
.config ($stateProvider) ->
  $stateProvider
  .state "dashboard",
    url: "/dashboard"
    abstract: true
    templateUrl: "app/dashboard/view/base.html"
    controller: "DashboardCtrl"
  .state dr.admin, dr.dash_admin()
  .state "#{dr.admin}.users", dr.dash_admin("users")
  .state "#{dr.admin}.tasks", dr.dash_admin("tasks")
  .state "#{dr.admin}.menu", dr.dash_admin("menu")
  .state dr.manager, dr.base("manager")
  .state "#{dr.manager}.bulletin", dr.dash_manager("bulletin")
  .state dr.teacher, dr.dash_teacher()
  .state "#{dr.teacher}.groups", dr.dash_teacher("groups")
  .state "#{dr.teacher}.groups.enrollments", dr.groups("enrollments")
  .state "dashboard.student", dr.base("student")
  .state "dashboard.user", dr.base("user")
