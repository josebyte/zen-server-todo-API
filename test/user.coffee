"use strict"

Test = require("zenrequest").Test

module.exports = ->
  tasks = []
  tasks.push _signup(user) for user in ZENrequest.users
  tasks.push _login(user) for user in ZENrequest.users
  tasks


# Promises
_signup = (user) -> ->
  Test "POST", "api/signup", user, null, "El usuario #{user.name} se registra con App/Nima", 409
