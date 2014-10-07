"use strict"

Hope    = require("zenserver").Hope
Session = require "../common/session"
Task    = require "../common/models/task"

module.exports = (server) ->

  server.get "/api/task", (request, response) ->
    Session(request, response).then (error, session) ->
      Task.search(user: session).then (error, tasks) ->
        if error
          response.json message: error.message, error: error.code
        else
          response.json (task.parse() for task in tasks)

  server.post "/api/task", (request, response) ->
    if request.required ['text']
      Session(request, response).then (error, session) ->
        request.parameters.user = session
        Task.register(request.parameters).then (error, task) ->
          if error
            response.json message: error.message, error: error.code
          else
            response.json task.parse()

  server.put "/api/task", (request, response) ->
    if request.required ['id']
      Session(request, response).then (error, session) ->
        Hope.shield([ ->
          query =
            _id: request.parameters.id
            user: session
          Task.search query, limit=1
        , (error, task) ->
          task.updateAttributes request.parameters
        ]).then (error, result) ->
          if error
            response.json message: error.message, error: error.code
          else
            response.json result.parse()

  server.delete "/api/task", (request, response) ->
    if request.required ['id']
      Session(request, response).then (error, session) ->
        Hope.shield([ ->
          query =
            _id: request.parameters.id
            user: session
          Task.search query, limit=1
        , (error, task) ->
          task.delete()
        ]).then (error, result) ->
          if error
            response.json message: error.message, error: error.code
          else
            response.ok()

