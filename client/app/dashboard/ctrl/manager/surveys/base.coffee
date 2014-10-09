"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.SurveysCtrl"
  inject:
    $scope: "$"
    $state: "st"
    managerSurveys: "ms"

  init: ->
    @$.data = @ms.data
    @ms.init()
    @$.$on "survey:removed", @_on_survey_created
    @$.$on "survey:updated", @_on_survey_created
    @$.$on "survey:edit:loaded", @_on_survey_edit_loaded

  _on_survey_edit_loaded: (e, d)->
    @st.go(@ms.sbo("edit"), {id: d})

  _on_survey_created: ->
    @ms.reload_surveys()
    @st.go @ms.data.sb

  new_survey: ->
    @ms.new()
    @st.go @ms.sbo("new")

  edit_survey: (sv)->
    @ms.edit(sv.id)

  remove_survey: (sv)->
    if confirm("Sure?")
      @ms.remove(sv.id)

  set_by_hover: (item)->
    return unless @ms.data.preview
    @ms.data.survey = item

  set_by_click: (item)->
    @ms.data.survey = item

  toggle_preview: ->
    @ms.data.preview = !@ms.data.preview

  show_brief: ->
    @st.is("dashboard.manager.surveys") && @ms.data.survey?

  quest_class: (q)->
    return "_qsingle" if q.qtype is 0
    return "_qmulti" if q.qtype is 1

  cancel: ->
    @st.go("^")

  quest_text: (scope)->
    item = scope.$modelValue
    return "單選題" if item.qtype is 0
    return "複選題" if item.qtype is 1

  cu_is_commentable: (scope)->
    item = scope.$modelValue
    return "_on" if item.commentable

  cu_dn: (scope)->
    return if scope.$last
    cur = scope.$modelValue
    @ms.move(scope.$parent.$modelValue, cur.order, 1)

  cu_up: (scope)->
    return if scope.$first
    cur = scope.$modelValue
    @ms.move(scope.$parent.$modelValue, cur.order, -1)

  cu_remove_item: (pid, scope, method)->
    @ms[method](pid, scope.$modelValue)
    scope.remove()

  cu_add_choice: (scope, qo)->
    root = scope.$modelValue
    @ms.add_choice(root, qo)

  cu_add_quest: (scope)->
    root = scope.$modelValue
    @ms.add_quest(root)

  toggle_type: (scope)->
    item = scope.$modelValue
    item.qtype = (item.qtype + 1) % 2

  toggle_commentable: (scope)->
    item = scope.$modelValue
    item.commentable = !item.commentable

  toggle_order: (scope)->
    @$.data.reorder = !@$.data.reorder

  toggle_all: (scope)->
    @$.data.collapsed = !@$.data.collapsed
    if @$.data.collapsed
      scope.collapseAll()
    else
      scope.expandAll()

  toggle_class: (scope)->
    if @$.data.collapsed then "_expd" else "_clap"

  clicked: (item)->
    return "clicked" if @ms.data.survey is item
