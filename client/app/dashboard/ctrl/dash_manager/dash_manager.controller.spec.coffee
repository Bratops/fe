'use strict'

describe 'Controller: DashManagerCtrl', ->

  # load the controller's module
  beforeEach module 'brasFeApp'
  DashManagerCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DashManagerCtrl = $controller 'DashManagerCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
