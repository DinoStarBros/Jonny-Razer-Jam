extends Node
## Why the fuck am I over relying on Global signals for this shit.
## Who cares I had to work on a fucking research and had to travel aswell
## While the jam was ongoing, so I don't give a shit
## if this is spaghetti as hell


## Signal that spawns a box, specify box scene and position x
signal SpawnBox(
	box_scn:Box,
	pos_x:float
	)

## For boxes that just need random position
signal SpawnBoxRandomX(
	box_scn:Box
)

## Signal called for damaging the player
signal DamagePlayer(
	damage: float
)

## Signal called for damaging the enemy
signal DamageEnemy(
	damage: float
)

## When you press the cursor but hit nothing, it'll deal damage to the player
signal CursorMiss
