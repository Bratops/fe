"use strict"
angular.module("brasFeApp").classy.controller
  name: "user.ContestCtrl"

  inject:
    $scope: "$"
    $state: "st"
    userContests: "ucs"

  init: ()->
    @$.data = @ucs.data
    @$.$on "contest:not_found", @_on_contest_not_found
    @ucs.load_one()

  _on_contest_not_found: ()->
    @st.go("^.contests")
