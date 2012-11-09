
ChildProcess = require 'child_process'


task 'build', 'Build and Uglify project from src/*.coffee to lib/*.js', ->
	executeAndOutput 'coffee --compile --output lib src', ->
		executeAndOutput 'uglifyjs -o lib/stopwatch.ugly.js lib/stopwatch.js', ->
			console.log 'Done.'

task 'watch', 'Build project when changed.', ->
	console.log 'Watching for changes...'
	executeAndOutput 'coffee --compile --output lib --watch src', ->
		console.log stdout

executeAndOutput = (cmd, cb) ->
	ChildProcess.exec cmd, (error, stdout, stderr) ->
		if error
			console.error error.stack
		else
			if stdout && !/^(\r|\n|\r\n)$/.test(stdout)
				console.log stdout
			if stderr
				console.log stderr
			cb?()
