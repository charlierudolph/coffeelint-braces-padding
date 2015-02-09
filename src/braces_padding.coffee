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
      {a: b }    # Bad
      { a: b}    # Bad
      { a: b }   # Bad

      # Padding is 1
      {a: b}     # Bad
      {a: b }    # Bad
      { a: b}    # Bad
      { a: b }   # Good
      { a: b  }  # Bad
      {  a: b }  # Bad
      {  a: b  } # Bad
      </code></pre>
      '''


  tokens: ['{', '}']


  tokenDistance: (firstToken, secondToken) ->
    secondToken[2].first_column - firstToken[2].last_column - 1


  tokenOnSameLine: (firstToken, secondToken) ->
    firstToken[2].first_line is secondToken[2].first_line


  findNearestToken: (token, tokenApi, difference) ->
    totalDifference = 0
    while true
      totalDifference += difference
      nearestToken = tokenApi.peek(totalDifference)
      continue if nearestToken[0] is 'OUTDENT' or nearestToken[0] is 'INDENT'
      return nearestToken


  lintToken: (token, tokenApi) ->
    return null if token.generated

    [firstToken, secondToken] = if token[0] is '{'
      [token, @findNearestToken(token, tokenApi, 1)]
    else
      [@findNearestToken(token, tokenApi, -1), token]

    return null unless @tokenOnSameLine firstToken, secondToken

    expected = tokenApi.config[@rule.name].padding
    actual = @tokenDistance firstToken, secondToken

    if actual is expected
      null
    else
      context: "Incorrect padding inside \"#{token[0]}\" (expected: #{expected}, actual: #{actual})"


module.exports = BracesPadding
