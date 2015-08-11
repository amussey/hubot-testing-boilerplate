Helper = require('hubot-test-helper')
expect = require('chai').expect

# helper loads a specific script if it's a file
helper = new Helper('./../scripts/remember.coffee')

describe 'remember', ->
  room = null

  beforeEach ->
    room = helper.createRoom()

  afterEach ->
    room.destroy()

  context 'user asks for Hubot\'s memory', ->
    beforeEach ->
      room.user.say 'alice', 'hubot memory'

    it 'should reply nothing in memory', ->
      expect(room.messages).to.eql [
        ['alice', 'hubot memory']
        ['hubot', '@alice I\'m not remembering anything.']
      ]

    it 'should have the memory set to null', ->
      expect(room.robot.brain.data.memory).to.eql null

  context 'user asks Hubot to remember something', ->
    beforeEach ->
      room.user.say 'jim', 'hubot remember this'

    it 'should confirm memory populated', ->
      expect(room.messages).to.eql [
        ['jim', 'hubot remember this']
        ['hubot', '@jim Okay, I\'ll remember that.']
      ]

    it 'should have the memory set to "this"', ->
      expect(room.robot.brain.data.memory).to.eql 'this'

  context 'user sets memory and asks for memory contents', ->
    beforeEach ->
      room.user.say 'jim', 'hubot remember this'
      room.user.say 'joe', 'hubot memory'

    it 'should respond with memorized string', ->
      expect(room.messages).to.eql [
        ['jim', 'hubot remember this']
        ['hubot', '@jim Okay, I\'ll remember that.']
        ['joe', 'hubot memory']
        ['hubot', '@joe this']
      ]

    it 'should have the memory set to "this"', ->
      expect(room.robot.brain.data.memory).to.eql 'this'

  context 'user asks Hubot for memory contents', ->
    beforeEach ->
      room.robot.brain.data.memory = 'brain contents'
      room.user.say 'mary', 'hubot memory'

    it 'should reply with the contents of the memory', ->
      expect(room.messages).to.eql [
        ['mary', 'hubot memory']
        ['hubot', '@mary brain contents']
      ]
