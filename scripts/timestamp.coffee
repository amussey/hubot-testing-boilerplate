# Description:
#   Convert a UNIX timestamp to a date string.
#
# Commands:
#   hubot convert <integer> - Convert the provided timestamp into a date string.
#
# Author:
#   amussey

moment = require('moment')

module.exports = (robot) ->
  robot.respond /convert (.*)$/i, (msg) ->
    msg.send moment.unix(msg.match[1]).toString()
