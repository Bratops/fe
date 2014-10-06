"use strict"
angular.module("brasFeApp").classy.controller
  name: "user.ScoresCtrl"

  inject:
    $scope: "$"
    $state: "st"
    userScores: "u"

  init: ()->
    @$.data = @u.data
    @u.init()

