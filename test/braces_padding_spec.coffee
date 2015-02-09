coffeelint = require 'coffeelint'
BracePadding = require '../lib/braces_padding'

examples =
  implicit: 'foo: bar'
  ownLine: '''
           x = {
             foo: bar
           }
           '''
  sameLine:
    noSpaces: '{foo: bar}'
    oneSpace: '{ foo: bar }'
    twoSpaces: '{  foo: bar  }'
  splitLine:
    noSpaces: '''
              {foo,
               bar} = x
              '''
    oneSpace: '''
              { foo,
                bar } = x
              '''
    twoSpaces: '''
               {  foo,
                  bar  } = x
               '''

describe 'braces_padding', ->
  before ->
    coffeelint.registerRule BracePadding


  context 'padding set to 0', ->
    beforeEach ->
      @config = braces_padding: {padding: 0}


    context 'implicit', ->
      beforeEach ->
        @errors = coffeelint.lint examples.implicit, @config

      it 'returns no errors', ->
        expect(@errors).to.be.empty


    context 'on own line', ->
      beforeEach ->
        @errors = coffeelint.lint examples.ownLine, @config

      it 'returns no errors', ->
        expect(@errors).to.be.empty


    context 'on split line', ->

      context 'with no padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.splitLine.noSpaces, @config

        it 'returns no errors', ->
          expect(@errors).to.be.empty


      context 'with 1 space of padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.splitLine.oneSpace, @config

        it 'returns two errors', ->
          expect(@errors).to.have.lengthOf 2
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 0, actual: 1)'
          expect(@errors[1].context).to.eql 'Incorrect padding inside "}" (expected: 0, actual: 1)'


      context 'with 2 spaces of padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.splitLine.twoSpaces, @config

        it 'returns two errors', ->
          expect(@errors).to.have.lengthOf 2
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 0, actual: 2)'
          expect(@errors[1].context).to.eql 'Incorrect padding inside "}" (expected: 0, actual: 2)'


    context 'on the same line', ->

      context 'with no padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.sameLine.noSpaces, @config

        it 'returns no errors', ->
          expect(@errors).to.be.empty


      context 'with 1 space of padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.sameLine.oneSpace, @config

        it 'returns two errors', ->
          expect(@errors).to.have.lengthOf 2
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 0, actual: 1)'
          expect(@errors[1].context).to.eql 'Incorrect padding inside "}" (expected: 0, actual: 1)'


      context 'with 2 spaces of padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.sameLine.twoSpaces, @config

        it 'returns two errors', ->
          expect(@errors).to.have.lengthOf 2
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 0, actual: 2)'
          expect(@errors[1].context).to.eql 'Incorrect padding inside "}" (expected: 0, actual: 2)'


  context 'padding set to 1', ->
    beforeEach ->
      @config = braces_padding: {padding: 1}


    context 'implicit', ->
      beforeEach ->
        @errors = coffeelint.lint examples.implicit, @config

      it 'returns no errors', ->
        expect(@errors).to.be.empty


    context 'on own line', ->
      beforeEach ->
        @errors = coffeelint.lint examples.ownLine, @config

      it 'returns no errors', ->
        expect(@errors).to.be.empty


    context 'on split line', ->

      context 'with no padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.splitLine.noSpaces, @config

        it 'returns two errors', ->
          expect(@errors).to.have.lengthOf 2
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 1, actual: 0)'
          expect(@errors[1].context).to.eql 'Incorrect padding inside "}" (expected: 1, actual: 0)'


      context 'with 1 space of padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.splitLine.oneSpace, @config

        it 'returns no errors', ->
          expect(@errors).to.be.empty


      context 'with 2 spaces of padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.splitLine.twoSpaces, @config

        it 'returns two errors', ->
          expect(@errors).to.have.lengthOf 2
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 1, actual: 2)'
          expect(@errors[1].context).to.eql 'Incorrect padding inside "}" (expected: 1, actual: 2)'


    context 'on the same line', ->

      context 'with no padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.sameLine.noSpaces, @config

        it 'returns two errors', ->
          expect(@errors).to.have.lengthOf 2
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 1, actual: 0)'
          expect(@errors[1].context).to.eql 'Incorrect padding inside "}" (expected: 1, actual: 0)'


      context 'with 1 space of padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.sameLine.oneSpace, @config

        it 'returns no errors', ->
          expect(@errors).to.be.empty


      context 'with 2 spaces of padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.sameLine.twoSpaces, @config

        it 'returns two errors', ->
          expect(@errors).to.have.lengthOf 2
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 1, actual: 2)'
          expect(@errors[1].context).to.eql 'Incorrect padding inside "}" (expected: 1, actual: 2)'
