'use strict'
#not used

angular.module 'brasFeApp'
.directive 'landingSize', ($window)->
  (scope, element) ->
    w = angular.element($window)
    scope.getWindowDimensions = ->
      h: w.height()
      w: w.width()

    scope.$watch scope.getWindowDimensions, ((newValue, oldValue) ->
      scope.windowHeight = newValue.h
      scope.windowWidth = newValue.w
      scope.style = ->
        height: (newValue.h - 100) + "px"
        width: "100%"
    ), true
    w.bind "resize", ->
      scope.$apply()
