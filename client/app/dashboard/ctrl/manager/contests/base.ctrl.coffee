"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.ContestsCtrl"
  inject:
    $scope: "$"
    $state: "st"
    managerContests: "mc"

  _on_contest_created: (e, d)->
    @mc.data.contests.push d
    @st.go("^")

  init: ->
    @$.data = @mc.data
    @$.$on "contest:created", @_on_contest_created
    @mc.load()

  remove: (cn)->
    if(confirm("確定移除？"))
      @mc.remove(cn)

  edit: (cn)->
    if @st.includes("**.contests.new") or @st.includes("**.contests.edit")
      @st.go("^.edit", {id: cn.id})
    else
      @st.go(".edit", {id: cn.id})
