"use strict"

angular.module "brasFeApp"
.controller "DaTeEnrollmentsCtrl", ($scope, $stateParams, studentEnrollments) ->
  state_base = "dashboard.teacher"
  se = studentEnrollments
  $scope.data = se.data

  $scope.$on "enroll_next", (event, si)->
    if $scope.data.users.length > si
      se.enroll($scope.data.users[si], si)

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    se.set_gid($stateParams.id)
    se.load()
    #if toState.name is "#{state_base}.groups"
      #dashTeacher.load_groups()

  $scope.file_added = (fh, e)->
    e.preventDefault()
    se.read_csv(fh.file).then (data)->
      sti = $scope.data.users.length
      $scope.data.users = $scope.data.users.concat data
      se.enroll($scope.data.users[sti], sti)
      fh.cancel()

  $scope.delete_checked = ()->
    se.delete_checked()

  $scope.$watch "check_all", (nv, ov)->
    if nv
      se.data.del_users = $scope.data.users.map (u)->
        u.id
    else
      se.data.del_users = []

  $scope.new_enrollment = ()->
    se.new_enrollment()

  $scope.make_dirty = (user)->
    user.dirty = true

  $scope.save_edited = ()->
    se.save_edit()
