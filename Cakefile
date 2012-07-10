fs     = require 'fs'
{exec} = require 'child_process'
{print} = require 'util'
{spawn} = require 'child_process'

task 'styles', 'Build styles', ->
  exec 'lessc src/jquery.slideMatrix.less > lib/jquery.slideMatrix.css'

task 'build', 'Build lib/ from src/', ->
  coffee = spawn 'coffee', ['-c', '-l', '-o', 'lib', 'src']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

task 'watch', 'Watch src/ for changes', ->
  coffee = spawn 'coffee', ['-w', '-c', '-l', '-o', 'lib', 'src']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()

task 'minify', 'Minify the resulting application file after build', ->
  exec 'java -jar "/Users/Ryguy/Code/Java/closure_compiler.jar" --js lib/inflection.js --js_output_file lib/inflection.min.js', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
    
    false