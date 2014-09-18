"use strict"
angular.module("brasFeApp").classy.controller
  name: "teacher.groups.EnrollmentsCtrl"

  inject:
    $scope: "$"
    $filter: "fil"
    $stateParams: "sp"
    studentEnrollments: "se"

  _sort: ()->
    @fil("orderBy")

  _state_base: "dashboard.teacher"

  _on_enroll_next: (event, si)->
    if @$.data.users.length > si
      @se.enroll(@$.data.users[si], si)
    else
      @se.load_enrollments()

  _scs: (event, toState, toParams, fromState, fromParams)->
    @se.set_gid(@sp.id)
    @se.load()
    #if toState.name is "#{state_base}.groups"
      #dashTeacher.load_groups()

  init: ()->
    @$.data = @se.data
    @$.$on "$stateChangeSuccess", @_scs
    @$.$on "enroll_next", @_on_enroll_next

  _parse_file: (fh)->
    (data)=>
      sti = @$.data.users.length
      @$.data.users = @$.data.users.concat data
      @se.enroll(@$.data.users[sti], sti)
      fh.cancel()

  file_added: (fh, e)->
    e.preventDefault()
    @se.read_csv(fh.file).then @_parse_file(fh)

  delete_checked: ()->
    @se.delete_checked()

  watch:
    "check_all": (nv, ov)->
      if nv
        @se.data.del_users = @$.data.users.map (u)->
          u.id
      else
        @se.data.del_users = []

  new_enrollment: ()->
    @se.new_enrollment()

  make_dirty: (user)->
    user.dirty = true

  save_edited: ()->
    @se.save_edit()

  sort_status: (col)->
    sa = ["minus-square-o", "arrow-down", "arrow-up"]
    "fa-#{sa[col.sort]}"

  sort_by: (col)->
    col.sort = (col.sort + 1) % 3

  precs: ()->
    pre = @se.predicates()

  svid: (sv)->
    sv.id
