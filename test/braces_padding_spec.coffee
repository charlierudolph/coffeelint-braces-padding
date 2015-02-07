coffeelint = require 'coffeelint'
BracePadding = require '../lib/braces_padding'

examples =
  differentLines: '''
                  x = {
                    foo: bar
                  }
                  '''
  implicit: 'foo: bar'
  noSpaces: '{foo: bar}'
  oneSpace: '{ foo: bar }'
  oneSpaceLeft: '{ foo: bar}'
  oneSpaceRight: '{foo: bar }'
  twoSpaceLeftOneSpaceRight: '{  foo: bar }'



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


    context 'on different lines', ->
      beforeEach ->
        @errors = coffeelint.lint examples.differentLines, @config

      it 'returns no errors', ->
        expect(@errors).to.be.empty


    context 'on the same line', ->

      context 'with no padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.noSpaces, @config

        it 'returns no errors', ->
          expect(@errors).to.be.empty


      context 'with 1 space of padding on the left brace', ->
        beforeEach ->
          @errors = coffeelint.lint examples.oneSpaceLeft, @config

        it 'returns an error', ->
          expect(@errors).to.have.lengthOf 1
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 0, actual: 1)'


      context 'with 1 space of padding on the right brace', ->
        beforeEach ->
          @errors = coffeelint.lint examples.oneSpaceRight, @config

        it 'returns an error', ->
          expect(@errors).to.have.lengthOf 1
          expect(@errors[0].context).to.eql 'Incorrect padding inside "}" (expected: 0, actual: 1)'


      context 'with 1 space of padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.oneSpace, @config

        it 'returns two errors', ->
          expect(@errors).to.have.lengthOf 2
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 0, actual: 1)'
          expect(@errors[1].context).to.eql 'Incorrect padding inside "}" (expected: 0, actual: 1)'


  context 'padding set to 1', ->
    beforeEach ->
      @config = braces_padding: {padding: 1}


    context 'implicit', ->
      beforeEach ->
        @errors = coffeelint.lint examples.implicit, @config

      it 'returns no errors', ->
        expect(@errors).to.be.empty


    context 'on different lines', ->
      beforeEach ->
        @errors = coffeelint.lint examples.differentLines, @config

      it 'returns no errors', ->
        expect(@errors).to.be.empty


    context 'on the same line', ->

      context 'with no padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.noSpaces, @config

        it 'returns two errors', ->
          expect(@errors).to.have.lengthOf 2
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 1, actual: 0)'
          expect(@errors[1].context).to.eql 'Incorrect padding inside "}" (expected: 1, actual: 0)'


      context 'with no padding on the left brace', ->
        beforeEach ->
          @errors = coffeelint.lint examples.oneSpaceLeft, @config

        it 'returns an error', ->
          expect(@errors).to.have.lengthOf 1
          expect(@errors[0].context).to.eql 'Incorrect padding inside "}" (expected: 1, actual: 0)'


      context 'with no padding on the right brace', ->
        beforeEach ->
          @errors = coffeelint.lint examples.oneSpaceRight, @config

        it 'returns an error', ->
          expect(@errors).to.have.lengthOf 1
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 1, actual: 0)'


      context 'with 1 space of padding', ->
        beforeEach ->
          @errors = coffeelint.lint examples.oneSpace, @config

        it 'returns no errors', ->
          expect(@errors).to.be.empty


      context 'with 2 spaces of padding on the left brace, 1 space of padding on the right', ->
        beforeEach ->
          @errors = coffeelint.lint examples.twoSpaceLeftOneSpaceRight, @config

        it 'returns an error', ->
          expect(@errors).to.have.lengthOf 1
          expect(@errors[0].context).to.eql 'Incorrect padding inside "{" (expected: 1, actual: 2)'
