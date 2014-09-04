'use strict'

describe 'Controller: DashStudentCtrl', ->

  # load the controller's module
  beforeEach module 'brasFeApp'
  DashStudentCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DashStudentCtrl = $controller 'DashStudentCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
