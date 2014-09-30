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

  do_contest: (cn)->
    if confirm("確定後,開始計時")
      @ucs.data.contest = cn
      @st.go("^.contest")
