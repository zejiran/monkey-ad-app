enum AchievementType {
  firstAd,
  tenAds,
  hundredAds,
  firstHour,
  tenHours,
  hundredHours,
  speedWatcher,
  dailyStreak,
  weeklyStreak,
  monthlyStreak,
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final AchievementType type;
  final int targetValue;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int progress;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.type,
    required this.targetValue,
    this.isUnlocked = false,
    this.unlockedAt,
    this.progress = 0,
  });

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    String? iconPath,
    AchievementType? type,
    int? targetValue,
    bool? isUnlocked,
    DateTime? unlockedAt,
    int? progress,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconPath: iconPath ?? this.iconPath,
      type: type ?? this.type,
      targetValue: targetValue ?? this.targetValue,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      progress: progress ?? this.progress,
    );
  }

  double get progressPercentage {
    if (isUnlocked) return 1.0;
    return (progress / targetValue).clamp(0.0, 1.0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconPath': iconPath,
      'type': type.name,
      'targetValue': targetValue,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.millisecondsSinceEpoch,
      'progress': progress,
    };
  }

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconPath: json['iconPath'] as String,
      type: AchievementType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AchievementType.firstAd,
      ),
      targetValue: json['targetValue'] as int,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['unlockedAt'] as int)
          : null,
      progress: json['progress'] as int? ?? 0,
    );
  }

  static List<Achievement> getDefaultAchievements() {
    return [
      const Achievement(
        id: 'first_ad',
        title: 'First Dance',
        description: 'Watch your first ad and see the monkey dance!',
        iconPath: '🐒',
        type: AchievementType.firstAd,
        targetValue: 1,
      ),
      const Achievement(
        id: 'ten_ads',
        title: 'Dance Party',
        description: 'Watch 10 ads and become a dance master!',
        iconPath: '💃',
        type: AchievementType.tenAds,
        targetValue: 10,
      ),
      const Achievement(
        id: 'hundred_ads',
        title: 'Dance Legend',
        description: 'Watch 100 ads! You are a true monkey dance legend!',
        iconPath: '🏆',
        type: AchievementType.hundredAds,
        targetValue: 100,
      ),
      const Achievement(
        id: 'first_hour',
        title: 'Hour of Fun',
        description: 'Accumulate 1 hour of monkey dancing time!',
        iconPath: '⏰',
        type: AchievementType.firstHour,
        targetValue: 3600,
      ),
      const Achievement(
        id: 'ten_hours',
        title: 'Dance Marathon',
        description: 'Accumulate 10 hours of monkey dancing time!',
        iconPath: '🎭',
        type: AchievementType.tenHours,
        targetValue: 36000,
      ),
      const Achievement(
        id: 'hundred_hours',
        title: 'Monkey Master',
        description: 'Accumulate 100 hours of monkey dancing time!',
        iconPath: '👑',
        type: AchievementType.hundredHours,
        targetValue: 360000,
      ),
      const Achievement(
        id: 'speed_watcher',
        title: 'Speed Watcher',
        description: 'Watch 5 ads in under 2 minutes!',
        iconPath: '⚡',
        type: AchievementType.speedWatcher,
        targetValue: 5,
      ),
      const Achievement(
        id: 'daily_streak',
        title: 'Daily Dancer',
        description: 'Use the app for 7 consecutive days!',
        iconPath: '📅',
        type: AchievementType.dailyStreak,
        targetValue: 7,
      ),
      const Achievement(
        id: 'weekly_streak',
        title: 'Weekly Warrior',
        description: 'Use the app for 4 consecutive weeks!',
        iconPath: '📊',
        type: AchievementType.weeklyStreak,
        targetValue: 28,
      ),
      const Achievement(
        id: 'monthly_streak',
        title: 'Monthly Master',
        description: 'Use the app for 30 consecutive days!',
        iconPath: '🌟',
        type: AchievementType.monthlyStreak,
        targetValue: 30,
      ),
    ];
  }
}
