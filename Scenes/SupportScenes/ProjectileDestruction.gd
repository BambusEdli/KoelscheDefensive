extends AnimatedSprite

func _ready():
	set_playing(true)

func _on_ProjectileDestruction_animation_finished():
	queue_free()
