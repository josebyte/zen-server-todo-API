"use strict"

Hope    = require("zenserver").Hope
Schema  = require("zenserver").Mongoose.Schema
db      = require("zenserver").Mongo.connections.primary

Task = new Schema
  user       : type: Schema.ObjectId, ref: "User"
  text       : type: String
  done       : type: Boolean, default: false
  created_at : type: Date, default: Date.now

# -- Static methods ------------------------------------------------------------
Task.statics.register = (parameters) ->
  promise = new Hope.Promise()
  task = db.model "Task", Task
  new task(parameters).save (error, value) -> promise.done error, value
  promise

Task.statics.search = (query, limit = 0) ->
  promise = new Hope.Promise()
  @find(query).limit(limit).exec (error, value) ->
    if limit is 1
      error = code: 402, message: "Task not found." if value.length is 0
      value = value[0] if value.length isnt 0
    promise.done error, value
  promise

Task.methods.updateAttributes = (parameters) ->
  promise = new Hope.Promise()
  @text = parameters.text if parameters.text
  @done = parameters.done if parameters.done
  @save (error, result) -> promise.done error, result
  promise

Task.methods.delete = ->
  promise = new Hope.Promise()
  @remove (error, result) -> promise.done error, result
  promise

Task.methods.parse = ->
  id        : @_id.toString()
  text      : @text
  done      : @done
  created_at: @created_at

exports = module.exports = db.model "Task", Task
