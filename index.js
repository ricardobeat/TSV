(function(){

    var TSV = {}
      , sep = "\t"
      , br  = "\n"

    TSV.stringify = function (data) {
        var keys   = Object.keys(data[0])
          , header = keys.join(sep)
          , output = header + br

        return output + data.map(function(obj){
            var values = keys.reduce(function(p, key){
                p.push(obj[key])
                return p
            }, [])
            return values.join(sep)
        }).join(br)
    }

    function comments (line) {
        return !/#@/.test(line[0])
    }

    TSV.parse = function (tsv) {
        var lines = tsv.split(/[\n\r]/).filter(comments)
          , keys  = lines.shift().split(sep)

        return lines.reduce(function(p, line){
            p.push(line.split(sep).reduce(function(p, val, i){
                p[keys[i]] = val
                return p
            }, {}))
            return p
        }, [])
    }

    if (typeof module !== 'undefined' && module.exports){
        module.exports = TSV
    } else {
        this.TSV = TSV
    }

}).call(this)