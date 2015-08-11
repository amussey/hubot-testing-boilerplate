# Description:
#   Remember a string in hubot's brain.
#
# Commands:
#   hubot remember <text> - Remember a string in the hubot brain.
#   hubot memory - Reply back with with the memorized string.
#
# Author:
#   amussey

module.exports = (robot) ->
  robot.respond /remember (.*)$/i, (msg) ->
    robot.brain.data.memory = msg.match[1]
    msg.reply 'Okay, I\'ll remember that.'

  robot.respond /memory$/i, (msg) ->
    if not robot.brain.data.memory?
      robot.brain.data.memory = null

    if robot.brain.data.memory == null
      msg.reply 'I\'m not remembering anything.'
    else
      msg.reply robot.brain.data.memory
