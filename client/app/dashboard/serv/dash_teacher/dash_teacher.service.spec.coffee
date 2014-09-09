'use strict'

describe 'Service: dashTeacher', ->

  # load the service's module
  beforeEach module 'brasFeApp'

  # instantiate service
  dashTeacher = undefined
  beforeEach inject (_dashTeacher_) ->
    dashTeacher = _dashTeacher_

  it 'should do something', ->
    expect(!!dashTeacher).toBe true
