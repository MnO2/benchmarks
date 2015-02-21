fs = require 'fs'
path = require 'path'
lazy = require 'lazy'
BlockStream = require 'block-stream'

printLine = (line) -> process.stdout.write line + '\n'

usage = -> printLine ("Usage: " + process.argv[1] + " <filename>")

if process.argv.length < 3
    usage()
    process.exit(0)
else
    filename = process.argv[2]
    printLine("reading " + filename + " ...")

    d = {}

    dedupeFile = (chunk) ->
        if chunk of d
            d[chunk] += 1
        else
            d[chunk] = 1

    block = new BlockStream(512)
    rstream = fs.createReadStream(filename).pipe(block)
    block.on('data', (chunk) -> dedupeFile(chunk))
    block.on('end', -> printLine('Done'))
