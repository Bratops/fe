"use strict"
angular.module "brasFeApp"
.service "userSurvey", ($rootScope, sessionServ, notify)->
  _submit = (id)->
    id: id
    ans_attributes: []

  _ans = (aid, qid, choices)->
    ans_set_id: aid,
    quest_id: qid,
    ans_choices_attributes: choices

  _choice = (id, comment)->
    choice_id: id
    comment_attributes: comment

  _comment = (content)->
    content: content

  r =
    inited: false
    data:
      ans_id: null
      survey: {}
      form: {}
      submit: {}

  r.init = ->
    return if r.inited
    r.inited = true
    r.load()

  r.thanks = ->
    notify.g { status: "success", body: "感謝您的參與", title: ""}

  r.load = ->
    rst = sessionServ.fest().all("user/surveys/current")
    rst.get("").then (rsp)->
      r.data.ans_id = rsp.data
      r.data.survey = rsp.survey if rsp.msg.status is "success"
      $rootScope.$broadcast("survey:finished", "") if rsp.msg.status is "error"

  r._encode_data = ->
    r.data.submit = _submit(r.data.ans_id)
    _.each(_.keys(r.data.form), (qid)->
      rf = r.data.form[qid]
      cs = _.map(rf.values, (v)->
        cm = if rf.text? then _comment(rf.text[v]) else null
        _choice(v, cm)
      )
      r.data.submit.ans_attributes.push _ans(r.data.submit.id, qid, cs)
    )

  r.submit = ->
    r._encode_data()
    data = _.clone(r.data.submit, true)
    rst = sessionServ.fest().all("user/surveys/submit")
    rst.post({survey_sheet: data}).then (rsp)->
      $rootScope.$broadcast("survey:finished", "") if rsp.status is "success"

  r
