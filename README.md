# coffeelint-braces-padding

[![npm version](https://badge.fury.io/js/coffeelint-braces-padding.svg)](http://badge.fury.io/js/coffeelint-braces-padding)
[![Build Status](https://travis-ci.org/charlierudolph/coffeelint-braces-padding.svg?branch=cr-travis)](https://travis-ci.org/charlierudolph/coffeelint-braces-padding)

## Examples
```coffee
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
```

## Installation

```
npm install coffeelint-braces-padding
```

## Usage

Put this in your coffeelint config:

```json
"braces_padding": {
  "module": "coffeelint-braces-padding",
  "padding": 0
}
```

## Options

`padding` - the number of spaces there should be inside curly braces. Default: `0`
