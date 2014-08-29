'use strict'

describe 'Service: sestangular', ->

  # load the service's module
  beforeEach module 'brasFeApp'

  # instantiate service
  sestangular = undefined
  beforeEach inject (_sestangular_) ->
    sestangular = _sestangular_

  it 'should do something', ->
    expect(!!sestangular).toBe true
