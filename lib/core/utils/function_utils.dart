import 'package:audioplayers/audioplayers.dart';

Map<String, dynamic> removeNulls(Map<String, dynamic> map) {
  Map<String, dynamic> result = {};
  map.forEach((key, value) {
    if (value != null) {
      result[key] = value;
    }
  });
  return result;
}

String formatPhoneNumber(String phoneNumber) {
  return "+${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 5)} ${phoneNumber.substring(5, 7)} ${phoneNumber.substring(7, 9)} ${phoneNumber.substring(9, 11)}";
}


class PlaySong {
  static Future<void> error() async {
    final player = AudioPlayer();
    await player.play(AssetSource('audios/error.wav'));
  }

  static Future<void> success() async {
    final AudioPlayer player = AudioPlayer();
    await player.play(AssetSource('audios/success.wav'));
    // await player.resume();
  }
}
