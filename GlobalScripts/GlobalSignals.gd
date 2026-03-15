extends Node

## Signal that spawns a box, specify box scene and position x
signal SpawnBox(
	box_scn:PackedScene,
	pos_x:float
	)

## For boxes that just need random position
signal SpawnBoxRandomX(
	box_scn:PackedScene
)
