extends Sprite

var time = 0.3 # Zeit in Sekunden, nach der das Sprite gewechselt wird
var limit = 5 # Zeit in Sekunden, nach der das Blinken beendet wird
var count = 0

func _ready():
	var timer = Timer.new()
	timer.wait_time = time
	timer.autostart = true
	timer.connect("timeout", self, "_on_timer_timeout")
	get_tree().get_root().add_child(timer)

func _on_timer_timeout():
	count += time
	if count >= limit:
		self.visible = false
		return
	self.visible = !self.visible
