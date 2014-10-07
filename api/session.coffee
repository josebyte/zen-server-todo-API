"use strict"
Appnima = require("zenserver").Appnima
Hope    = require("zenserver").Hope
User    = require "../common/models/user"

module.exports = (server) ->
  server.post "/api/signup", (request, response) ->
    if request.required ['mail', 'password']
      Hope.shield([ ->
        Appnima.signup request.parameters
      , (error, appnima) ->
        User.signup appnima
      ]).then (error, user) ->
        if error
          response.json message: error.message, error.code
        else
          response.json user.parse()

  server.post "/api/login", (request, response) ->
    if request.required ['mail', 'password']
      Hope.shield([ ->
        Appnima.login request.parameters
      , (error, appnima) ->
        User.login appnima
      ]).then (error, user) ->
        if error
          response.json message: error.message, error.code
        else
          response.json user.parse()
