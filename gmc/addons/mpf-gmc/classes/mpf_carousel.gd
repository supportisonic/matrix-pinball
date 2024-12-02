class_name MPFCarousel
extends Node2D

## Shows and hides child nodes based on the selection of an MPF Carousel mode.
##
## Each child of this Node should have a name matching one of `the selectable_items`
## in the carousel's mode code.
##
## @tutorial: https://missionpinball.org/gmc/reference/mpf-carousel/

## The name of the MPF mode that uses Carousel as its custom mode code.
@export var carousel_name: String
@warning_ignore("shadowed_global_identifier")
var log: GMCLogger


func _enter_tree():
	# Create a log
	self.log = preload("res://addons/mpf-gmc/scripts/log.gd").new("Carousel<%s:%s>" % [self.name, carousel_name])

func _ready():
	for c in self.get_children():
		c.hide()
	if not carousel_name:
		self.log.info("Carousel node does not have a carousel_name property defined. Using '%s' as fallback.", self.name)
		carousel_name = self.name
	if not carousel_name in MPF.game.active_modes and OS.has_feature("debug"):
		self.log.warning("No active mode '%s', carousel will not function until that modes is active.", [carousel_name])
	MPF.server.item_highlighted.connect(self._on_item_highlighted)
	self.log.debug("Carousel active and waiting for 'carousel=%s' item_highlighted events.", carousel_name)

func _on_item_highlighted(payload: Dictionary) -> void:
	if payload.get("carousel") != self.carousel_name:
		self.log.debug("carousel_name does not match item_highlighted carousel name '%s', ignoring.", payload.get("carousel"))
		return
	self.log.debug("Carousel looking for child matching name '%s'", payload.item)
	var found_child := false
	for c in self.get_children():
		if c.name == payload.item:
			self.log.debug("Showing carousel child '%s'", c.name)
			found_child = true
			c.show()
		else:
			c.hide()
	if not found_child:
		self.log.warning("Carousel could not find a child named '%s' to highlight.", payload.item)
