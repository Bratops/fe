"use strict"
angular.module "brasFeApp"
.service "teacherUgroup", ($rootScope, $q, sessionServ, notify, datagen)->
  nv = datagen.nvp

  time_sec = [
    nv("上午(0730~1230)", 0),
    nv("下午(1300~1800)", 1),
    nv("晚上(1800~2200)", 2),
  ]

  _genders = [
    nv("女", 0),
    nv("男", 1),
  ]

  _gc =
    "女": 0
    "男": 1

  _make_user = (ary)->
    console.log ary
    r =
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

  r.clear = ->
    r.new()

  r._parse_file = (d, file)->
    reader = new FileReader()
    reader.onload = (event) ->
      data = _.filter(datagen.CSVToArray(event.target.result), (a)-> a.length > 2)
      console.log data
      users = _.map(data, _make_user)
      d.resolve users
    reader.readAsText file, "big5"

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

  r._notify = (msg, evt)->
    notify.g msg
    r.load_ugroups()
    $rootScope.$broadcast evt if evt?

  r.remove = (id)->
    rt = sessionServ.fest().one("teacher/ugroups", id)
    rt.remove("").then (rp)->
      r._notify(rp.msg)

  r.update = ->
    data = {ugroup: r._group_data()}
    rt = sessionServ.fest().one("teacher/ugroups", r.data.form.id)
    rt.patch(data).then (rp)->
      r._notify(rp.msg, "teacher:ugroup:updated")

  r.create = ->
    data = {ugroup: r._group_data()}
    rt = sessionServ.fest().one("teacher/ugroups")
    rt.post("", data).then (rp)->
      r._notify(rp.msg, "teacher:ugroup:created")

  r.reset_pass = ->
    rt = sessionServ.fest().one("teacher/ugroups", r.data.form.id)
    rt.one("reset_passwords").get().then (rp)->
      notify.g(rp.msg)

  r
