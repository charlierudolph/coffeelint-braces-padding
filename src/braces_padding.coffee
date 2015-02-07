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


  tokenDistance: (t1, t2) ->
    t2[2].first_column - t1[2].first_column - 1


  tokenOnSameLine: (t1, t2) ->
    t1[2].first_line is t2[2].first_line


  lintToken: (token, tokenApi) ->
    return null if token.generated

    [firstToken, secondToken] = if token[0] is '{'
      [token, tokenApi.peek(1)]
    else
      [tokenApi.peek(-1), token]

    return null unless @tokenOnSameLine firstToken, secondToken

    expected = tokenApi.config[@rule.name].padding
    actual = @tokenDistance firstToken, secondToken

    if actual is expected
      null
    else
      context: "Incorrect padding inside \"#{token[0]}\" (expected: #{expected}, actual: #{actual})"


module.exports = BracesPadding
