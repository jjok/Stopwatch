"use strict"

#
# Stopwatch
# @author Jonathan Jefferies (jjok)
#
class @Stopwatch

	# Directions
	@UP = 0
	@DOWN = 1

	previous_time = null
	interval = null
	self = null

	# The stopwatch time
	time = null

	# The time the stopwatch starts at / resets to.
	start_time = null

	# The time for the stopwatch to stop at.
	stop_time = null

	# The DOM element to draw the time to.
	el = null

	# The direction the stopwatch counts in.
	dir = null

	#
	# Constructor
	# @param element
	# @param {int} direction
	# @param {int} minutes
	# @param {int} seconds
	#
	constructor: (element = null, direction, minutes = 0, seconds = 0) ->
		el = element
		start_time = new Date 0
		start_time.setMinutes minutes
		start_time.setSeconds seconds
		dir = direction
		self = @

	#
	# Set the timer back to the start time
	# @visibility public
	#
	reset: ->
		time = start_time
		draw() if el isnt null

	#
	# Start the stopwatch
	# @visibility public
	# @param {Date} stopTime 
	#
	start: (stopTime) ->
		stop_time ?= stopTime
		previous_time = new Date()
		interval = setInterval update, 100

	#	
	# Stop the stopwatch
	# @visibility public
	# 
	stop: ->
		clearInterval interval

	#
	# Update the clock
	# @visibility private
	#
	update = ->
		current_time = new Date()
		diff = current_time.getTime() - previous_time.getTime()

		# Down
		if dir is Stopwatch.DOWN
			milli = time.getTime() - diff

			if stop_time? and milli <= stop_time.getMilliseconds()
				self.stop()
			else
				time.setTime milli
		# Up
		else
			milli = time.getTime() + diff
			
			if stop_time? and milli >= stop_time.getMilliseconds()
				self.stop()
			else
				time.setTime milli

		draw() if el isnt null
		previous_time = current_time

	#
	# Draw the current time to the screen, if required
	# @visibility private
	# 
	draw = ->
		min = time.getMinutes()
		min = "0" + min if min < 10 
		sec = time.getSeconds()
		sec = "0" + sec if sec < 10 
		el.innerHTML = min + ':' + sec
