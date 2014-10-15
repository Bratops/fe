"use strict"
angular.module("brasFeApp").classy.controller
  name: "user.ContestsCtrl"

  inject:
    $scope: "$"
    $state: "st"
    userContests: "ucs"

  init: ()->
    @$.data = @ucs.data
    @ucs.init()
    @$.$on "contest:ready", @_on_contest_ready
    @$.$on "contest:survey", @_on_contest_survey

  _on_contest_survey: ->
    dbc = "dashboard.user.survey"
    @ucs.reset()
    @st.go(dbc)

  _on_contest_ready: ->
    @st.go("^.contest")

  do_contest: (cn)->
    if confirm("確定後,開始計時")
      @ucs.data.contest = cn
      @ucs.load_one()

