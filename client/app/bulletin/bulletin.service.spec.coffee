'use strict'

describe 'Service: bulletin', ->

  # load the service's module
  beforeEach module 'brasFeApp'

  # instantiate service
  bulletin = undefined
  beforeEach inject (_bulletin_) ->
    bulletin = _bulletin_

  it 'should do something', ->
    expect(!!bulletin).toBe true
