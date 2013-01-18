assert = require 'assert'
fs     = require 'fs'

TSV = require '../index'

console.log(TSV)

tsv_data = fs.readFileSync('./test/test.tsv').toString()
json_data = JSON.parse(fs.readFileSync('./test/test.json').toString())


suite 'TSV', ->

    test 'JSON to TSV', ->
        assert.equal TSV.stringify(json_data), tsv_data

    test 'TSV to JSON', ->
        assert.deepEqual TSV.parse(tsv_data), json_data