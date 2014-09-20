'use strict'

angular.module 'brasFeApp'
.directive "ckeditor", ->
  require: "?ngModel"
  link: ($scope, elm, attr, ngModel) ->
    ck = CKEDITOR.replace(elm[0])
    ck.on "pasteState", ->
      $scope.$apply ->
        ngModel.$setViewValue ck.getData()
    ngModel.$render = (value) ->
      ck.setData ngModel.$modelValue
