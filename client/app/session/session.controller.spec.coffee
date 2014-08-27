'use strict'

describe 'Controller: SessionCtrl', ->

  # load the controller's module
  beforeEach module 'brasFeApp'
  SessionCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    SessionCtrl = $controller 'SessionCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
