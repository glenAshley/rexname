###
	rexname
	A regex file renaming utility
###

fs = require 'fs'
path = require 'path'

# get the options passed in
options = process.argv.slice 2

if options.length < 2
	logHeader 'we need a match and replace'
	return false


# split search into body and flags
search = options[0].match /^\/?(.+?)\/?([igm]*)$/
# create regex
search = new RegExp search[1], search[2]
replace = options[1]

# store the matched filenames
matchedFiles = []

fileCount = 0 # store the number of files being renamed


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
	if doRename is not 'y'
		return false

	logHeader 'renaming files (grab a tiny coffee)'

	matchedFiles.forEach (file)->
		fileCount++
		fs.rename file.matched, file.replacement, whenFinished
		console.log "renaming  #{file.matched} --> #{file.replacement}"

	return true


# log when finished
whenFinished = ()->
	if --fileCount then return
	console.log '\nall done'
