"use strict"

Test = require("zenrequest").Test

module.exports = ->
  tasks = []
  user = ZENrequest.users[0]
  tasks.push _register(task, user) for task in ZENrequest.tasks
  tasks


# Promises
_register = (task, user) -> ->
  Test "POST", "api/task", task, _session(user), "El usuario #{user.mail} ha creado la tarea #{task.text}", 200

_session = (user) ->
  if user?.token? then authorization: user.token else null
