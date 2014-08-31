"use strict"

angular.module "brasFeApp"
.factory "sestangular", (Restangular) ->
  base_url = (host)->
    "http://#{host}/"

  rest: (user, host)->
    Restangular.withConfig (RestangularProvider) ->
      RestangularProvider.setBaseUrl base_url(host)
      RestangularProvider.setDefaultHttpFields
        cache: true,
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
