"use strict"

Test = require("zenrequest").Test

module.exports = ->
  tasks = []
  user = ZENrequest.users[0]
  tasks.push _register(task, user) for task in ZENrequest.tasks
  tasks.push _update(task, user) for task in ZENrequest.tasks
  tasks.push _delete(task, user) for task in ZENrequest.tasks
  tasks


# Promises
_register = (task, user) -> ->
  Test "POST", "api/task", task, _session(user), "El usuario #{user.mail} ha creado la tarea #{task.text}", 200, (response) ->
    task.id = response.id

_update = (task, user) -> ->
  parameters = id: task.id, text: "#{task.text} UPDATED", done: true
  Test "PUT", "api/task", parameters, _session(user), "El usuario #{user.mail} ha modificado la tarea #{task.text}", 200

_delete = (task, user) -> ->
  parameters = id: task.id
  Test "DELETE", "api/task", parameters, _session(user), "El usuario #{user.mail} ha borrado la tarea #{task.text}", 200


_session = (user) ->
  if user?.token? then authorization: user.token else null
