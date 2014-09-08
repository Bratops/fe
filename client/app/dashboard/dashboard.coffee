"use strict"

dashboard_role = (role)->
  url: ""
  templateUrl: "app/dashboard/view/base.html"
  views:
    menu:
      templateUrl: "app/dashboard/view/menu.html"
      controller: "DashMenuCtrl"
    panel:
      templateUrl: "app/dashboard/view/#{role}.html"
      controller: "Dash#{role[0].toUpperCase() + role.slice(1)}Ctrl"

dash_extend = (role, action)->
  base = dashboard_role(role)
  base.url = "/#{action}"
  base.views =
    box:
      templateUrl: "app/dashboard/view/#{role}/#{action}.html"
      controller: "Dash#{role[0].toUpperCase() + role.slice(1)}Ctrl"
  base

st =
  admin: "dashboard.admin"
angular.module 'brasFeApp'
.config ($stateProvider) ->
  $stateProvider
  .state "dashboard",
    url: "/dashboard"
    abstract: true
    templateUrl: "app/dashboard/view/base.html"
    controller: "DashboardCtrl"
  .state st.admin, dashboard_role("admin")
  .state "#{st.admin}.users", dash_extend("admin", "users")
  .state "#{st.admin}.tasks", dash_extend("admin", "tasks")
  .state "#{st.admin}.menu", dash_extend("admin", "menu")
  .state "dashboard.manager", dashboard_role("manager")
  .state "dashboard.teacher", dashboard_role("teacher")
  .state "dashboard.student", dashboard_role("student")
  .state "dashboard.user", dashboard_role("user")
