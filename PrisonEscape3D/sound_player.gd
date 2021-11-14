extends Node

func play(sound): #will grab and then play the sound - so I only need to use 1 line of code when I add sound when things happen.
	var audio_stream = AudioStreamPlayer.new()
	self.add_child(audio_stream)
	audio_stream.stream = load(sound)
	audio_stream.play()

