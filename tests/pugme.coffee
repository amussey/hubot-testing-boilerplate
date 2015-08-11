Helper = require('hubot-test-helper')
expect = require('chai').expect
nock = require('nock')

helper = new Helper('./../scripts/pugme.coffee')

describe 'pugme', ->
  room = null

  beforeEach ->
    room = helper.createRoom()
    do nock.disableNetConnect
    nock('http://pugme.herokuapp.com')
      .get('/random')
      .reply 200, { pug: 'http://imgur.com/pug.png' }
      .get('/bomb?count=5')
      .reply 200, { pugs: ['http://imgur.com/pug1.png', 'http://imgur.com/pug2.png'] }
      .get('/count')
      .reply 200, { pug_count: 365 }

  afterEach ->
    room.destroy()
    nock.cleanAll()

  context 'user asks hubot for a pug', ->
    beforeEach (done) ->
      room.user.say 'alice', 'hubot pug me'
      setTimeout done, 100

    it 'should respond with a pug url', ->
      expect(room.messages).to.eql [
        [ 'alice', 'hubot pug me' ]
        [ 'hubot', 'http://imgur.com/pug.png' ]
      ]

  context 'user asks hubot for a pug bomb', ->
    beforeEach (done) ->
      room.user.say 'alice', 'hubot pug bomb'
      setTimeout done, 100

    it 'should respond with a set of pug urls', ->
      expect(room.messages).to.eql [
        ['alice', 'hubot pug bomb']
        ['hubot', 'http://imgur.com/pug1.png']
        ['hubot', 'http://imgur.com/pug2.png']
      ]

  context 'user asks hubot how many pugs there are', ->
    beforeEach (done) ->
      room.user.say 'alice', 'hubot how many pugs are there'
      setTimeout done, 100

    it 'should respond the total number of pugs', ->
      expect(room.messages).to.eql [
        ['alice', 'hubot how many pugs are there']
        ['hubot', 'There are 365 pugs.']
      ]
