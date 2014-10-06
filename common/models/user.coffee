"use strict"

Hope    = require("zenserver").Hope
Schema  = require("zenserver").Mongoose.Schema
db      = require("zenserver").Mongo.connections.primary

User = new Schema
  appnima :
    id            : type: String
    mail          : type: String
    username      : type: String
    name          : type: String
    bio           : type: String
    avatar        : type: String
    access_token  : type: String
    refresh_token : type: String
    password      : type: String
    expire        : type: Date
  updated_at : type: Date
  created_at : type: Date, default: Date.now

# -- Static methods ------------------------------------------------------------
User.statics.signup = (appnima) ->
  promise = new Hope.Promise()
  @findOne("appnima.mail": appnima.mail).exec (error, value) ->
    return promise.done true if value?
    user = db.model "User", User
    new user(appnima: appnima).save (error, value) -> promise.done error, value
  promise

exports = module.exports = db.model "User", User
