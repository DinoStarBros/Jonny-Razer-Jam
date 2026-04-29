extends Node

const world_1_lvl : String = "res://Levels/World1Lvl/world1lvl.tscn"

var world1_levels_res : Array = [
	load("res://LevelResources/World1/1-1.tres"),
	load("res://LevelResources/World1/1-2.tres"),
	load("res://LevelResources/World1/1-3.tres"),
	load("res://LevelResources/World1/1-4.tres"),
	load("res://LevelResources/World1/1-5.tres"),
	load("res://LevelResources/World1/1-6.tres"),
	load("res://LevelResources/World1/1-7.tres"),
	load("res://LevelResources/World1/1-8.tres"),
	load("res://LevelResources/World1/1-9.tres"),
	load("res://LevelResources/World1/1-10.tres"),
	
]

const enemies_def_scn : PackedScene = preload("res://juices/EnemiesDefeatedPopup/enemies_defeated_popup.tscn")
const hitspark_scn : PackedScene = preload("res://juices/HitSpark/hitspark.tscn")
