extends Node2D
## Component for entities that decides what, when, and where for the box spawning
class_name BoxDecider

## True = Chooses Boxes Randomly;
## False = Chooses Boxes on a Pattern
var random_or_pattern : bool 
var box_scenes : Array[PackedScene]
