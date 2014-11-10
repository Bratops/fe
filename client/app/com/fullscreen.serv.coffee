((window) ->
  createModule = (angular) ->
    module = angular.module("FBAngular", [])
    module.factory "Fullscreen", [
      "$document"
      "$rootScope"
      ($document, $rootScope) ->
        document = $document[0]

        # ensure ALLOW_KEYBOARD_INPUT is available and enabled
        isKeyboardAvailbleOnFullScreen = (typeof Element isnt "undefined" and "ALLOW_KEYBOARD_INPUT" of Element) and Element.ALLOW_KEYBOARD_INPUT
        emitter = $rootScope.$new()

        # listen event on document instead of element to avoid firefox limitation
        # see https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Using_full_screen_mode
        $document.on "fullscreenchange webkitfullscreenchange mozfullscreenchange MSFullscreenChange", ->
          emitter.$emit "FBFullscreen.change", serviceInstance.isEnabled()
          return

        serviceInstance =
          $on: angular.bind(emitter, emitter.$on)
          all: ->
            serviceInstance.enable document.documentElement
            return

          enable: (element) ->
            if element.requestFullScreen
              element.requestFullScreen()
            else if element.mozRequestFullScreen
              element.mozRequestFullScreen()
            else if element.webkitRequestFullscreen

              # Safari temporary fix
              if /Version\/[\d]{1,2}(\.[\d]{1,2}){1}(\.(\d){1,2}){0,1} Safari/.test(navigator.userAgent)
                element.webkitRequestFullscreen()
              else
                element.webkitRequestFullscreen isKeyboardAvailbleOnFullScreen
            else element.msRequestFullscreen()  if element.msRequestFullscreen
            return

          cancel: ->
            if document.cancelFullScreen
              document.cancelFullScreen()
            else if document.mozCancelFullScreen
              document.mozCancelFullScreen()
            else if document.webkitExitFullscreen
              document.webkitExitFullscreen()
            else document.msExitFullscreen()  if document.msExitFullscreen
            return

          isEnabled: ->
            fullscreenElement = document.fullscreenElement or document.mozFullScreenElement or document.webkitFullscreenElement or document.msFullscreenElement
            (if fullscreenElement then true else false)

          toggleAll: ->
            (if serviceInstance.isEnabled() then serviceInstance.cancel() else serviceInstance.all())
            return

          isSupported: ->
            docElm = document.documentElement
            requestFullscreen = docElm.requestFullScreen or docElm.mozRequestFullScreen or docElm.webkitRequestFullscreen or docElm.msRequestFullscreen
            (if requestFullscreen then true else false)

        return serviceInstance
    ]
    module.directive "fullscreen", [
      "Fullscreen"
      (Fullscreen) ->
        return link: ($scope, $element, $attrs) ->

          # Watch for changes on scope if model is provided
          if $attrs.fullscreen
            $scope.$watch $attrs.fullscreen, (value) ->
              isEnabled = Fullscreen.isEnabled()
              if value and not isEnabled
                Fullscreen.enable $element[0]
                $element.addClass "isInFullScreen"
              else if not value and isEnabled
                Fullscreen.cancel()
                $element.removeClass "isInFullScreen"
              return


            # Listen on the `FBFullscreen.change`
            # the event will fire when anything changes the fullscreen mode
            removeFullscreenHandler = Fullscreen.$on("FBFullscreen.change", (evt, isFullscreenEnabled) ->
              unless isFullscreenEnabled
                $scope.$evalAsync ->
                  $scope.$eval $attrs.fullscreen + "= false"
                  $element.removeClass "isInFullScreen"
                  return

              return
            )
            $scope.$on "$destroy", ->
              removeFullscreenHandler()
              return

          else
            return  if $attrs.onlyWatchedProperty isnt `undefined`
            $element.on "click", (ev) ->
              Fullscreen.enable $element[0]
              return

          return
    ]
    module

  if typeof define is "function" and define.amd
    define "FBAngular", ["angular"], (angular) ->
      createModule angular

  else
    createModule window.angular
  return
) window
