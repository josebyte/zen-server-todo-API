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

Task.methods.parse = ->
  id        : @_id.toString()
  text      : @text
  done      : @done
  created_at: @created_at

exports = module.exports = db.model "Task", Task
