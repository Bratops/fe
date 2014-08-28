'use strict'

describe 'Service: sessionServ', ->

  # load the service's module
  beforeEach module 'brasFeApp'

  # instantiate service
  sessionServ = undefined
  beforeEach inject (_sessionServ_) ->
    sessionServ = _sessionServ_

  it 'should do something', ->
    expect(!!sessionServ).toBe true
