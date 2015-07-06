Helper = require('hubot-test-helper')
expect = require('chai').expect
sinon = require('sinon')

# helper loads a specific script if it's a file
helper = new Helper('./../scripts/ping.coffee')

describe 'ping', ->
  room = null

  beforeEach ->
    room = helper.createRoom()

  afterEach ->
    room.destroy()

  context 'user says ping to hubot', ->
    beforeEach ->
      room.user.say 'alice', 'hubot PING'
      room.user.say 'bob',   'hubot PING'

    it 'should reply pong to user', ->
      expect(room.messages).to.eql [
        ['alice', 'hubot PING']
        ['hubot', 'PONG']
        ['bob',   'hubot PING']
        ['hubot', 'PONG']
      ]

  context 'user says echo to hubot', ->
    beforeEach ->
      room.user.say 'jim', 'hubot echo this will be the message'
      room.user.say 'peter', 'hubot echo another message'

    it 'should echo message back', ->
      expect(room.messages).to.eql [
        ['jim', 'hubot echo this will be the message']
        ['hubot', 'this will be the message']
        ['peter', 'hubot echo another message']
        ['hubot', 'another message']
      ]

  context 'user says time to hubot', ->
    beforeEach ->
      process.env.TZ = 'UTC'
      @clock = sinon.useFakeTimers(1433182746000)
      room.user.say 'bill', 'hubot time'

    afterEach ->
      @clock.restore()

    it 'should respond with current time', ->
      expect(room.messages).to.eql [
        ['bill', 'hubot time']
        ['hubot', 'Server time is: Mon Jun 01 2015 18:19:06 GMT+0000 (UTC)']
      ]

  context 'user says die to hubot', ->
    beforeEach ->
      sinon.stub process, "exit"
      room.user.say 'mary', 'hubot die'

    afterEach ->
      process.exit.restore()

    it 'should tell the room it is leaving', ->
      expect(room.messages).to.eql [
        ['mary', 'hubot die']
        ['hubot', 'Goodbye, cruel world.']
      ]

    it 'should call process exit', ->
      expect(process.exit.called).to.be.true
