'use strict'

angular.module 'brasFeApp'
.service "sessionServ", (Restangular) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  rest = Restangular.all ""
  ret =
    redirect: ""
    sest: Restangular.all ""
    sclist: (query)->
      rest.all("group/publist/school").getList({query: query})
    update_token: (user)->
      this.ret.sest = Restangular.withConfig (RestangularConfigurer)->
        #RestangularConfigurer.setFullResponse(true)
        RestangularProvider.setDefaultHeaders
          "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest",
          "Accept": "application/bebras.tw; ver=1",
          "x-auth-login": user.login_alias,
          "x-auth-token": user.auth_token
    register: (data)->
      rest.all("user").post({user: data}).then (resp)->
        console.log resp.console
        if resp.success
          update_token(resp.user)
          this.redirect = resp.redirect
        else
          update_token({login_alias: "", auth_token: ""})
    user:
      login_alias: ""
      auth_token: ""
    isGuest: ()->
      !this.user.login_alias and !this.user.auth_token

.factory "sessionInjector", (SessionServ) ->
    sessionInjector = request: (config) ->
      unless SessionService.isGuest()
        config.headers["x-auth-login"] = SessionServ.user.login_alias
        config.headers["x-auth-token"] = SessionServ.user.auth_token
      config
    sessionInjector
