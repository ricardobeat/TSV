assert = require 'assert'
fs     = require 'fs'

{ TSV, CSV } = require '../index'

tsv_data = fs.readFileSync('./test/test.tsv').toString()
csv_data = fs.readFileSync('./test/test.csv').toString()
json_data = JSON.parse(fs.readFileSync('./test/test.json').toString())

suite 'TSV', ->

    test 'JSON to TSV', ->
        assert.equal TSV.stringify(json_data), tsv_data

    test 'TSV to JSON', ->
        assert.deepEqual TSV.parse(tsv_data), json_data

suite 'CSV', ->

    test 'JSON to CSV', ->
        assert.equal CSV.stringify(json_data), csv_data

    test 'CSV to JSON', ->
        assert.deepEqual CSV.parse(csv_data), json_data