"use strict"
angular.module "brasFeApp"
.service "managerSurveys", ($rootScope, sessionServ, notify, datagen)->
  _quest = (ord=0)->
    order: ord
    qtype: 0
    content: "new quest"
    _destroy: false
    choices: []

  _choice = (ord=0)->
    order: ord
    content: "new choice"
    commentable: false
    _destroy: false

  _survey = ->
    name: "new survey"
    info: ""
    quests: []

  r =
    inited: false
    data:
      sb: "dashboard.manager.surveys"
      surveys: []
      survey: null
      xquests: {}
      xchoices: {}

  r.sbo = (n)->
    "#{r.data.sb}.#{n}"

  r.init = ->
    return if r.inited
    r.inited = true
    r.load()

  r.reload_surveys = ->
    r.load()

  r.load = ->
    rst = sessionServ.fest().all("manager/surveys")
    rst.get("").then (rsp)->
      r.data.surveys = rsp

  r.load_one = (id, edit=true)->
    rst = sessionServ.fest().all("manager/surveys")
    rst.get(id).then (rsp)->
      r.data.survey = rsp.data
      if rsp.status is "success"
        $rootScope.$broadcast "survey:edit:loaded", id

  r.new = ->
    r.data.survey = _survey()

  r.edit_reload = (id)->
    return if r.inited
    r.load_one(id)

  r.edit = (id)->
    r.load_one(id)

  r.remove = (id)->
    rst = sessionServ.fest().one("manager/surveys", id)
    rst.remove().then (rsp)->
      notify.g rsp.msg
      if rsp.msg.status is "success"
        $rootScope.$broadcast "survey:removed", id

  r.add_quest = (root)->
    root.push _quest(r.data.survey.quests.length)

  r.add_choice = (root, qo)->
    root.push _choice(qo)

  r._swap = (ia, ib, key)->
    tmp = ia[key]
    ia[key] = ib[key]
    ib[key] = tmp

  r.move = (set, ord, dir)->
    a = _.findIndex set, (q)-> q.order is ord
    b = _.findIndex set, (q)-> q.order is (ord + dir)
    r._swap(set[a], set[b], "order")

  r._x = (root, pid, cur)->
    cur._destroy = true
    da = r.data[root][pid]
    r.data[root][pid] = [] unless da?
    r.data[root][pid].push cur

  r.x_quest = (pid, cur)->
    r._x("xquests", pid, cur)

  r.x_choice = (pid, cur)->
    r._x("xchoices", pid, cur)

  r._concat_del = (root, ct)->
    root["#{ct}_attributes"] = root[ct]
    delete root[ct]
    root["#{ct}_attributes"] = root["#{ct}_attributes"].concat r.data["x#{ct}"][root.id]

  r._get_survey_data = ->
    da = _.clone r.data.survey, true
    _.each da.quests, (q)->
      r._concat_del(q, "choices")
    r._concat_del(da, "quests")
    da

  r._cu = (rest, base="post")->
    data = r._get_survey_data()
    rest[base]({survey: data}).then (rsp)->
      notify.g rsp.msg
      if rsp.msg.status is "success"
        r.data.xchoices = {}
        r.data.xquests = {}
        $rootScope.$broadcast "survey:updated"

  r.update = ->
    id = r.data.survey.id
    rst = sessionServ.fest().one("manager/surveys", id)
    r._cu(rst, "patch")

  r.create = ->
    rst = sessionServ.fest().all("manager/surveys")
    r._cu(rst, "post")

  r

