import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/achievement.dart';
import '../../view_models/ad_provider.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        elevation: 0,
      ),
      body: Consumer<AdProvider>(
        builder: (context, adProvider, child) {
          final achievements = Achievement.getDefaultAchievements();
          final danceDuration = adProvider.monkeyDanceDuration;

          // Update achievements based on current progress
          final updatedAchievements = achievements.map((achievement) {
            int currentProgress = 0;
            bool isUnlocked = false;

            switch (achievement.type) {
              case AchievementType.firstAd:
              case AchievementType.tenAds:
              case AchievementType.hundredAds:
                // For now, we'll use dance duration as a proxy for ads watched
                currentProgress =
                    (danceDuration / 5).floor(); // Assuming 5 seconds per ad
                break;
              case AchievementType.firstHour:
              case AchievementType.tenHours:
              case AchievementType.hundredHours:
                currentProgress = danceDuration;
                break;
              case AchievementType.speedWatcher:
              case AchievementType.dailyStreak:
              case AchievementType.weeklyStreak:
              case AchievementType.monthlyStreak:
                // These would need more complex tracking - for now set to 0
                currentProgress = 0;
                break;
            }

            isUnlocked = currentProgress >= achievement.targetValue;

            return achievement.copyWith(
              progress: currentProgress,
              isUnlocked: isUnlocked,
              unlockedAt: isUnlocked ? DateTime.now() : null,
            );
          }).toList();

          final unlockedCount =
              updatedAchievements.where((a) => a.isUnlocked).length;
          final totalCount = updatedAchievements.length;

          return Column(
            children: [
              // Progress header
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primaryContainer,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Progress',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$unlockedCount / $totalCount',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: unlockedCount / totalCount,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(unlockedCount / totalCount * 100).toStringAsFixed(1)}% Complete',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ],
                ),
              ),
              // Achievements list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: updatedAchievements.length,
                  itemBuilder: (context, index) {
                    final achievement = updatedAchievements[index];
                    return AchievementTile(achievement: achievement);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AchievementTile extends StatelessWidget {
  final Achievement achievement;

  const AchievementTile({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    final isUnlocked = achievement.isUnlocked;
    final progressPercentage = achievement.progressPercentage;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      elevation: isUnlocked ? 4 : 1,
      color: isUnlocked
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Icon/Emoji
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isUnlocked
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: Text(
                  achievement.iconPath,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isUnlocked
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : null,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    achievement.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isUnlocked
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 8),
                  // Progress bar
                  if (!isUnlocked) ...[
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progressPercentage,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${achievement.progress}/${achievement.targetValue}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Unlocked!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
