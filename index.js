(function(){

    var br = "\n"

    function extend (o) {
        Array.prototype.slice.call(arguments, 1).forEach(function(source){
            if (!source) return
            for (var keys = Object.keys(source), i = 0; i < keys.length; i++) {
                var key = keys[i]
                o[key] = source[key]
            }
        })
        return o
    }

    function unquote (str) {
        var match
        return (match = str.match(/(['"]?)(.*)\1/)) && match[2] || str
    }

    function comments (line) {
        return !/#@/.test(line[0])
    }

    function getValues (line, sep) {
        return line.split(sep).map(function(value){
            var value = unquote(value), num = +value
            return num === parseInt(value, 10) ? num : value
        })
    }

    function Parser (sep, options) {
        var opt = extend({
            header: true
        }, options)

        this.sep = sep
        this.header = opt.header
    }

    Parser.prototype.stringify = function (data) {
        var sep    = this.sep
          , head   = !!this.header
          , keys   = (typeof data[0] === 'object') && Object.keys(data[0])
          , header = keys && keys.join(sep)
          , output = head ? (header + br) : ''

        if (!data || !keys) return ''
            
        return output + data.map(function(obj){
            var item = keys ? {} : []
            var values = keys.reduce(function(p, key){
                p.push(obj[key])
                return p
            }, [])
            return values.join(sep)
        }).join(br)
    }

    Parser.prototype.parse = function (tsv) {
        var sep   = this.sep
          , lines = tsv.split(/[\n\r]/).filter(comments)
          , head  = !!this.header
          , keys  = head ? getValues(lines.shift(), sep) : {}

        if (lines.length < 1) return []

        return lines.reduce(function(output, line){
            var item = head ? {} : []
            output.push(getValues(line, sep).reduce(function(item, val, i){
                item[keys[i] || i] = val
                return item
            }, item))
            return output
        }, [])
    }

    // Export TSV parser as main, but also expose `.TSV`, `.CSV` and `.Parser`.
    var TSV = new Parser("\t")

    extend(TSV, {
        TSV    : TSV
      , CSV    : new Parser(",")
      , Parser : Parser
    })

    if (typeof module !== 'undefined' && module.exports){
        module.exports = TSV
    } else {
        this.TSV = TSV
    }

}).call(this)