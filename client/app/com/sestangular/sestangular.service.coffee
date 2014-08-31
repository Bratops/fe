"use strict"

angular.module "brasFeApp"
.factory "sestangular", (Restangular) ->
  base_url = (host)->
    "http://#{host}/"
  get_val = (user, key)->
    if (key in user)
      return user[key]
    else
      ""

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
        "X-Requested-With": "XMLHttpRequest",
        "Accept": "application/bebras.tw; ver=1",
        "X-AUTH-LOGIN": get_val(user, "login_alias"),
        "X-AUTH-TOKEN": get_val(user, "auth_token"),
