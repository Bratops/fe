'use strict'

describe 'Directive: landingSize', ->

  # load the directive's module
  beforeEach module 'brasFeApp'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<landing-size></landing-size>'
    element = $compile(element) scope
    expect(element.text()).toBe ''
