'use strict'

angular.module "brasFeApp"
.service "sessionServ", ($rootScope, $cookieStore, $state, sestangular, growl) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  notify = (data)->
    notifier = growl[data.status]
    msg = data.msg
    notifier msg.body, title: msg.title

  guest =
    login_alias: ""
    auth_token: ""
    roles: []
    role:
      name: "guest"
      id: 1

  fb_auth = ()->

  ret =
    init: false
    is_user: false
    user:
      login_alias: ""
      auth_token: ""
    redirect: ""
    rest: sestangular.rest(guest, {})
    fest: ()->
      opt =
        cache: false
      sestangular.rest(ret.user, opt)
    validate: ()->
      if ret.is_user
        ret.rest.one("").get().then (resp)->
          notify data
    warm_up: ()->
      return if ret.init
      ret.init = true
      user = $cookieStore.get("tiny_beaver") || guest
      ret.set_user(user)
      #try
      #  ret.validate()
      #catch e
      #  console.log e
      #console.log user
    update_session: (user)->
      rest = sestangular.rest(user, {})
      rest.one("session").get("").then (resp)->
        ret._session_base(resp)
    gauth: (data)->
      ret.update_session
        login_alias: data.login
        auth_token: data.key
    auth: (data)->
      tar = "users/auth/#{data.provider}/callback"
      ret.rest.all(tar).get("", data).then (resp)->
        ret._session_base(resp)
    logout: ()->
      ret.rest.all("session").remove().then (resp)->
        notify resp
        $cookieStore.put("tiny_beaver", guest)
        ret.set_user(guest)
    sclist: (query)->
      ret.rest.all("group/publist/school").getList({query: query})
    set_user: (user)->
      ret.user = user
      ret.rest = sestangular.rest(user, {})
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
      console.log '------------>', user
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
      ret.set_user(guest)
      $rootScope.$broadcast "sessionError"
    isGuest: ()->
      !ret.user.login_alias and !ret.user.auth_token
    switch_role: (id)->
      growl.warning "請稍後。。。", title: "轉換中"
      ret.fest().all("session/role").get("", {role_id: id}).then (resp)->
        ret._session_base(resp)
        $rootScope.$broadcast "role_switched"
    base_state: () ->
      role = ret.user.role
      "dashboard.#{role.name}"
    is_valid_state: ($state)->
      $state.includes("#{ret.base_state()}.**")
    auth_user: (tos, $state)->
      role = ret.user.role.name
      orole = tos.replace(/dashboard.(\w+).*/i, "$1")
      if orole isnt "landing" and orole isnt role
        st = $state.get(tos.replace(orole, role))
        if st?
          $state.go(st)
        else
          $state.go("dashboard.#{role}")
    auth_state: (e, tos)->
      role = ret.user.role.name
      orole = tos.replace(/dashboard.(\w+).*/i, "$1")
      if orole isnt "landing" and orole isnt role
        e.preventDefault()
  ret

