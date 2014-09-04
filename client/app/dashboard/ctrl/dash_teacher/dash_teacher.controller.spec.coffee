'use strict'

describe 'Controller: DashTeacherCtrl', ->

  # load the controller's module
  beforeEach module 'brasFeApp'
  DashTeacherCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DashTeacherCtrl = $controller 'DashTeacherCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
