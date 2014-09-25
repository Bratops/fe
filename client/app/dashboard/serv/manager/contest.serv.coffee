"use strict"
angular.module "brasFeApp"
.service "managerContest", ($rootScope, sessionServ, notify, datagen)->
  grading = (name, value)->
    {name: name, value: value}

  gradings = [
    grading("Beaver", 0),
    grading("Benjemin", 1),
    grading("Cadet", 2),
    grading("Junior", 3),
    grading("Senior", 4),
  ]

  r =
    data:
      gradings: gradings
      opt:
        sdate: datagen.date_opt()
        edate: datagen.date_opt()
      contest:
        name: ""
        sdate: "2014-11-10"
        edate: "2014-11-21"
        grading: gradings[4].value
        target_grades: []
        ugroup_ids: []
        task_ids: []
