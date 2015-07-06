Helper = require('hubot-test-helper')
expect = require('chai').expect
sinon = require('sinon')

# helper loads a specific script if it's a file
helper = new Helper('./../scripts/shipit.coffee')

class MockResponse extends Helper.Response
  random: (items) ->
    "http://i.imgur.com/DPVM1.png"


describe 'shipit', ->
  room = null

  context 'without extra squirrels', ->

    beforeEach ->
      process.env.HUBOT_SHIP_EXTRA_SQUIRRELS = false
      room = helper.createRoom({'response': MockResponse})

    afterEach ->
      room.destroy()

    context 'user says "ship it"', ->
      beforeEach ->
        room.user.say 'alice', 'ship it'

      it 'should respond with an image', ->
        expect(room.messages[1]).to.eql ['hubot', 'http://i.imgur.com/DPVM1.png']

    context 'user says "shipping it"', ->
      beforeEach ->
        room.user.say 'alice', 'shipping it'

      it 'should not respond with an image', ->
        expect(room.messages).to.eql [
          ['alice', 'shipping it']
        ]

    context 'user says "woot" somewhere in the message', ->
      beforeEach ->
        room.user.say 'alice', 'It is woot time'

      it 'should respond with a greeting', ->
        expect(room.messages[1]).to.eql ['hubot', 'Hi, I\'m hubot']

  context 'with extra squirrels', ->

    beforeEach ->
      process.env.HUBOT_SHIP_EXTRA_SQUIRRELS = true
      room = helper.createRoom({'response': MockResponse})

    afterEach ->
      room.destroy()

    context 'user says "ship it"', ->
      beforeEach ->
        room.user.say 'alice', 'ship it'

      it 'should respond with an image', ->
        expect(room.messages[1]).to.eql ['hubot', 'http://i.imgur.com/DPVM1.png']

    context 'user says "shipping it"', ->
      beforeEach ->
        room.user.say 'alice', 'shipping it'

      it 'should respond with an image', ->
        expect(room.messages[1]).to.eql ['hubot', 'http://i.imgur.com/DPVM1.png']

    context 'user says "woot" somewhere in the message', ->
      beforeEach ->
        room.user.say 'alice', 'It is woot time'

      it 'should respond with a greeting', ->
        expect(room.messages[1]).to.eql ['hubot', 'Hi, I\'m hubot']
