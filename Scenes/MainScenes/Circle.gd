extends Sprite

func _ready():
	var timer = Timer.new()
	timer.wait_time = 5
	timer.connect("timeout", self, "_on_timer_timeout")
	get_tree().get_root().add_child(timer)
	timer.start()

func _on_timer_timeout():
	self.visible = false
