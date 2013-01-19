TSV
===

Simple TSV/CSV converter and parser. Good for serving time-series (or any series) data to use in D3.js or other client-side graph libraries.

Processing is *synchronous*. **Do not use** for large datasets - use something that supports streams instead, like [node-csv-parser](http://npmjs.org/node-csv-parser).

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