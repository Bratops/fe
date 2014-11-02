"use strict"

angular.module "brasFeApp"
.service "studentEnrollments", ($rootScope, $q, sessionServ, notify, datagen)->
  convert_gender = (tag)->
    if tag is "男"
      return 1
    else if tag is "女"
      return 0
    else
      return -1

  make_user = (ary, stat)->
    id: null
    name: ary[0].trim()
    gender: ary[1].trim()
    suid: ary[2].trim()
    seat: ary[3].trim()
    status:
      name: stat.n || "處理中"
      value: stat.v || "handling"

  col_item = (name, value, sort=0)->
    name: name
    value: value
    sort: sort

  update_user = (user, resp)->
    user.id = resp.user.id
    user.status = resp.user.status
    user.error = resp.user.error

  sanitize_user = (user)->
    obj = _.clone user
    obj.gender = convert_gender(obj.gender)
    obj

  ret =
    read_csv: (file)->
      deferred = $q.defer()
      if window.File and window.FileReader and window.FileList and window.Blob
        reader = new FileReader()
        if (file isnt `undefined`) and (file isnt null)
          reader.onload = (event) ->
            users = _.map(datagen.CSVToArray(event.target.result), make_user)
            deferred.resolve users
            return
          reader.readAsText file
        else
          deferred.resolve []
          growl.warning "沒有檔案."
      else
        deferred.resolve []
        growl.error "瀏覽器不支援此功能."
      deferred.promise
    enroll_base: (user, index, route)->
      obj = sanitize_user(user)
      rest = sessionServ.fest().one("teacher/ugroups", ret.data.gid)
      rest.post(route, {user: obj}).then (resp)->
        update_user(user, resp)
        if index?
          $rootScope.$broadcast "enroll_next", index+1
    enroll: (user, index)->
      if user.status.value is "added"
        if index?
          $rootScope.$broadcast "enroll_next", index+1
        return
      ret.enroll_base(user, index, "enroll")
    load: ()->
      return if ret.data.init
      ret.data.init = true
      ret.load_enrollments()
    load_enrollments: ()->
      rest = sessionServ.fest().one("teacher/ugroups", ret.data.gid)
      rest.getList("enrollments").then (resp)->
        ret.data.users = resp
    delete_checked: ()->
      return if ret.data.users.length is 0
      rest = sessionServ.fest().one("teacher/ugroups", ret.data.gid)
      rest.one("enrollments").post("", {ids: ret.data.del_users}).then (resp)->
        notify.g resp.msg
        ret.data.users = _.filter(ret.data.users, (u)->
          fk = _.findIndex resp.keep, (k)->
            u.id == k
          fk > -1
        )
    set_gid: (gid)->
      ret.data.gid = gid
      ret.data.init = false
    new_enrollment: ()->
      st =
        n: "未處理"
        v: "new"
      ne = make_user(["new", "", "", ""], st)
      ret.data.users.splice(0, 0, ne)
    save_edit: ()->
      _.each ret.data.users, (u)->
        if u.status.value is "new"
          ret.enroll(u)
        else if u.dirty
          ret.enroll_base(u, null, "enroll")
    predicates: ()->
      a = []
      _.each ret.data.cols, (c)->
        if c.sort is 1
          a.push "+#{c.value}"
        else if c.sort is 2
          a.push "-#{c.value}"
        else
          c.value
      a
    data:
      gid: null
      init: false
      users: []
      del_users: []
      cols: [
        col_item("姓名", "name")
        col_item("性別", "gender")
        col_item("學號", "suid")
        col_item("座號", "seat", 1)
        col_item("狀態", "status")
      ]
