class fixedScroll

	constructor:->
		@$containers	= 	$('.container-l')
		@$bh 		= 	$('body')
		@$w 			= 	$(window)
		@elemI 		= 	0
		@allowScroll 	= 	true
		@lastScrollTop = 	0

		@listenToScroll()

	listenToScroll:->
		newScroll = $.throttle 500, @scroll
		
		@$w.on 'scroll', $.proxy newScroll, @

	scroll:->
		if !@allowScroll then return
		st = @$bh.scrollTop()
		if (st > @lastScrollTop) then @scrollDown() else @scrollUp()   
		@lastScrollTop = st
		return false

	scrollDown:->
		if @$bh.scrollTop() > @$containers.eq(@elemI).position().top
			@elemI++
			@elemI > @$containers.length - 1 and @elemI = @$containers.length - 1
			@scrollTo @$containers.eq(@elemI).position().top

	scrollUp:->
		if @$bh.scrollTop() < @$containers.eq(@elemI).position().top
			@elemI--
			@elemI < 0 and @elemI = 0
			@scrollTo @$containers.eq(@elemI).position().top


	scrollTo:(position)->
		@allowScroll = false
		$('body').css 'overflow': 'hidden'
		@$bh.stop().animate 'scrollTop': position, 400, =>
			setTimeout =>
				$('body').css 'overflow': 'auto'
				@allowScroll = true
			, 200

new fixedScroll




