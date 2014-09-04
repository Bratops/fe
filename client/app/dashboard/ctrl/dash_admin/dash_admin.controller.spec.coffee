'use strict'

describe 'Controller: DashAdminCtrl', ->

  # load the controller's module
  beforeEach module 'brasFeApp'
  DashAdminCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DashAdminCtrl = $controller 'DashAdminCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
