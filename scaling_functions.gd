## Just a place to store all the scaling functions that'll be used 
## for stuff like stats
class_name Scalings
extends RefCounted

static func scale(
	level: float, # Index/level/value here
	scaling_strength: float, # How fast/strong the scaling is
	increase_or_decrease: bool,	# True = value that should increase (e.g. Box Speed)
								# False = valure that should decrease (e.g. Spawn Time Seconds)
	scaling_function: BaseEntityStats.scaling_function_types # What scaling function it uses
	) -> float:
	
	match scaling_function:
		BaseEntityStats.scaling_function_types.EXPONENTIAL:
			return exp_scaling(level, scaling_strength, increase_or_decrease)
		BaseEntityStats.scaling_function_types.LOGARITHMIC:
			return log_scaling(level, scaling_strength, increase_or_decrease)
		BaseEntityStats.scaling_function_types.QUADRATIC:
			return quad_scaling(level, scaling_strength, increase_or_decrease)
		BaseEntityStats.scaling_function_types.LINEAR:
			return linear_scaling(level, scaling_strength, increase_or_decrease)
		_:
			return linear_scaling(level, scaling_strength, increase_or_decrease)

## Linear scaling function, just multiply it with a value you want scaled
## with a value and strength
static func linear_scaling(
	level : float,
	scaling_strength: float,
	increase_or_decrease: bool = true
	) -> float:
	
	if increase_or_decrease:
		return (1 + (level * scaling_strength) / (10))
	else:
		return (1 - (level * scaling_strength) / (10))

## Exponential scaling function, just multiply it with a value you want scaled
## with a value and strength
static func exp_scaling(
	level : float,
	scaling_strength: float,
	increase_or_decrease: bool = true
	) -> float:
	
	if increase_or_decrease:
		return exp(level * scaling_strength)
	else:
		return exp(-level * scaling_strength * 0.1)

## Logarithmic scaling function, just multiply it with a value you want scaled
## with a value and strength
static func log_scaling(
	level : float,
	scaling_strength: float,
	increase_or_decrease: bool = true
	) -> float:
	
	if increase_or_decrease:
		return 1.0 + (scaling_strength * log(1.0 + level))
	else:
		return max(0.1, 1.0 - (scaling_strength * log(1.0 + level) * 0.1))

## Quadratic scaling function, just multiply it with a value you want scaled
## with a value and strength
static func quad_scaling(
	level : float,
	scaling_strength: float,
	increase_or_decrease: bool = true
	) -> float:
	
	if increase_or_decrease:
		return 1.0 + (scaling_strength * pow(level, 2))
	else:
		return max(0.1, 1.0 - (scaling_strength * pow(level, 2) * 0.01))
