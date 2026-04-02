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

## Signal for Healing the player by a percentage of their Max HP
signal HealPlayerPercent (
	heal_percent : float 
)

## Signal called for damaging the enemy
signal DamageEnemy(
	damage: float
)

## When the player just did a crit on an enemy
signal Crit

## When you wanna give a debuff to an enemy
signal DebuffEnemy(
	debuff: DebuffsComponent.Debuffs,
	duration: float
)

## When you press the cursor but hit nothing, it'll deal damage to the player
signal CursorMiss

## When the player defeats an enemy
signal FightWin

## When player is done picking an upgrade
signal UpgradeDone

## After walking and encountering next enemy
signal CombatStart

## When hitting a defend box
signal Defended

## When selecting stat upgrade after a fight
signal AddUpgrade(upgrade_scn: PackedScene)
