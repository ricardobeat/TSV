assert = require 'assert'
fs     = require 'fs'

tsv = require '../index'

{ TSV, CSV } = tsv

tsv_data = fs.readFileSync('./test/test.tsv').toString()
csv_data = fs.readFileSync('./test/test.csv').toString()
json_data = JSON.parse(fs.readFileSync('./test/test.json').toString())
json_4k = JSON.parse(fs.readFileSync('./test/fb.json').toString())

ssv_data = fs.readFileSync('./test/headerless.ssv').toString()
json_ssv = JSON.parse(fs.readFileSync('./test/headerless.json').toString())

suite 'TSV', ->

    test 'JSON to TSV', ->
        assert.deepEqual TSV.parse(TSV.stringify(json_data)), json_data

    test 'TSV to JSON', ->
        assert.deepEqual TSV.parse(tsv_data), json_data

suite 'CSV', ->

    test 'JSON to CSV', ->
        assert.deepEqual CSV.parse(CSV.stringify(json_data)), json_data

    test 'CSV to JSON', ->
        assert.deepEqual CSV.parse(csv_data), json_data

suite 'Options', ->

    test 'Star-separated file without header', ->
        SSV = new TSV.Parser("*", { header: false })
        assert.deepEqual SSV.parse(ssv_data), json_ssv
        SSV = new TSV.Parser("*")
        SSV.header = false
        assert.deepEqual SSV.parse(SSV.stringify(json_ssv)), json_ssv

suite 'Fail gracefully', ->

    test 'stringify', ->
        assert.equal TSV.stringify({}), ''
        assert.equal TSV.stringify([]), ''
        assert.equal TSV.stringify(Number), ''
        assert.equal TSV.stringify([1,2,3]), ''

    test 'parse', ->
        assert.deepEqual TSV.parse(''), []
        assert.deepEqual TSV.parse('  '), []
        assert.deepEqual TSV.parse('blah blah'), []

suite 'Larger files', ->

    test '4kb', ->
        tsv_4k = TSV.stringify(json_4k)
        assert.equal JSON.stringify(TSV.parse(tsv_4k)), JSON.stringify(json_4k)
