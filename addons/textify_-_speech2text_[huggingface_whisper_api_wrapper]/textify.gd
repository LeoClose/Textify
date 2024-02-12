@tool
extends Node


var authToken = "" # View docs for more info


var effect
var recording
const save_path = "res://addons/textify_-_speech2text_[huggingface_whisper_api_wrapper]/tempWav.wav"

signal loading(time)
signal received(text)

func _ready():
	var idx = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(idx, 0)

func processRequest(data):
	$HTTPRequest.request("https://api-inference.huggingface.co/models/openai/whisper-large-v3", ["Authorization: Bearer %s" % [authToken]], HTTPClient.METHOD_POST, JSON.stringify({"inputs": Marshalls.raw_to_base64(data)}))

func _on_http_request_request_completed(_result, response_code, _headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	if response_code == 503:
		printerr(response)
		emit_signal("loading", response["estimated_time"])
		$Timer.start()
	else:
		if response != null:
			emit_signal("received", response["text"].strip_edges())
		else:
			printerr("Textify: There was an error with processing your request. Your audio file was probably too big.")

func start_recording():
	effect.set_recording_active(true)

func stop_recording():
	recording = await effect.get_recording()
	effect.set_recording_active(false)
	await recording.save_to_wav(save_path)
	var file := FileAccess.open(save_path, FileAccess.READ)
	var data := file.get_buffer(file.get_length())
	processRequest(data)

func parse_file(fileLocation):
	var file := FileAccess.open(fileLocation, FileAccess.READ)
	var data := file.get_buffer(file.get_length())
	processRequest(data)

func _on_timer_timeout():
	stop_recording()
