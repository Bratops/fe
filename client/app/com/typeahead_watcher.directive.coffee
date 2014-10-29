"use strict"
angular.module 'brasFeApp'
.directive("focusMe", ($timeout, $parse) ->
  link: (scope, element, attrs) ->
    model = $parse(attrs.focusMe)
    scope.$watch model, (value) ->
      if value is true
        $timeout ->
          element[0].focus()

).directive "emptyTypeahead", ->
  require: "ngModel"
  link: (scope, element, attrs, modelCtrl) ->
    secretEmptyKey = "$empty$"
    # this parser run before typeahead's parser
    modelCtrl.$parsers.unshift (inputValue) ->
      value = (if inputValue then inputValue else secretEmptyKey) # replace empty string with secretEmptyKey to bypass typeahead-min-length check
      modelCtrl.$viewValue = value # this $viewValue must match the inputValue pass to typehead directive
      value

    # this parser run after typeahead's parser
    modelCtrl.$parsers.push (inputValue) ->
      (if inputValue is secretEmptyKey then "" else inputValue) # set the secretEmptyKey back to empty string

