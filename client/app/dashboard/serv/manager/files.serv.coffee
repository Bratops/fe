"use strict"
angular.module "brasFeApp"
.service "managerFiles", (sessionServ, flowFactory, notify, Config)->

  r =
    inited: false
    data:
      link: ""
      upload: {}
      files: []

  r.setup_flow = ()->
    r.data.flow = flowFactory.create
      singleFile: false
      target: "http://#{Config.host}/manager/files/upload"
      headers:
        "X-AUTH-LOGIN": sessionServ.user.login_alias || "",
        "X-AUTH-TOKEN": sessionServ.user.auth_token || "",
        "X-Requested-With": "XMLHttpRequest",
        "Accept": "application/bebras.tw; ver=1"

  r.remove = (f)->
    rst = sessionServ.fest().one("manager/files", f.code)
    rst.remove("").then (rsp)->
      if rsp.status is "success"
        r.data.files = _.reject(r.data.files, (fl)-> fl.code is f.code)

  r.get_files = ()->
    rst = sessionServ.fest().all("manager/files")
    rst.get("").then (rsp)->
      r.data.files = rsp

  r.load = ()->
    return if r.inited
    r.setup_flow()
    r.get_files()

  r.notify = (m)->
    notify.g m

  r.download = (f)->
    rst = sessionServ.fest().all("manager/files/download")
    rst.get("", {code: f.code}).then (rsp)->
      ""
  r
