Helper = require('hubot-test-helper')
expect = require('chai').expect
assert = require('chai').assert
sinon = require('sinon')

# helper loads a specific script if it's a file
helper = new Helper('./../scripts/timestamp.coffee')

describe 'timestamp', ->
  room = null
  moment = null
  momentUnixStub = null
  momentUnixToStringStub = null

  beforeEach ->
    moment = require('moment')
    momentUnixToStringStub = sinon.stub()
    momentUnixToStringStub.returns("Sun Oct 16 2011 16:17:56 GMT+0000")
    momentUnixStub = sinon.stub moment, "unix", () ->
      return {toString: momentUnixToStringStub}

    room = helper.createRoom()

  afterEach ->
    moment.unix.restore()
    room.destroy()

  context 'user asks hubot to convert', ->
    beforeEach ->
      room.user.say 'jim', 'hubot convert 1318781876'

    it 'should echo message back', ->
      expect(room.messages).to.eql [
        ['jim', 'hubot convert 1318781876']
        ['hubot', 'Sun Oct 16 2011 16:17:56 GMT+0000']
      ]

    it 'should have called toString', ->
      expect(momentUnixToStringStub.callCount).to.eql 1

    it 'should have called unix() with the correct parameters', ->
      expect(momentUnixStub.args[0]).to.eql [ '1318781876' ]
