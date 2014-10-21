"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.EdusCtrl"

  inject:
    $scope: "$"
    $state: "st"
    managerEdus: "me"

  init: ->
    @$.data = @me.data
    @me.load()

  watch:
    "data.type": (nv, ov)->
      @me.reload_list()
    "data.query": (nv, ov)->
      @me.reload_list()

