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
    @$.$on "edus:detail:loaded", @_on_detail_loaded

  _on_detail_loaded: (e, d)->
    @st.go(@me.detail_route())

  watch:
    "data.type": (nv, ov)->
      @me.reload_list()
    "data.query": (nv, ov)->
      @me.reload_list()

  click: (item)->
    @me.load_detail(item)

