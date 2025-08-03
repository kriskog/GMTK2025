class_name DamageNumber
extends Label


func _init(value: int):
	display_number(value)


func display_number(value: int):
	text = str(value)
	z_index = 5
	label_settings = LabelSettings.new()

	var colour = "#FFF"
	if value == 0:
		colour = "#FFF8"

	label_settings.font_color = colour
	label_settings.font_size = 40
	label_settings.outline_color = "#000"
	label_settings.outline_size = 1

	pivot_offset = size / 2

	await tree_entered

	var tween = self.create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position:y", position.y - 24, 0.20).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", position.y, 0.25).set_ease(Tween.EASE_IN).set_delay(
		0.25
	)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.25).set_ease(Tween.EASE_IN).set_delay(0.5)
	tween.tween_property(self, "position", size / 2, 0.25).set_ease(Tween.EASE_IN).set_delay(0.5)

	await tween.finished
	self.queue_free()
