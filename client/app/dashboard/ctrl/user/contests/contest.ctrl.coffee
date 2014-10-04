"use strict"
angular.module("brasFeApp").classy.controller
  name: "user.ContestCtrl"

  inject:
    $sce: "sce"
    $scope: "$"
    $state: "st"
    $window: "wnd"
    userContests: "ucs"

  init: ->
    @ucs.load_one()
    @$.data = @ucs.data
    @$.$on "$stateChangeStart", @_on_state_change
    @$.$on "contest:not_found", @_on_contest_not_found
    @$.$on "contest:finished", @_on_contest_finished
    @$.$on "timer-stopped", @_on_timer_stopped
    old = window.onbeforeunload
    @$.$on "$destroy", ->
      window.onbeforeunload = old
    window.onbeforeunload = (e)->
      #"尚未完成測驗，確定離開？"

  _on_state_change: (event, toState, toParams, fromState, fromParams)->
    if toState.name.indexOf("contest") < 0
      unless confirm("尚未完成測驗，確定離開？")
        event.preventDefault()

  _on_timer_stopped: (e, d)->
    @ucs.data.cur_task.timespan += d.millis
    @ucs.next()
    @$.$broadcast("timer-start")

  next: ->
    @ucs.data.cur_task.submit = "next"
    @$.$broadcast('timer-stop')

  submit: ->
    @ucs.data.cur_task.submit = "submit"
    @$.$broadcast('timer-stop')

  skip: ->
    @ucs.data.cur_task.submit = "drop"
    @$.$broadcast('timer-stop')

  _on_contest_not_found: ->
    @st.go("^.contests")

  _on_contest_finished: ->
    @st.go("^.contests")

  trust: (html)->
    @sce.trustAsHtml html

  trust_choice: (sid)->
    cho = @ucs.data.cur_task.choices[sid]
    @$.trust cho.content

  click: (sid)->
    cho = @ucs.data.cur_task.choices[sid]
    if @ucs.data.cur_task.select is cho
      @ucs.data.cur_task.select = null
    else
      @ucs.data.cur_task.select = cho

  clicked: (sid)->
    cho = @ucs.data.cur_task.choices[sid]
    return "clicked" if @ucs.data.cur_task.select is cho
    ""

  hover_rating: (v)->
    @ucs.data.cur_task.hrating = v

  leave_rating: ->
    @ucs.data.cur_task.hrating = null

  rating_text: ->
    @ucs.rating_text()

  no_rating: ->
    !@ucs.data.cur_task.rating?

  submittable: ->
    no_select = !@ucs.data.cur_task.select?
    @$.no_rating() or no_select

  task_info: ->
    ts = @ucs.data.cur_task.timespan
    sk = @ucs.data.cur_task.skip
    ts = moment.duration(ts)
    "t: #{ts.minutes()}:#{ts.seconds()}, s: #{sk}, "

  random_bg: ->
    rba = ["gf", "cp", "re", "sc"]
    if @ucs.data.cur_task.seed?
      se = @ucs.data.cur_task.seed[0]
      rba[se]

