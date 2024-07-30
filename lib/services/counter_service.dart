import 'package:shared_preferences/shared_preferences.dart';

class CounterService {
  static const String _counterKey = 'monkeyDanceCounter';

  Future<void> incrementCounter(int durationInSeconds) async {
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(_counterKey) ?? 0;
    final incrementedCount = currentCount + durationInSeconds;
    await prefs.setInt(_counterKey, incrementedCount);
  }

  Future<int> getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_counterKey) ?? 0;
  }
}
