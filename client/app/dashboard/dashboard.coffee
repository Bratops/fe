'use strict'

check_valid_role = ($timeout, $state, sessionServ, growl)->
  sessionServ.warm_up()
  user_role = sessionServ.user.role.name
  unless $state.includes("dashboard.#{user_role}.*")
    $timeout ->
      # TODO this hit 2, should be 1
      #growl.warning "沒有權限", "警告"
      $state.transitionTo("dashboard.#{user_role}")

dashboard_role = (role)->
  url: "/#{role}"
  templateUrl: "app/dashboard/view/base.html"
  onEnter: check_valid_role
  views:
    menu:
      templateUrl: "app/dashboard/view/menu.html"
      controller: "DashMenuCtrl"
    panel:
      templateUrl: "app/dashboard/view/#{role}.html"
      controller: "Dash#{role[0].toUpperCase() + role.slice(1)}Ctrl"

angular.module 'brasFeApp'
.config ($stateProvider) ->
  $stateProvider
  .state "dashboard",
    url: "/dashboard"
    abstract: true
    templateUrl: "app/dashboard/view/base.html"
    controller: "DashboardCtrl"
  .state "dashboard.admin", dashboard_role("admin")
  .state "dashboard.manager", dashboard_role("manager")
  .state "dashboard.teacher", dashboard_role("teacher")
  .state "dashboard.student", dashboard_role("student")
  .state "dashboard.user", dashboard_role("user")
