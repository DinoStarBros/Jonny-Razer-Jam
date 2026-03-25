extends Node
class_name EntityComponentClass

## Epic scaling function, just multiply it with a value you want scaled
## with a value and strength
func scaling(
	## Enemy index here
	value : float,
	## The smaller = the faster the scaling
	## The bigger = the slower the scaling
	scaling_strength: float,
	## True = value that should increase (e.g. Box Speed)
	## False = valure that should decrease (e.g. Spawn Time Seconds)
	increase_or_decrease: bool = true
	) -> float:
	
	if increase_or_decrease:
		return (1 + (value / scaling_strength))
	else:
		return (1 - (value / scaling_strength))
