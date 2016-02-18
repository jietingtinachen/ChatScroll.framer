# This imports all the layers for "scroll" into scrollLayers1
sketch = Framer.Importer.load "imported/scroll"

#creat scroll component
scroll = ScrollComponent.wrap(sketch.scrollContent)

#define scrollble area
scroll.scrollHorizontal = false
scroll.x = 0
scroll.y = 0
scroll.width = 750
scroll.height = 1350

#capture the scroll interaction
originScrollY = 0
currentScrollY = 0
diffScrollY = currentScrollY-originScrollY
#listen to the event, and print out if the scroll is happening
scroll.on Events.ScrollStart,() ->
	#print("scroll start: " + scroll.scrollY)
	originScrollY = scroll.scrollY
	
scroll.on Events.Scroll, () ->
	#print("is scrolling: " + scroll.scrollY)
	currentScrollY = scroll.scrollY
	diffScrollY = currentScrollY-originScrollY
	diffScrollY = diffScrollY / 3000.0
	#detect scroll direction
	if diffScrollY > 1.0
		diffScrollY = 1.0
	if diffScrollY < -1.0
		diffScrollY = -1.0
	if (diffScrollY >= 0.0) and (button.states.current == "btnIn")
	#This is a function to figure out the path 
		button.y = btnInState.y + diffScrollY * (btnOutState.y - btnInState.y)
		#print("going out")
		
#switching bettween two states
scroll.on Events.ScrollEnd, () ->
	#print("scroll end: " + scroll.scrollY)
	if (diffScrollY>0)
		button.states.switch("btnOut")
	else
		button.states.switch("btnIn")
	
#assign the button from sketch to the button
window.button = sketch.button

# #option1
# btnInState = {
# 	x:550 
# 	y:1120 
# } 
# 
# btnOutState = {
# 		x:550 
# 		y:1500 
# }

#option2
btnInState = {
	x:550 
	y:1210
} 

btnOutState = {
		x:550 
		y:1500
}

# Create additional states
button.states.add
	btnIn: btnInState
	btnOut: btnOutState
	
button.states.animationOptions = 
	curve: "spring(100,13,0)"
	
button.states.switchInstant("btnIn")










