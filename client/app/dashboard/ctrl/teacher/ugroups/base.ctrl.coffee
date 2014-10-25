"use strict"
angular.module("brasFeApp").classy.controller
  name: "teacher.UgroupsCtrl"

  inject:
    $scope: "$"
    $state: "st"
    teacherUgroup: "m"

  _on_teacher_ugroup_loaded: (e, d)->
    if d.edit
      @st.go("dashboard.teacher.ugroups.edit", {id: d.id})

  init: ->
    @$.data = @m.data
    @m.load_ugroups()
    @$.$on "teacher:ugroup:loaded", @_on_teacher_ugroup_loaded

  new: ->
    @m.new()
    @st.go("dashboard.teacher.ugroups.new")

  watch:
    "data.query.ugroup": (nv, ov)->
      @m.load_ugroups()

  edit: (group)->
    @m.load_ugroup(group.id, true)

  validate: (form, field)->
    form[field].$invalid && form[field].$dirty

  new_enroll: ->
    @m.new_enroll()

  cancel: ->
    @m.clear()
    @st.go("dashboard.teacher.ugroups")

  _parse_file: (fh)->
    (enrolls)=>
      form = @$.data.form
      form.enrolls = form.enrolls.concat enrolls
      fh.cancel()

  file_added: (fh, e)->
    e.preventDefault()
    @m.read_csv(fh.file).then @_parse_file(fh)

  enrolls_count: ->
    _.filter(@$.data.form.enrolls, (e)->
      return !e._destroy
    ).length

  remove_enroll: (ix)->
    @m.remove_enroll(ix)

  remove: (group)->
    if confirm("確定移除班級?")
      @m.remove(group.id)
