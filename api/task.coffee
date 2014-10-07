"use strict"

Hope    = require("zenserver").Hope
Session = require "../common/session"
Task    = require "../common/models/task"

module.exports = (server) ->

  server.post "/api/task", (request, response) ->
    if request.required ['text']
      Session(request, response).then (error, session) ->
        request.parameters.user = session
        Task.register(request.parameters).then (error, task) ->
          if error
            response.json message: error.message, error: error.code
          else
            response.json task.parse()
