'use strict'

angular.module 'brasFeApp'
.factory "sestangular", (Restangular) ->
  get_val = (user, key)->
    if (key of user) 
      return user[key]
    else
      ""

  rest: (user)->
    Restangular.withConfig (RestangularProvider) ->
      RestangularProvider.setBaseUrl "http://bebras01.csie.ntnu.edu.tw/"
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
        "X-AUTH-LOGIN": get_val(user, "login_alias"),
        "X-AUTH-TOKEN": get_val(user, "auth_token"),
        "Accept": "application/bebras.tw; ver=1"
