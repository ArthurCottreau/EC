extends AudioPool
class_name SoundMusic

var tween: Tween

# Utiliser pour jouer la musique
func play(resource: AudioStreamSynchronized) -> void:
	if compare_track(resource):
		var player: AudioStreamPlayer = select_player(resource)
		player.call_deferred("play")


# Utiliser pour stopper la musique
func stop() -> void:
	on_player_finished(audio_players.front())

# Utiliser pour mettre la musique sur pause
func pause() -> void:
	audio_players.front().stream_paused = true

# Utiliser pour reprendre la musique après l'avoir mis sur pause
func resume() -> void:
	audio_players.front().stream_paused = false

# Utiliser pour modifier le volume d'un canal
func set_channel_volume(channel_id: int, volume: float) -> void:
	audio_players.front().stream.set_sync_stream_volume(channel_id, volume)

# Utiliser pour faire des fondus avec la musique
func fade_music(to_volume: float, duration: float) -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(audio_players.front(), "volume_db", to_volume, duration)

func compare_track(resource: AudioStreamSynchronized) -> bool:
	return true if resource != audio_players.front().stream else false
