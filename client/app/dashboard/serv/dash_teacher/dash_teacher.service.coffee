'use strict'

angular.module 'brasFeApp'
.service 'dashTeacher', ->
  ret =
    data:
      groups:
        new: true
        new_group:
          exdate: new Date()
        exdate_opt:
          minDate: new Date()
          maxDate: "'2014/11/20'"
          open: false
          startingDay: 1
        list: []
