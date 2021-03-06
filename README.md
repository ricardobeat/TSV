# TSV

## Deprecated

**This package is not maintained, and should not be used in production. The parser fails on non-sanitized data and is not suitable for large payloads especially in a node server. I suggest trying out [papaparse](https://www.npmjs.com/package/papaparse) or [csv-parse](https://www.npmjs.com/package/csv-parse) instead.**

TSV/CSV converter and parser. Good for serving time-series (or any series) data to use in D3.js or other client-side graph libraries.

_Warning: This module does very dumb parsing and is not suitable for unclean data not generated by yourself.
Processing is synchronous. Not suitable for large datasets. Unless you're really into minimal code, please use a better supported
tool like [node-csv-parser](http://npmjs.org/node-csv-parser)._

### Install

    npm install tsv

### Usage

    var csv = require('csv')
    var tsv = require('xsv').tsv
    { tsv, csv } = require 'xsv' // coffeescript

The `data` argument for stringify must be a flat array of objects. Keys will be derived from the first item.

    TSV.stringify([
        { id: 1, name: 'xx' },
        { id: 2, name: 'yy' }
        ...
    ])

Outputs

    id  name
    1   xx
    2   yy

### API

- `TSV.stringify(object)`
- `TSV.parse(tsv_string)`
- `CSV.stringify(object)`
- `CSV.parse(csv_string)`

#### Options and custom separators

No headers:

    // Creating a new parser
    var Parser = require('tsv').Parser
    var CSV = new Parser(",", { header: false })

    // Using the default parser
    var CSV = require('tsv').CSV
    CSV.header = false

Custom "pipe-separated values":

    var TSV = require('tsv')
    PSV = new TSV.Parser("|")

    var res = PSV.parse(...)
