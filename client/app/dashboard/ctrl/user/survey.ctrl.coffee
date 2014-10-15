"use strict"
angular.module("brasFeApp").classy.controller
  name: "user.SurveyCtrl"

  inject:
    $scope: "$"
    $state: "st"
    userSurvey: "us"

  init: ->
    @$.data = @us.data
    @$.$on "survey:finished", @_on_survey_finished
    @us.init()

  _on_survey_finished: ->
    @us.thanks()
    @st.go("dashboard.user")

  qtype_text: (qt)->
    return "(單選)" if qt is 0
    return "(複選)" if qt is 1

  is_single_choice: (q)->
    q.qtype is 0

  is_multi_choice: (q)->
    q.qtype is 1

  submit: ->
    @us.submit()
