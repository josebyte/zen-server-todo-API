"use strict"
Appnima = require("zenserver").Appnima
Hope    = require("zenserver").Hope

module.exports = (server) ->

  server.post "/api/register", (request, response) ->
    if request.required ['mail','todo']
      Hope.shield([ ->
        Appnima.login request.parameters
      , (error, appnima) ->
        User.signup appnima
      ]).then (error, user) ->
        if error
          response.json message: error.message, error.code
        else
          response.json user.parse()
