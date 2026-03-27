extends PathFollow2D


signal base_damage(damage)
signal enemy_update_currency(amount)
signal end_wave()

var speed = 60
var hp = 120
var base_damage = 15
var worth = 2

##Für die Laufanimation
onready var animatedSprite = $KinematicBody2D/AnimatedSprite
var move_direction = 0

onready var health_bar = get_node("HealthBar")
onready var impact_area = get_node("Impact")
onready var impact_destruction = get_node("Destruction")
var projectile_impact = preload("res://Scenes/SupportScenes/ProjectileImpact.tscn")
var projectile_destruction = preload("res://Scenes/SupportScenes/ProjectileDestruction.tscn")

func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_as_toplevel(true)

func _physics_process(delta):
	if unit_offset == 1.0:
		emit_signal("base_damage", base_damage)
		emit_signal(("end_wave"))
		queue_free()
	move(delta)
	##Checken der Laufrichtung
	var wr = weakref($KinematicBody2D/AnimatedSprite)
	MovementLoop(delta)

func _process(_delta):
	if hp > 0:
		AnimationLoop()

func move(delta):
	set_offset(get_offset() + speed * delta)
	health_bar.set_position(position - Vector2(30, 30))

##Herausfinden der Laufrichtung
func MovementLoop(delta):
	var prepos = self.get_global_position()
	self.set_offset(self.get_offset() + speed * delta)
	var pos = self.get_global_position()
	move_direction = (pos.angle_to_point(prepos) / 3.14)*180

##Festlegen der Animation nach Laufrichtung
func AnimationLoop():
	var animation_direction
	
	if move_direction <= 120 and move_direction >= -15:
		animation_direction = "right"
	elif move_direction <= 165 or move_direction >= 120:
		animation_direction = "left"
	elif move_direction >= -165 and move_direction <= -15:
		animation_direction = "left"
	elif move_direction <= -165 or move_direction >= 165:
		animation_direction = "left"
	var animation = "walking_" + animation_direction
	animatedSprite.animation = animation

func on_hit(damage):
	impact()
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()

func impact():
	randomize()
	var x_pos = randi() % 23
	randomize()
	var y_pos = randi() % 23
	var impact_location = Vector2(x_pos, y_pos)
	var new_impact = projectile_impact.instance()
	new_impact.position = impact_location
	impact_area.add_child(new_impact)

func on_destroy():
	get_node("DeathSound").play()
	##Zerstörungsanimation
	get_node("KinematicBody2D").queue_free()
	var new_destruction = projectile_destruction.instance()
	impact_destruction.add_child(new_destruction)
	
	emit_signal("enemy_update_currency", worth)
	emit_signal("end_wave")
	yield (get_tree().create_timer(0.2),"timeout")
	self.queue_free()
