"use strict"
angular.module "brasFeApp"
.service "teacherUgroup", ($rootScope, $q, sessionServ, notify, datagen)->
  nv = datagen.nvp

  _genders = [
    nv("女", 0),
    nv("男", 1),
  ]

  time_sec = [
    nv("上午(0730~1230)", 0),
    nv("下午(1300~1800)", 1),
    nv("晚上(1800~2200)", 2),
  ]

  _gc =
    女: 0
    男: 1

  _make_user = (ary)->
    name: ary[0].trim()
    gender: _gc[ary[1].trim()]
    suid: ary[2].trim()
    seat: ary[3].trim()

  _new_group = ->
    cluster_id: ""
    grade: 10
    note: ""
    name: ""
    enrolls: []
    #exdate: "2014/11/10"
    #extime: time_sec[0]

  _new_enroll = ->
    name: ""
    gender: 0
    suid: ""
    seat: ""

  r =
    data:
      inited: false
      form: _new_group()
      ugroup: {}
      query:
        ugroup: ""
      option:
        clusters: []
        genders: _genders

  r.init = ->
    return if r.data.inited
    r.data.inited = true
    r._load_clusters()

  r.load_ugroup = (id, edit)->
    rt = sessionServ.fest().one("teacher/ugroups", id)
    rt.get("").then (rp)->
      if edit
        r.data.form = rp
      else
        r.data.ugroup = rp
      $rootScope.$broadcast "teacher:ugroup:loaded", {id: id, edit: edit}

  r.load_ugroups = ->
    rt = sessionServ.fest().all("teacher/ugroups")
    rt.get("", {q: r.data.query.ugroup}).then (rp)->
      r.data.ugroups = rp

  r._load_clusters = ->
    rt = sessionServ.fest().all("teacher/ugroups/clusters")
    rt.get("").then (rp)->
      r.data.option.clusters = rp

  r.new = ->
    r.data.form = _new_group()

  r.new_enroll = ->
    r.data.form.enrolls.push _new_enroll()

  r.remove_enroll = (ix)->
    rf = r.data.form
    if rf.enrolls[ix].id?
      rf.enrolls[ix]._destroy = true
    else
      rf.enrolls.splice(ix, 1)

  r.remove = (id)->
    rt = sessionServ.fest().one("teacher/ugroups", id)
    rt.remove("").then (rp)->
      notify.g rp.msg
      r.load_ugroups()

  r.clear = ->
    r.new()

  r._parse_file = (d, file)->
    reader = new FileReader()
    reader.onload = (event) ->
      users = _.map(datagen.CSVToArray(event.target.result), _make_user)
      d.resolve users
    reader.readAsText file

  r._nodata = (d, info)->
    d.resolve []
    growl.warning info

  r.read_csv = (file)->
    deferred = $q.defer()
    if window.File and window.FileReader and window.FileList and window.Blob
      if file?
        r._parse_file(deferred, file)
      else
        r._nodata(defferred, "沒有資料.")
    else
      r._nodata(defferred, "瀏覽器不支援此功能.")
    deferred.promise

  r._group_data = ->
    d = _.clone(r.data.form, true)
    d.enrollments_attributes = d.enrolls
    delete d.enrolls
    d

  r.update = ->
    data = {ugroup: r._group_data()}
    rt = sessionServ.fest().one("teacher/ugroups", r.data.form.id)
    rt.patch(data).then (rp)->
      notify.g rp.msg
      $rootScope.$broadcast "teacher:ugroup:updated"

  r.create = ->
    data = {ugroup: r._group_data()}
    rt = sessionServ.fest().one("teacher/ugroups")
    rt.post("", data).then (rp)->
      notify.g rp.msg
      $rootScope.$broadcast "teacher:ugroup:created"

  r
