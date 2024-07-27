import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AdMonkeyDance extends StatefulWidget {
  const AdMonkeyDance({super.key});

  @override
  _AdMonkeyDanceState createState() => _AdMonkeyDanceState();
}

class _AdMonkeyDanceState extends State<AdMonkeyDance> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playSound();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSound() async {
    await _audioPlayer.play(AssetSource('monkey_dance_sound.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/monkey_dancing.json'),
        const Text(
          'Enjoy the monkey dance!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
