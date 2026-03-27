extends Node2D

signal game_finished(result)

var map_node
var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type
var new_tower
var current_wave = 0
var enemies_in_wave = 0
var base_health = 100
var money = 50

func _ready():
	map_node = get_node("Map_Heumarkt") ##Turn this variable based on selected map
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed", self, "initiate_build_mode", [i.get_name()])

func _process(_delta):
	if build_mode:
		update_tower_preview()

##accepting/canceling tower-placement
func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

##
## Wave Functions
##

func start_next_wave():
	var next_wave_data = retrieve_wave_data()
	current_wave += 1
	yield(get_tree().create_timer(1.5),"timeout") ## time-padding between waves so they dont start instantly
	spawn_enemies(next_wave_data)
	

## number/timing of enemies and number of waves
# Muss schwerer werden --> mehr starke Gegner
func retrieve_wave_data():
	var wave_data
	if current_wave == 1:
		wave_data = [["S_Zombie", 0.5]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 2:
		wave_data = [["S_Zombie", 0.5], ["S_Zombie", 0.5]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 3:
		wave_data = [["S_Zombie", 0.5], ["S_Zombie", 0.5], ["S_Zombie", 0.5]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 4:
		wave_data = [["S_Zombie", 0.5], ["S_Zombie02", 0.5], ["S_Zombie", 0.5]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 5:
		wave_data = [["Zombie", 0.5], ["S_Zombie02", 0.5], ["S_Zombie", 0.5], ["S_Zombie", 0.5], ["S_Zombie", 0.5], ["S_Zombie02", 0.5]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 6:
		wave_data = [["Zombie", 0.5], ["Zombie", 0.5], ["S_Zombie", 0.5], ["S_Zombie", 0.5], ["S_Zombie", 0.5], ["S_Zombie02", 0.5], ["S_Zombie", 0.5], ["S_Zombie02", 0.5]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 7:
		wave_data = [["S_Zombie", 0.5], ["S_Zombie02", 0.5], ["Zombie", 0.5], ["Zombie", 0.5], ["S_Zombie02", 0.5], ["S_Zombie", 0.5], ["S_Zombie", 0.5], ["S_Zombie", 0.5], ["S_Zombie02", 0.5], ["S_Zombie", 0.5]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 8:
		wave_data = [["Zombie", 0.5], ["Zombie", 0.5], ["Zombie", 0.5], ["Zombie", 0.5]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 9:
		wave_data = [["Zombie", 0.5], ["Zombie", 0.5], ["S_Zombie02", 0.5], ["S_Zombie", 0.5], ["S_Zombie", 0.5], ["S_Zombie02", 0.5], ["S_Zombie02", 0.5], ["S_Zombie", 0.5]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 10:
		wave_data = [["Demon", 0.5], ["S_Zombie03", 0.5], ["S_Zombie03", 0.5], ["S_Zombie02", 0.5], ["S_Zombie02", 0.5], ["S_Zombie", 0.5], ["Zombie", 0.5], ["Zombie", 0.5], ["Zombie", 0.5], ["Zombie", 0.5]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 11:
		wave_data = [["Zombie02", 0.5], ["Zombie02", 0.3], ["Demon", 0.3], ["S_Zombie03", 0.3], ["S_Zombie03", 0.3], ["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["Zombie02", 0.3], ["Zombie03", 0.3],
		["Zombie03", 0.3], ["Zombie02", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 12:
		wave_data = [["Zombie02", 0.5], ["Zombie02", 0.3], ["Demon", 0.3], ["Demon", 0.3], ["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["Demon", 0.3], ["Zombie02", 0.3], ["Zombie02", 0.3],
		["Zombie02", 0.3], ["Zombie02", 0.3], ["Zombie03", 0.3], ["Zombie02", 0.3], ["Zombie03", 0.3], ["Zombie02", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 13:
		wave_data = [["Zombie02", 0.5], ["Zombie02", 0.3], ["Zombie02", 0.5], ["Zombie02", 0.3], ["Zombie02", 0.5], ["Zombie02", 0.3], ["Demon02", 0.3],  ["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["S_Zombie02", 0.3],
		["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["Zombie03", 0.3], ["Zombie03", 0.3], ["Zombie02", 0.3], ["Zombie02", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 14:
		wave_data = [["Demon", 0.5], ["Demon", 0.3], ["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["S_Zombie03", 0.3], ["Demon", 0.3], ["Demon", 0.3],
		["Zombie03", 0.3], ["Demon", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 15:
		wave_data = [["Demon", 0.3], ["Demon", 0.3], ["S_Zombie03", 0.3], ["S_Zombie03", 0.3], ["Zombie", 0.5], ["Zombie", 0.3], ["S_Zombie03", 0.3], ["Demon", 0.3], ["Zombie", 0.3], ["Zombie", 0.3],
		["Zombie", 0.3], ["Zombie", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 16:
		wave_data = [["S_Zombie03", 0.5], ["S_Zombie03", 0.3], ["Demon", 0.3], ["Demon", 0.3], ["S_Zombie03", 0.3], ["S_Zombie03", 0.3], ["S_Zombie03", 0.3], ["Demon", 0.3], ["Zombie03", 0.3], ["Zombie03", 0.3],
		["Zombie03", 0.3], ["Zombie03", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 17:
		wave_data = [["Zombie03", 0.5], ["Zombie03", 0.3], ["Demon02", 0.3], ["Demon02", 0.3], ["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["S_Zombie02", 0.3], ["Demon02", 0.3], ["Zombie02", 0.3], ["Zombie02", 0.3],
		["Zombie02", 0.3], ["Zombie02", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 18:
		wave_data = [["Zombie03", 0.5], ["Zombie03", 0.3], ["Zombie03", 0.3], ["Zombie03", 0.3], ["Zombie03", 0.3], ["Zombie03", 0.3], ["Zombie03", 0.3], ["Zombie03", 0.3], ["Zombie03", 0.3], ["Zombie03", 0.3],
		["Zombie03", 0.3], ["Zombie03", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 19:
		wave_data = [["Demon04", 1.0]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 20:
		wave_data = [["S_Zombie03", 0.5], ["S_Zombie03", 0.3], ["S_Zombie03", 0.3], ["S_Zombie03", 0.3], ["S_Zombie03", 0.3], ["S_Zombie03", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 21:
		wave_data = [["Demon03", 0.5], ["Demon03", 0.3], ["Zombie04", 0.3], ["Demon03", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 22:
		wave_data = [["Demon03", 0.5], ["Demon03", 0.3], ["S_Zombie03", 0.3], ["S_Zombie03", 0.3], ["Zombie04", 0.3], ["Demon03", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 23:
		wave_data = [["Demon03", 0.5], ["Demon03", 0.3], ["S_Zombie03", 0.3], ["S_Zombie03", 0.3], ["Zombie04", 0.3], ["Demon03", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3] , ["Demon03", 0.3], ["Zombie04", 0.3],
		["Zombie04", 0.3] , ["Demon03", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 24:
		wave_data = [["Demon04", 0.5], ["Demon04", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3], ["Demon04", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 25:
		wave_data = [["Demon04", 0.5], ["Demon04", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3], ["Demon04", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3], ["Demon04", 0.5], ["Demon04", 0.3],
		["Zombie04", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3], ["Demon04", 0.3], ["Zombie04", 0.3], ["Zombie04", 0.3]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 26:
		wave_data = [["S_Zombie", 2], ["S_Zombie", 2], ["S_Zombie", 2], ["S_Zombie", 2], ["S_Zombie", 2], ["S_Zombie", 2], ["S_Zombie", 2], ["S_Zombie", 2]]
		enemies_in_wave = wave_data.size()
		update_wave_counter(current_wave)
		return wave_data
	elif current_wave == 27:
		#yield (get_tree().create_timer(0.2),"timeout")
		emit_signal("game_finished", "won")
		wave_data = []
	#enemies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instance()
		new_enemy.connect("base_damage", self, 'on_base_damage')
		new_enemy.connect("enemy_update_currency", self, 'update_money')
		new_enemy.connect("end_wave", self, 'end_wave')
		map_node.get_node("Path").add_child(new_enemy, true)
		yield(get_tree().create_timer(i[1]),"timeout")

func end_wave():
	enemies_in_wave -= 1
	if enemies_in_wave == 0:
		start_next_wave()

##
## Building Functions
##

##activating build mode
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type# + "T1"
	build_mode = true
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

##Checking if there the tower is (not) obstructed
func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").world_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_world(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cellv(current_tile) == -1:
		get_node("UI").update_tower_preview(tile_position, "ad54ff3c")
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		get_node("UI").update_tower_preview(tile_position, "adff4545")
		build_valid = false

##canceling build mode
func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").free()

##placing tower if possible
func verify_and_build():
	if build_valid:
		##Test to verify that player has enough cash
		new_tower = load("res://Scenes/Turrets/" + build_type + ".tscn").instance()
		new_tower.position = build_location
		new_tower.built = true
		new_tower.type = build_type
		new_tower.category = GameData.tower_data[build_type]["category"]
		map_node.get_node("Turrets").add_child(new_tower, true)
		map_node.get_node("TowerExclusion").set_cellv(build_tile, 5)
		##Deduct cash, update cash label
		new_tower.cost = GameData.tower_data[build_type]["cost"]
		update_money(-new_tower.cost)

##
## More Game-functions
##

func on_base_damage(damage):
	base_health -= damage
	if base_health <= 0:
		emit_signal("game_finished", "lost")
	else:
		get_node("UI").update_health_bar(base_health)

func update_money(amount):
	money += amount
	get_node("UI").update_currency(money)
	update_buildable()

func update_wave_counter(currentWave):
	var numberOfWaves = 26 ##Variable je nach Level ändern!
	get_node("UI").update_wave_counter(currentWave, numberOfWaves)

func update_buildable():
	for i in get_tree().get_nodes_in_group("build_buttons"):
		var tower_price = GameData.tower_data[i.get_name()]["cost"]
		if money >= tower_price:
			i.set_disabled(false)
		else:
			i.set_disabled(true)

func _on_MainMenu_pressed():
	get_node("ButtonSound_Click").play()
	yield (get_tree().create_timer(0.2),"timeout")
	emit_signal("game_finished", "quit")
