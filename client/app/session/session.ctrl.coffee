"use strict"
angular.module("brasFeApp").classy.controller
  name: "SessionCtrl"
  inject:
    $scope: "$"
    $state: "st"
    $stateParams: "sp"
    $timeout: "timeout"
    $location: "loc"
    Config: "config"
    sessionServ: "session"

  init: ->
    #@session.warm_up()
    @$.form =
      clear_time: 90000
      submitted: false
    @$.$on "$stateChangeStart", @_on_state_change
    @$.$on "$stateChangeSuccess", @_on_state_arrival
    @$.$on "$viewContentLoaded", @_on_view_loaded
    @$.$on "redirect", @_on_redirect
    @$.$on "httpError", @_on_http_error
    @$.timer = @timeout(@onTimeout, @$.form.clear_time)

  onTimeout: ->
    @$.form.password = ""
    @$.form.password_confirmation = ""
    @$.timer = @timeout(@onTimeout, @$.form.clear_time)

  stop: ->
    @timeout.cancel(@$.timer)

  _on_state_change: (event, toState, toParams, fromState, fromParams)->
    @$.stop()
    @$.form.submitted = false

  _on_state_arrival: (event, toState, toParams, fromState, fromParams)->
    if toState.name is "session.auth"
      @session.auth(@sp)
    else if toState.name is "session.gauth"
      @session.gauth(@sp)

  _on_redirect: (event, data)->
    if data is "dashboard"
      rn = if @session.user.role then @session.user.role.name else "user"
      @st.go(data + "." + rn)

  _on_http_error: (event)->
    @$.form.submitted = false

  _on_view_loaded: (event)->
    rpt = "reset_password_token"
    if @st.current.name is "session.reset"
      if !(rpt of @sp) or !@sp[rpt] or @sp[rpt] is "true"
        @st.go("landing")

  watch:
    school: (nv, ov)->
      valid = nv? and (typeof nv is "object") and ("moeid" of nv)
      @$.form.moeid = if valid then nv.moeid else null

  reset: ()->
    @$.form.submitted = true
    oc = _.clone @$.form
    obj = _.extend(oc, @sp)
    @session.reset_pw(obj)

  register: (form)->
    @$.form.submitted = true
    @session.register(@$.form)

  login: ()->
    @$.form.submitted = true
    data = _.clone(@$.form)
    if data.moeid?
      data.login_alias = "#{data.moeid}-#{data.login_alias}"
    @session.login(data)

  aquire_new_pw: ()->
    @session.request_link(@$.form)

  moeid_not_set: ()->
    !("moeid" of @$.form) or !@$.form.moeid

  get_school_list: (query)->
    @session.sclist(query).then (resp) ->
      resp

  password_matched: (form)->
    form.password == form.password_confirm

  loginable: (form)->
    !@$.form.submitted and (form.$valid)

  resetable: (form)->
    !@$.form.submitted and
    (form.$valid and !@$.password_matched(form))

  registerable: (form)->
    !@$.form.submitted and
    (form.$valid and !@$.moeid_not_set())

  auth: (provider)->
    @$.form.submitted = true
    base = "http://#{@config.host}"
    window.location.href = "#{base}/users/auth/#{provider}"
