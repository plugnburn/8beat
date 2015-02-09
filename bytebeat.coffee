beat = (b,e,a,t) -> 
	(a='data')+':audio/wav;base64,UklGRl9fX19XQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgA'+btoa eval "with(Math)for(t=0;++t<e*8e3;)a+=String.fromCharCode(255&(#{b}))"

aud = new Audio()

qS = (s) -> document.querySelector s
qSA = (s) -> document.querySelectorAll s
gBI = (i) -> document.getElementById i

audLoad = (expr, time) ->
	aud.src = beat expr, time

addEventListener 'DOMContentLoaded', ->

	aud.addEventListener 'ended',(e)->
		aud.currentTime = 0
		gBI('playpause').innerHTML = 'Play'

	el.addEventListener 'click',(e)->
		if aud.paused
			exel = gBI 'expr'
			tel = gBI 'duration'
			expr = exel.value
			time = parseInt tel.value
			if expr and time
				audLoad expr, time
				aud.play()
				el.innerHTML = 'Stop'
			else
				exel.focus() unless expr
				tel.focus() unless time
		else
			aud.pause()
			aud.currentTime = 0
			el.innerHTML = 'Play'
	, false for el in qSA '#playpause'

	addEventListener 'input',(e)->
		time = parseInt gBI('duration').value
		expr = gBI('expr').value
		location.hash = if time and expr then encodeURIComponent "#{time}::#{expr}" else ''

	if location.hash.length > 1
		bbData = decodeURIComponent location.hash.substr 1
		bbParts = bbData.split '::'
		if bbParts.length > 1
			time = bbParts[0]
			expr = bbParts[1]
			gBI('duration').value = time
			gBI('expr').value = expr
			audLoad expr, time

, false