# Description:
#   Tell the user a secret when prompted.
#
# Commands:
#   hubot tell me a secret - Reply with a secret
#
# Author:
#   amussey

module.exports = (robot) ->
  robot.respond /tell me a secret$/i, (msg) ->
    msg.sendPrivate 'whisper whisper whisper'
