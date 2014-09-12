"use strict"

angular.module "brasFeApp"
.factory "errorHandler", ($q, $log, $rootScope, growl)->
  notify = (data)->
    if !data or !data.msg
      console.log "unscoped server error"
      return
    notifier = growl[data.status]
    msg = data.msg
    notifier msg.body, title: msg.title

  response: (resp) ->
    #$log.debug "#{resp.config.method}[#{resp.status}] (#{resp.config.url})"
    #console.log resp
    resp || $q.when resp

  responseError: (rejection) ->
    $log.debug "error with status #{rejection.status} and data: #{rejection.data['message']}"
    data = rejection.data
    notify data
    $rootScope.$broadcast "httpError", rejection.status
    switch rejection.status
      when 400
        growl.error "如果您仍需這個功能，請來信:<mailto:little_beaver@gmail.com>", title: "參數錯誤"
      when 404
        growl.error "找不到您要的功能", title: "找不到海狸"
      when 405
        growl.error "系統回應：您無法使用此功能", title: "被限制的功能"
      when 406
        growl.error "抱歉，系統無法處理您的請求", title: "無法處理的請求"
      when 408
        growl.error "請確認連線狀態及網路速度", title: "請求逾時"
      when 0
        growl.error "No connection, check your internet connection. Or the server might be maintainace."
      else
        if rejection.status >= 500
          growl.error "正在記錄錯誤，並且尋找海狸工程師來修理", title: "海狸忙碌中..."
        else if rejection.status < 400
          growl.error "Error: #{rejection}", title: "未知的錯誤", ttl: 1000*1000
    # do something on error
    $q.reject rejection
