'use strict'

angular.module "brasFeApp"
.service "sessionServ", ($rootScope, $cookieStore, $state, sestangular, growl) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  notify = (data)->
    notifier = growl[data.status]
    msg = data.msg
    notifier msg.body, title: msg.title

  guest = {login_alias: "", auth_token: ""}

  ret =
    redirect: ""
    rest: sestangular.rest(guest).all ""
    init: false
    warm_up: ()->
      return if ret.init
      ret.init = true
      user = $cookieStore.get("tiny_beaver") || guest
      ret.set_user(user)
      try
        if ret.is_user
          ret.rest.one("").get().then (resp)->
            notify data
      catch e
        console.log e
      #console.log user
    is_user: false
    logout: ()->
      ret.rest.all("session").remove().then (resp)->
        notify resp
        $cookieStore.put("tiny_beaver", guest)
        ret.set_user(guest)
    sclist: (query)->
      ret.rest.all("group/publist/school").getList({query: query})
    set_user: (user)->
      ret.user = user
      ret.rest = sestangular.rest(user)
      if (!!ret.user and !!ret.user.login_alias and !!ret.user.auth_token)
        ret.is_user = true
      else
        ret.is_user = false
    request_link: (user)->
      if !user or !("login_alias" of user) or !(user.login_alias)
        notify { status: "error", msg: { title: "錯誤", body: "請先輸入賬號" }}
        return
      ret.rest.all("password/forget").post(user).then (resp)->
        notify resp
        if resp.status
          $rootScope.$broadcast "redirect", resp.redirect
    register: (data)->
      ret.rest.one("user").post("", {user: data}).then (resp)->
        ret._session_base(resp)
    login: (user)->
      ret.rest.one("session").post("", {user: user}).then (resp)->
        ret._session_base(resp)
    reset_pw: (data)->
      ret.rest.one("password/reset").put(data).then (resp)->
        ret._session_base(resp)
    _session_base: (data)->
      notify data
      fn = ret["_"+data.status]
      fn(data)
    _success: (data)->
      $cookieStore.put("tiny_beaver", data.user)
      ret.set_user(data.user)
      if data.redirect
        $rootScope.$broadcast "redirect", data.redirect
    _error: (obj)->
      $rootScope.$broadcast "sessionError"
      ret.set_user(guest)
    user:
      login_alias: ""
      auth_token: ""
    isGuest: ()->
      !ret.user.login_alias and !ret.user.auth_token
  ret

