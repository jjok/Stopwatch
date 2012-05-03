#
# Stopwatch
# Jonathan Jefferies (jjok)
#

class @Stopwatch
	#Directions
	@UP = 0
	@DOWN = 1

	previous_time = null
	interval = null
	self = null

	#The stopwatch time
	time = null

	#The time the stopwatch starts at / resets to
	start_time = null

	stop_time = null

	#The DOM element to draw the time to
	el = null

	#The direction the stopwatch counts in
	dir = null

	constructor: (element = null, direction, minutes = 0, seconds = 0) ->
		el = element
		start_time = new Date 0
		start_time.setMinutes minutes
		start_time.setSeconds seconds
		dir = direction
		self = @

	#Set the timer back to the start time
	reset: () ->
		time = start_time
		draw() if el isnt null
	
	start: (stopTime) ->
		stop_time ?= stopTime
		previous_time = new Date()
		console.log @
		interval = setInterval update, 100

	stop: () ->
		#console.log 'stop'
		clearInterval interval

	update = () ->
		current_time = new Date()
		diff = current_time.getTime() - previous_time.getTime()

		if dir is Stopwatch.DOWN
			milli = time.getTime() - diff

			if milli <= stop_time.getMilliseconds()
				#@stop()
				self.stop()
			else
				time.setTime milli
			#stop() if stop_time isnt null and time.getTime() <= stop_time.getTime()
		else
			time.setTime time.getTime() + diff
		

		#time.setTime new_time
		draw() if el isnt null
		previous_time = current_time
		
	draw = () ->
		min = time.getMinutes()
		min = "0" + min if min < 10 
		sec = time.getSeconds()
		sec = "0" + sec if sec < 10 
		el.innerHTML = min + ':' + sec
		