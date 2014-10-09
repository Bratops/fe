"use strict"
angular.module("brasFeApp").service "datagen", ()->
  r = {}

  r.kvp = (n, v)->
    {key: n, value: v}

  r.nvp = (n, v)->
    {name: n, value: v}

  r.date_opt = (min="2014/11/10")->
    minDate: min
    maxDate: "'2014/11/21'"
    open: false
    startingDay: 1

  r.add_day = (base_day, day)->
    dt = base_day || new Date()
    dt.setDate(dt.getDate() + day)
    dt

  r
