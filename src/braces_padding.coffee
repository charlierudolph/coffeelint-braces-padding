class BracesPadding

  rule:
    name: 'braces_padding'
    level: 'error'
    padding: 0
    message: 'Curly braces must have the proper padding'
    description: '''
      <p>This rule checks to see that there is the proper padding inside curly braces.
      The padding amount is specified by "padding".</p>

      <pre><code>
      # Examples

      # Padding is 0
      {a: b}     # Good
      { a: b }   # Bad
      {  a: b  } # Bad

      # Padding is 1
      {a: b}     # Bad
      { a: b }   # Good
      {  a: b  } # Bad
      </code></pre>
      '''


  tokens: ['{', '}']


  lintToken: (token, tokenApi) ->
    return null if token.generated

    expected = tokenApi.config[@rule.name].padding

    actual = if token[0] is '{'
      nextToken = tokenApi.peek 1
      nextToken[2].first_column - token[2].first_column - 1
    else
      previousToken = tokenApi.peek -1
      token[2].first_column - previousToken[2].last_column - 1

    if actual is expected
      null
    else
      context: "Incorrect padding inside \"#{token[0]}\" (expected: #{expected}, actual: #{actual})"


module.exports = BracesPadding
