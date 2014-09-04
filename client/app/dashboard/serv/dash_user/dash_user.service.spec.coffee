'use strict'

describe 'Service: dashUser', ->

  # load the service's module
  beforeEach module 'brasFeApp'

  # instantiate service
  dashUser = undefined
  beforeEach inject (_dashUser_) ->
    dashUser = _dashUser_

  it 'should do something', ->
    expect(!!dashUser).toBe true
