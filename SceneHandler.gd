extends Node

func _ready():
	load_main_menu()

func load_main_menu():
	get_node("MainMenu/M/VB/NewGame").connect("pressed", self, "on_new_game_pressed")
	get_node("MainMenu/M/VB/Options").connect("pressed", self, "on_options_pressed")
	get_node("MainMenu/M/VB/About").connect("pressed", self, "on_about_pressed")
	get_node("MainMenu/M/VB/Quit").connect("pressed", self, "on_quit_pressed")
	
	get_node("Levels/M/VB/Level_Neumarkt").connect("pressed", self, "load_neumarkt")
	get_node("Levels/M/VB/Level_Heumarkt").connect("pressed", self, "load_heumarkt")
	get_node("Levels/M/VB/Level_Aachener").connect("pressed", self, "load_aachener")
	get_node("Levels/M/VB/Main_Menu").connect("pressed", self, "on_backToMenu_pressed")

func on_new_game_pressed():
	get_node("MainMenu/ButtonSound_Click").play()
	yield (get_tree().create_timer(0.2),"timeout")
	get_node("MainMenu").queue_free()
	## Old code below:
	#var game_scene = load("res://Scenes/MainScenes/GameScene.tscn").instance()
	#game_scene.connect("game_finished", self, 'unload_game')
	#add_child(game_scene)

func on_options_pressed():
	get_node("MainMenu/ButtonSound_Click").play()
	yield (get_tree().create_timer(0.2),"timeout")
	var options_menu = load("res://Scenes/UIScenes/OptionsMenu.tscn").instance()
	add_child(options_menu)
	get_node("OptionsMenu").connect("CloseOptionsMenu", self, "CloseOptionsMenu")
	
func CloseOptionsMenu():
	get_node("OptionsMenu/HBoxContainer/Column3/Back/ButtonSound_Back").play()
	yield (get_tree().create_timer(0.2),"timeout")
	get_node("OptionsMenu").queue_free()

func on_about_pressed():
	get_node("MainMenu/ButtonSound_Click").play()
	yield (get_tree().create_timer(0.2),"timeout")
	OS.shell_open("https://dh.phil-fak.uni-koeln.de/dhcon-2022")

##Zurück ins Hauptmenü
func on_backToMenu_pressed():
	get_node("Levels/ButtonSound_Click").play()
	yield (get_tree().create_timer(0.2),"timeout")
	var main_menu = load("res://Scenes/UIScenes/MainMenu.tscn").instance()
	add_child(main_menu)
	load_main_menu()

func on_quit_pressed():
	get_node("MainMenu/ButtonSound_Click").play()
	yield (get_tree().create_timer(0.5),"timeout")
	get_tree().quit()

##
##Verschiedene Level laden
##

## Neumarkt
func load_neumarkt():
	get_node("Levels/ButtonSound_Gun").play()
	yield (get_tree().create_timer(0.5),"timeout")
	get_node("Levels").queue_free()
	var game_scene = load("res://Scenes/MainScenes/NeumarktScene.tscn").instance()
	game_scene.connect("game_finished", self, 'unload_neumarkt')
	add_child(game_scene)

func unload_neumarkt(_result):
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	#yield (get_tree().create_timer(0.2),"timeout")
	get_node("NeumarktScene").queue_free()
	var levels = load("res://Scenes/UIScenes/Levels.tscn").instance()
	add_child(levels)
	var main_menu = load("res://Scenes/UIScenes/MainMenu.tscn").instance()
	add_child(main_menu)
	load_main_menu()
	##Verschiedene Arten vom Beenden
	if _result == "quit":
		pass
	if _result == "lost":
		var screenLost = load("res://Scenes/UIScenes/ScreenLost.tscn").instance()
		add_child(screenLost)
		get_node("ScreenLost/M/VB/NewGame").connect("pressed", self, "lost_NewGame")
		get_node("ScreenLost/M/VB/MainMenu").connect("pressed", self, "lost_MainMenu")
	if _result == "won":
		var screenWon = load("res://Scenes/UIScenes/ScreenWin.tscn").instance()
		add_child(screenWon)
		get_node("ScreenWin/M/VB/NewGame").connect("pressed", self, "won_NewGame")
		get_node("ScreenWin/M/VB/MainMenu").connect("pressed", self, "won_MainMenu")

