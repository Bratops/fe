'use strict'

describe 'Service: sessionInjector', ->

  # load the service's module
  beforeEach module 'brasFeApp'

  # instantiate service
  sessionInjector = undefined
  beforeEach inject (_sessionInjector_) ->
    sessionInjector = _sessionInjector_

  it 'should do something', ->
    expect(!!sessionInjector).toBe true
