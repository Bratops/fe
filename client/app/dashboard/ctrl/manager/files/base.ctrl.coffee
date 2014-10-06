"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.FilesCtrl"
  inject:
    $scope: "$"
    Config: "cfg"
    managerFiles: "mf"

  init: ->
    @mf.load()
    @$.data = @mf.data

  file_success: (f, m)->
    @mf.data.flow.files = _.reject @mf.data.flow.files, (fl)-> fl.$$hashKey is f.$$hashKey
    rsp = eval("(#{m})")
    @mf.notify(rsp.msg)
    @mf.data.files.push rsp.data

  remove: (f)->
    @mf.remove(f)

  show_link: (f)->
    @mf.data.link = f.url

