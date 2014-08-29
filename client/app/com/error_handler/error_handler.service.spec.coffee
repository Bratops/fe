'use strict'

describe 'Service: errorHandler', ->

  # load the service's module
  beforeEach module 'brasFeApp'

  # instantiate service
  errorHandler = undefined
  beforeEach inject (_errorHandler_) ->
    errorHandler = _errorHandler_

  it 'should do something', ->
    expect(!!errorHandler).toBe true
