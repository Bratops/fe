"use strict"

angular.module "brasFeApp"
.factory "sestangular", (Restangular, Config) ->
  base_url = (host)->
    "http://#{host}/"

  rest: (user, opt)->
    opt.cache = if opt.cache? then opt.cache else true
    Restangular.withConfig (RestangularProvider) ->
      RestangularProvider.setBaseUrl base_url(Config.host)
      RestangularProvider.setDefaultHttpFields
        cache: opt.cache,
        withCredentials: true #allow cookies, sessions
      RestangularProvider.setRestangularFields
        id: "_id"
        route: "restangularRoute"
        selfLink: "self.href"
      RestangularProvider.setDefaultHeaders
        "Content-Type": "application/json",
        "X-AUTH-LOGIN": user.login_alias || "",
        "X-AUTH-TOKEN": user.auth_token || "",
        "X-Requested-With": "XMLHttpRequest",
        "Accept": "application/bebras.tw; ver=1"
