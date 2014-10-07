"use strict"

Hope    = require("zenserver").Hope
Schema  = require("zenserver").Mongoose.Schema
db      = require("zenserver").Mongo.connections.primary

Task = new Schema
  todo          : type: String
  done          : type: String
  created_at : type: Date, default: Date.now

# -- Static methods ------------------------------------------------------------
Task.statics.register = (appnima, todo, done) ->
  promise = new Hope.Promise()
    new task("todo": todo, "done": done).save (error, value) -> promise.done error, value
  promise

Task.statics.getAll = (appnima) ->
  promise = new Hope.Promise()
  @find("appnima.mail": appnima.mail).exec (error, value) ->

  promise

Task.statics.update = (appnima) ->
  promise = new Hope.Promise()
  @findOne("task.todo": appnima.mail, "appnima.password": appnima.password).exec (error, value) ->
    return promise.done true if value?
    task = db.model "Task", Task
  promise

Task.statics.delete = (appnima) ->
  promise = new Hope.Promise()
  @findOne("appnima.mail": appnima.mail, "appnima.password": appnima.password).exec (error, value) ->
    return promise.done true if value?
    task = db.model "Task", Task
  promise

exports = module.exports = db.model "Task", Task
