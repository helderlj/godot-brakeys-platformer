extends Area2D


func _on_body_entered(body: CharacterBody2D) -> void:
	print('body_entered')
	if body is Player:
		var parent = self.get_parent()
		var tween = get_tree().create_tween()
		if parent:
			tween.tween_property(parent, "modulate:a", 0.1, 0.2)


func _on_body_exited(body: CharacterBody2D) -> void:
	print('body_exited')
	if body is Player:
		var parent = self.get_parent()
		var tween = get_tree().create_tween()
		if parent:
			tween.tween_property(parent, "modulate:a", 1, 0.2)
