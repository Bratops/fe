'use strict'

describe 'Controller: BulletinCtrl', ->

  # load the controller's module
  beforeEach module 'brasFeApp'
  BulletinCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    BulletinCtrl = $controller 'BulletinCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
