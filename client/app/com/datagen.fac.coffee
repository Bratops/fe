"use strict"
angular.module("brasFeApp").factory "datagen", ->
  new class DataGen
    constructor: ()->

    nvp: (n, v)->
      {name: n, value: v}

    date_opt: ()->
      minDate: "'2014/11/10'"
      maxDate: "'2014/11/21'"
      open: false
      startingDay: 1
