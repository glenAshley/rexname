###
	rexname
	A regex file renaming utility
###

fs = require 'fs'
path = require 'path'
matchedFiles = [] # store the matched filenames


readFiles = ()->
	# get the options passed in
	options = process.argv.slice 2
	# split search into body and flags
	search = options[0].match /^\/?(.+?)\/?([igm]*)$/
	# create regex
	search = new RegExp search[1], search[2]
	replace = options[1]

	if options.length < 2
		logHeader 'we need a match and replace'
		return false

	# read the files in the current directory
	fs.readdir process.cwd(), (error, files)->
		if error
			logHeader 'there was an error'
			return false

		# filter the files
		files = files.filter (file)->
			return search.test file

		# store the match and replacment
		files.forEach (file)->
			matchedFiles.push
				matched: file
				replacement: file.replace search, replace

		listFiles matchedFiles

		getInput 'Do you want to proceed? y/n', renameFiles

		return true


# Add new lines and bars to the a message
logHeader = (message)->
	console.log "\n==== #{message} ====\n"


# list the files
listFiles = (files)->
	logHeader 'matched files'

	files.forEach (file)->
		console.log "  #{file.matched} --> #{file.replacement}"


#  Promt for input and return it to a callback
getInput = (message, callback)->
	console.log "\n#{message}"

	# start listening for keystrokes
	process.stdin.resume()
	process.stdin.setEncoding 'utf8'

	# handle keystrokes
	process.stdin.on 'data', (text)->
		# return the text
		if typeof callback is 'function'
			callback text
		process.exit()


# rename the files
renameFiles = (doRename)->
	if doRename[0] != 'y'
		return false

	logHeader 'renaming files (grab a tiny coffee)'

	matchedFiles.forEach (file)->
		fs.renameSync file.matched, file.replacement
		console.log "renaming  #{file.matched} --> #{file.replacement}"

	console.log '\n'

	return true


readFiles()
