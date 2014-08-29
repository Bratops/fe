'use strict'

angular.module 'brasFeApp'
.service "sessionInjector", (sessionServ) ->
    sessionInjector = request: (config) ->
      unless sessionServ.isGuest()
        config.headers["x-auth-login"] = sessionServ.user.login_alias
        config.headers["x-auth-token"] = sessionServ.user.auth_token
      config
    sessionInjector
