"use strict"
angular.module("brasFeApp").classy.controller
  name: "user.GroupsCtrl"

  inject:
    $scope: "$"
    $state: "st"
    userGroup: "ug"

  init: ()->
    @$.data = @ug.data
    @$.$on "$stateChangeSuccess", @_scs

  _scs: (event, toState, toParams, fromState, fromParams)->
    ""

  join_form_visible: ()->
    @ug.data.join.show

  join_grp: (form)->
    @ug.data.join.show = !@ug.data.join.show
    unless @ug.data.join.show
      form.$setPristine()
      @$.school = ""
      @ug.new_join()

  cancel: (form)->
    @$.join_grp(form)

  get_school_list: (query)->
    @ug.sclist(query).then (resp) ->
      resp

  watch:
    "{object}school": (nv, ov)->
      uf = @ug.data.join.form
      if (typeof nv is "string")
        delete uf.moeid
      if nv and (typeof nv is "object") and "moeid" of nv
        uf.moeid = nv.moeid

  set_moeid: (item, model, form)->
    uf = @ug.data.join.form
    uf.moeid = item.moeid

  field_not_set: (field, form)->
    uf = @ug.data.join.form
    unset = !(field of uf and uf[field]?)
    unset and !form[field].$pristine

  join: (form)->
    @ug.join()
