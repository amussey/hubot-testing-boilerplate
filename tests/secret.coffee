Helper = require('hubot-test-helper')
expect = require('chai').expect

# helper loads a specific script if it's a file
helper = new Helper('./../scripts/secret.coffee')

describe 'secret', ->
  room = null

  beforeEach ->
    room = helper.createRoom()

  afterEach ->
    room.destroy()

  context 'user asks hubot for a secret', ->
    beforeEach ->
      room.user.say 'alice', '@hubot tell me a secret'

    it 'should not post to the public channel', ->
      expect(room.messages).to.eql [
        ['alice', '@hubot tell me a secret']
      ]

    it 'should private message user', ->
      expect(room.privateMessages).to.eql {
        'alice': [
          ['hubot', 'whisper whisper whisper']
        ]
      }
