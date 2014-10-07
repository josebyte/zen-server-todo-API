"use strict"

Test = require("zenrequest").Test

module.exports = ->
  tasks = []
  tasks.push _signup(user) for user in ZENrequest.users
  tasks.push _login(user) for user in ZENrequest.users
  tasks


# Promises
_signup = (user) -> ->
  Test "POST", "api/signup", user, null, "El usuario #{user.mail} se registra con App/Nima", 409

_login = (user) -> ->
  Test "POST", "api/login", user, null, "El usuario #{user.mail} se ha logueado.", 200, (response) ->
    user.id = response.id
    user.token = response.token