##Heumarkt
func load_heumarkt():
	get_node("Levels/ButtonSound_Gun").play()
	yield (get_tree().create_timer(0.5),"timeout")
	get_node("Levels").queue_free()
	var game_scene = load("res://Scenes/MainScenes/HeumarktScene.tscn").instance()
	game_scene.connect("game_finished", self, 'unload_heumarkt')
	add_child(game_scene)

func unload_heumarkt(_result):
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	#yield (get_tree().create_timer(0.2),"timeout")
	get_node("HeumarktScene").queue_free()
	var levels = load("res://Scenes/UIScenes/Levels.tscn").instance()
	add_child(levels)
	var main_menu = load("res://Scenes/UIScenes/MainMenu.tscn").instance()
	add_child(main_menu)
	load_main_menu()
	##Verschiedene Arten vom Beenden
	if _result == "quit":
		pass
	if _result == "lost":
		var screenLost = load("res://Scenes/UIScenes/ScreenLost.tscn").instance()
		add_child(screenLost)
		get_node("ScreenLost/M/VB/NewGame").connect("pressed", self, "lost_NewGame")
		get_node("ScreenLost/M/VB/MainMenu").connect("pressed", self, "lost_MainMenu")
	if _result == "won":
		var screenWon = load("res://Scenes/UIScenes/ScreenWin.tscn").instance()
		add_child(screenWon)
		get_node("ScreenWin/M/VB/NewGame").connect("pressed", self, "won_NewGame")
		get_node("ScreenWin/M/VB/MainMenu").connect("pressed", self, "won_MainMenu")

##Aachener Weiher
func load_aachener():
	get_node("Levels/ButtonSound_Gun").play()
	yield (get_tree().create_timer(0.5),"timeout")
	get_node("Levels").queue_free()
	var game_scene = load("res://Scenes/MainScenes/AachenerScene.tscn").instance()
	game_scene.connect("game_finished", self, 'unload_aachener')
	add_child(game_scene)

func unload_aachener(_result):
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	#yield (get_tree().create_timer(0.2),"timeout")
	get_node("AachenerScene").queue_free() ##"GameScene" hier durch Aachener-Node ersetzen
	var levels = load("res://Scenes/UIScenes/Levels.tscn").instance()
	add_child(levels)
	var main_menu = load("res://Scenes/UIScenes/MainMenu.tscn").instance()
	add_child(main_menu)
	load_main_menu()
	
	if _result == "quit":
		pass
	if _result == "lost":
		yield (get_tree().create_timer(0.2),"timeout")
		var screenLost = load("res://Scenes/UIScenes/ScreenLost.tscn").instance()
		add_child(screenLost)
		get_node("ScreenLost/LostSound").play()
		get_node("ScreenLost/M/VB/NewGame").connect("pressed", self, "lost_NewGame")
		get_node("ScreenLost/M/VB/MainMenu").connect("pressed", self, "lost_MainMenu")
	if _result == "won":
		yield (get_tree().create_timer(0.2),"timeout")
		var screenWon = load("res://Scenes/UIScenes/ScreenWin.tscn").instance()
		add_child(screenWon)
		get_node("ScreenWin/M/VB/NewGame").connect("pressed", self, "won_NewGame")
		get_node("ScreenWin/M/VB/MainMenu").connect("pressed", self, "won_MainMenu")

##Funktionen für Endcreens
func lost_NewGame():
	get_node("ScreenLost/ButtonSound").play()
	yield (get_tree().create_timer(0.2),"timeout")
	get_node("ScreenLost").queue_free()
	get_node("MainMenu").queue_free()
func lost_MainMenu():
	get_node("ScreenLost/ButtonSound").play()
	yield (get_tree().create_timer(0.2),"timeout")
	get_node("ScreenLost").queue_free()
	
func won_NewGame():
	get_node("ScreenWin/ButtonSound").play()
	yield (get_tree().create_timer(0.2),"timeout")
	get_node("ScreenWin").queue_free()
	get_node("MainMenu").queue_free()
func won_MainMenu():
	get_node("ScreenWin/ButtonSound").play()
	yield (get_tree().create_timer(0.2),"timeout")
	get_node("ScreenWin").queue_free()
