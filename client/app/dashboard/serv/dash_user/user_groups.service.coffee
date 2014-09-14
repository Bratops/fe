"use strict"

angular.module "brasFeApp"
.service "userGroup", ($rootScope, sessionServ)->
  ret =
    init: false
    data:
      groups: []
      join:
        form: {}
        show: true
