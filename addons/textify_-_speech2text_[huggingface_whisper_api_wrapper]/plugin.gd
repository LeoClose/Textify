@tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("Textify", "res://addons/textify_-_speech2text_[huggingface_whisper_api_wrapper]/textify.tscn")

func _exit_tree():
	remove_autoload_singleton("Textify")
