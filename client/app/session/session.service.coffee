'use strict'

angular.module 'brasFeApp'
.service 'session', (Restangular) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  rest = Restangular.all "group"
  ret =
    sclist: (query)->
      rest.all("publist/school").getList({query: query})
