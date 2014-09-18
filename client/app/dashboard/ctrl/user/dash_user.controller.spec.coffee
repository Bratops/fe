'use strict'

describe 'Controller: DashUserCtrl', ->

  # load the controller's module
  beforeEach module 'brasFeApp'
  DashUserCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DashUserCtrl = $controller 'DashUserCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
