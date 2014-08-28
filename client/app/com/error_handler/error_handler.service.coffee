"use strict"

angular.module "brasFeApp"
.factory "errorHandler", ($q, $log, growl)->
  response: (response) ->
    $log.debug "success with status #{response.status}"
    response || $q.when response

  responseError: (rejection) ->
    $log.debug "error with status #{rejection.status} and data: #{rejection.data['message']}"
    switch rejection.status
      when 403
        growl.error "You don't have the right to do this"
      when 0
        growl.error "No connection, check your internet connection. Or the server might be maintainace."
      else
        growl.error "#{rejection.data['message']}", title: "Error"
    # do something on error
    $q.reject rejection
