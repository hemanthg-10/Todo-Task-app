import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskstreak/core/notifications/reminder_service.dart';
import 'package:taskstreak/data/database/app_database.dart';
import 'package:taskstreak/data/seed/database_seeder.dart';
import 'package:taskstreak/data/repositories/local_task_repository.dart';
import 'package:taskstreak/data/repositories/local_goal_repository.dart';
import 'package:taskstreak/data/repositories/local_streak_repository.dart';
import 'package:taskstreak/data/repositories/local_quote_repository.dart';
import 'package:taskstreak/data/repositories/local_leaderboard_repository.dart';
import 'package:taskstreak/features/goals/domain/goal_repository.dart';
import 'package:taskstreak/features/streak/domain/streak_repository.dart';
import 'package:taskstreak/features/quotes/domain/quote_repository.dart';
import 'package:taskstreak/features/leaderboard/domain/leaderboard_repository.dart';
import 'package:taskstreak/features/tasks/domain/task_repository.dart';

final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError(),
);
final taskRepositoryProvider = Provider<TaskRepository>(
  (ref) => LocalTaskRepository(ref.watch(databaseProvider)),
);
final tasksProvider = StreamProvider<List<Task>>(
  (ref) => ref.watch(taskRepositoryProvider).watchAll(),
);
final goalRepositoryProvider = Provider<GoalRepository>(
  (ref) => LocalGoalRepository(ref.watch(databaseProvider)),
);
final goalsProvider = StreamProvider(
  (ref) => ref.watch(goalRepositoryProvider).watchGoals(),
);
final streakRepositoryProvider = Provider<StreakRepository>(
  (ref) => LocalStreakRepository(ref.watch(databaseProvider)),
);
final streaksProvider = StreamProvider(
  (ref) => ref.watch(streakRepositoryProvider).watchAll(),
);
final quoteRepositoryProvider = Provider<QuoteRepository>(
  (ref) => LocalQuoteRepository(ref.watch(databaseProvider)),
);
final int _quoteRotationSeed = DateTime.now().microsecondsSinceEpoch;
final quotesProvider = StreamProvider<List<Quote>>(
  (ref) => ref
      .watch(quoteRepositoryProvider)
      .watchAll()
      .map((quotes) => [...quotes]..shuffle(Random(_quoteRotationSeed))),
);
final favouriteQuotesProvider = StreamProvider(
  (ref) => ref.watch(quoteRepositoryProvider).watchFavourites(),
);
final leaderboardRepositoryProvider = Provider<LeaderboardRepository>(
  (ref) => LocalLeaderboardRepository(ref.watch(databaseProvider)),
);
final weeklyLeaderboardProvider = StreamProvider(
  (ref) => ref
      .watch(leaderboardRepositoryProvider)
      .watchRanked(LeaderboardPeriod.weekly),
);
final allTimeLeaderboardProvider = StreamProvider(
  (ref) => ref
      .watch(leaderboardRepositoryProvider)
      .watchRanked(LeaderboardPeriod.allTime),
);
final leaderboardSeedProvider = FutureProvider<void>((ref) async {
  await (ref.read(leaderboardRepositoryProvider) as LocalLeaderboardRepository)
      .refreshDemoUsers();
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppDatabase database = AppDatabase();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(database)],
      child: TaskStreakApp(
        onboardingComplete: preferences.getBool('onboardingComplete') ?? false,
        profileName: preferences.getString('profileName') ?? '',
        lastSection:
            const [
              '/',
              '/streak',
              '/goals',
              '/profile',
            ].contains(preferences.getString('lastSection'))
            ? preferences.getString('lastSection')!
            : '/',
      ),
    ),
  );

  // The first screen should render before optional setup touches plugins or
  // opens the database. These tasks continue in the background after startup.
  WidgetsBinding.instance.addPostFrameCallback((_) {
    unawaited(_initializeBackgroundServices(database));
  });
}

Future<void> _initializeBackgroundServices(AppDatabase database) async {
  try {
    if (!kIsWeb) {
      final reminders = ReminderService();
      await reminders.initialize();
      final preferences = await SharedPreferences.getInstance();
      if (!(preferences.getBool('reminderPermissionPrompted') ?? false)) {
        final granted = await reminders.requestPermissions();
        await preferences.setBool('reminderPermissionPrompted', true);
        await preferences.setBool('remindersAllowed', granted);
      }
    }
  } catch (error, stackTrace) {
    debugPrint('Reminder initialization failed: $error\n$stackTrace');
  }

  try {
    await DatabaseSeeder(database).seedInitialData();
  } catch (error, stackTrace) {
    debugPrint('Database seed failed: $error\n$stackTrace');
  }
}

class MyApp extends TaskStreakApp {
  MyApp({super.key}) : super(onboardingComplete: true, profileName: 'Friend');
}

class TaskStreakApp extends StatelessWidget {
  TaskStreakApp({
    super.key,
    required this.onboardingComplete,
    required this.profileName,
    this.lastSection = '/',
  });
  final bool onboardingComplete;
  final String profileName;
  final String lastSection;

  late final GoRouter _router = GoRouter(
    initialLocation: '/startup',
    routes: [
      GoRoute(
        path: '/startup',
        builder: (context, state) =>
            StartupScreen(next: onboardingComplete ? lastSection : '/welcome'),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(name: profileName),
      ),
      GoRoute(
        path: '/task/new',
        builder: (context, state) => const TaskFormScreen(),
      ),
      GoRoute(
        path: '/task/:id',
        builder: (context, state) => TaskFormScreen(
          taskId: int.tryParse(state.pathParameters['id'] ?? ''),
        ),
      ),
      GoRoute(path: '/goals', builder: (context, state) => const GoalsScreen()),
      GoRoute(
        path: '/streak',
        builder: (context, state) => const StreakScreen(),
      ),
      GoRoute(
        path: '/task-complete',
        builder: (context, state) => TaskCompleteScreen(),
      ),
      GoRoute(
        path: '/leaderboard',
        builder: (context, state) => const LeaderboardScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'TaskStreak',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF287B70)),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF7F9F8),
      cardTheme: const CardThemeData(elevation: 1, margin: EdgeInsets.zero),
    ),
    routerConfig: _router,
  );
}

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key, required this.next});
  final String next;
  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..forward();
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) context.go(widget.next);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ScaleTransition(
        scale: CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/taskstreak_logo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 18),
            Text(
              'TaskStreak',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _profileAction(BuildContext context) => IconButton(
  tooltip: 'Profile',
  onPressed: () => context.push('/profile'),
  icon: const Icon(Icons.account_circle_outlined),
);
Widget _brandTitle(String text) => Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Image.asset('assets/images/taskstreak_logo.png', width: 30, height: 30),
    const SizedBox(width: 8),
    Flexible(child: Text(text, overflow: TextOverflow.ellipsis)),
  ],
);

class _MainTabs extends StatelessWidget {
  const _MainTabs({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) => NavigationBar(
    selectedIndex: index,
    onDestinationSelected: (i) async {
      const paths = ['/', '/streak', '/goals', '/profile'];
      await (await SharedPreferences.getInstance()).setString(
        'lastSection',
        paths[i],
      );
      if (context.mounted) context.go(paths[i]);
    },
    destinations: const [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(Icons.local_fire_department_outlined),
        selectedIcon: Icon(Icons.local_fire_department),
        label: 'Streak',
      ),
      NavigationDestination(
        icon: Icon(Icons.flag_outlined),
        selectedIcon: Icon(Icons.flag),
        label: 'Goals',
      ),
      NavigationDestination(
        icon: Icon(Icons.account_circle_outlined),
        selectedIcon: Icon(Icons.account_circle),
        label: 'Profile',
      ),
    ],
  );
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) => _IntroScaffold(
    title: 'Make today count',
    body: 'Plan your tasks, get helpful reminders, and build steady habits.',
    action: 'Get started',
    onPressed: () => context.go('/profile'),
  );
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  String? _photoPath;
  Uint8List? _photoBytes;
  String _toneId = 'classic';
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final p = await SharedPreferences.getInstance();
    final path = p.getString('profilePhoto');
    Uint8List? bytes;
    if (path != null) {
      try {
        bytes = await XFile(path).readAsBytes();
      } catch (_) {}
    }
    if (!mounted) return;
    _name.text = p.getString('profileName') ?? '';
    _bio.text = p.getString('profileBio') ?? '';
    setState(() {
      _photoPath = path;
      _photoBytes = bytes;
      _toneId = p.getString('defaultAlertTone') ?? 'classic';
    });
  }

  Future<void> _pickPhoto() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 900,
    );
    if (image == null) return;
    final bytes = await image.readAsBytes();
    final p = await SharedPreferences.getInstance();
    await p.setString('profilePhoto', image.path);
    if (mounted)
      setState(() {
        _photoPath = image.path;
        _photoBytes = bytes;
      });
  }

  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final String name = _name.text.trim().isEmpty
        ? 'Friend'
        : _name.text.trim();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileName', name);
    await prefs.setString('profileBio', _bio.text.trim());
    await prefs.setString('defaultAlertTone', _toneId);
    await prefs.setBool('onboardingComplete', true);
    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Your profile'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.canPop() ? context.pop() : context.go('/'),
      ),
    ),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(
          child: InkWell(
            onTap: _pickPhoto,
            child: CircleAvatar(
              radius: 48,
              backgroundImage: _photoBytes == null
                  ? null
                  : MemoryImage(_photoBytes!),
              child: _photoBytes == null
                  ? const Icon(Icons.add_a_photo, size: 34)
                  : null,
            ),
          ),
        ),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text('Tap photo to change'),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Your name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _bio,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Bio',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _toneId,
                decoration: const InputDecoration(
                  labelText: 'Default alert tone',
                  border: OutlineInputBorder(),
                ),
                items: alertTones
                    .map(
                      (tone) => DropdownMenuItem(
                        value: tone.id,
                        child: Text(tone.label),
                      ),
                    )
                    .toList(),
                onChanged: (value) =>
                    setState(() => _toneId = value ?? 'classic'),
              ),
            ),
            _AlertTonePreviewButton(toneId: _toneId),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'This tone is selected by default when you create a task. You can change it for each task.',
        ),
        const SizedBox(height: 20),
        FilledButton(onPressed: _save, child: const Text('Save profile')),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Reminder permissions'),
          subtitle: const Text(
            'Review access if task alerts are not arriving.',
          ),
          trailing: TextButton(
            onPressed: () async {
              final service = ReminderService();
              await service.initialize();
              final granted = await service.requestPermissions();
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('remindersAllowed', granted);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      granted
                          ? 'Reminder access is ready.'
                          : 'Allow notifications and alarms in system settings.',
                    ),
                  ),
                );
              }
            },
            child: const Text('Review'),
          ),
        ),
      ],
    ),
    bottomNavigationBar: const _MainTabs(index: 3),
  );
}

class _IntroScaffold extends StatelessWidget {
  const _IntroScaffold({
    required this.title,
    required this.body,
    required this.action,
    required this.onPressed,
  });
  final String title, body, action;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 76,
                color: Color(0xFF287B70),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(body, textAlign: TextAlign.center),
              const SizedBox(height: 28),
              FilledButton(onPressed: onPressed, child: Text(action)),
            ],
          ),
        ),
      ),
    ),
  );
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.name});
  final String name;
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _taskTab = 0;
  int _quotePage = 0;
  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    final AsyncValue<List<Task>> tasks = ref.watch(tasksProvider);
    final DateTime today = DateTime.now();
    final allTasks = tasks.value ?? <Task>[];
    final todayTasks = allTasks
        .where(
          (t) =>
              t.dueAt.year == today.year &&
              t.dueAt.month == today.month &&
              t.dueAt.day == today.day,
        )
        .toList();
    final List<Task> todays = allTasks
        .where(
          (t) =>
              !t.isDone &&
              t.dueAt.year == today.year &&
              t.dueAt.month == today.month &&
              t.dueAt.day == today.day,
        )
        .toList();
    final completed = allTasks.where((t) => t.isDone).toList();
    final quoteState = ref.watch(quotesProvider);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset('assets/images/taskstreak_logo.png'),
        ),
        title: Text('Hello, ${widget.name}'),
        actions: [
          _profileAction(context),
          IconButton(
            onPressed: () => context.push('/leaderboard'),
            icon: const Icon(Icons.leaderboard_outlined),
            tooltip: 'Leaderboard',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s focus',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${todayTasks.where((t) => t.isDone).length} of ${todayTasks.length} tasks completed',
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: todayTasks.isEmpty
                        ? 0
                        : todayTasks.where((t) => t.isDone).length /
                              todayTasks.length,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SizedBox(height: 22),
          Text('Quotes', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          quoteState.when(
            loading: () => const SizedBox(
              height: 270,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const SizedBox(
              height: 270,
              child: Center(child: Text('Quotes are unavailable.')),
            ),
            data: (quotes) {
              final slides = quotes.take(5).toList();
              if (slides.isEmpty)
                return const SizedBox(
                  height: 270,
                  child: Center(child: Text('No quotes available yet.')),
                );
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 660),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Container(
                          height: 270,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: PageView.builder(
                            itemCount: slides.length,
                            onPageChanged: (i) =>
                                setState(() => _quotePage = i),
                            itemBuilder: (context, i) {
                              final q = slides[i];
                              return Padding(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.format_quote, size: 28),
                                    const SizedBox(height: 6),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '“${q.quoteText}”',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 18,
                                          backgroundImage:
                                              q.authorImageAsset.isEmpty
                                              ? null
                                              : AssetImage(q.authorImageAsset),
                                          child: q.authorImageAsset.isEmpty
                                              ? const Icon(
                                                  Icons.person,
                                                  size: 18,
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            q.author,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => ref
                                              .read(quoteRepositoryProvider)
                                              .setFavourite(q.id, true),
                                          icon: const Icon(
                                            Icons.favorite_border,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            slides.length,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: i == _quotePage ? 18 : 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: i == _quotePage
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.black26,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 6),
          TextButton.icon(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Quote sources and license'),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This app includes 500 selected quotes from Wikiquote via MindArchive. Quote text and author attributions are retained.',
                    ),
                    SizedBox(height: 12),
                    SelectableText(
                      'https://github.com/GGNadirashvili/MindArchive',
                    ),
                    SizedBox(height: 8),
                    Text('Shared under CC BY-SA 4.0.'),
                    SelectableText(
                      'https://creativecommons.org/licenses/by-sa/4.0/',
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.info_outline, size: 16),
            label: const Text('Quote source: Wikiquote · CC BY-SA 4.0'),
          ),
          const SizedBox(height: 24),
          Text('Tasks', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('Today')),
              ButtonSegment(value: 1, label: Text('Completed')),
            ],
            selected: {_taskTab},
            onSelectionChanged: (v) => setState(() => _taskTab = v.first),
          ),
          const SizedBox(height: 12),
          if (tasks.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (tasks.hasError)
            const Text('Could not load tasks. Please try again.')
          else if ((_taskTab == 0 ? todays : completed).isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                _taskTab == 0
                    ? 'Nothing planned for today. Add a task to get started.'
                    : 'Completed tasks will appear here.',
                textAlign: TextAlign.center,
              ),
            )
          else
            ...(_taskTab == 0 ? todays : completed).map(
              (task) => _HomeTaskCard(task: task, isCompleted: _taskTab == 1),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/task/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add task'),
      ),
      bottomNavigationBar: const _MainTabs(index: 0),
    );
  }
}

class _TaskTile extends ConsumerWidget {
  const _TaskTile({required this.task});
  final Task task;
  Future<void> _setDone(BuildContext context, WidgetRef ref, bool done) async {
    final db = ref.read(databaseProvider);
    await ref.read(taskRepositoryProvider).setCompleted(task.id, done);
    if (!kIsWeb && done) {
      await ReminderService().cancelTaskReminder(task.id);
    } else if (!kIsWeb) {
      final reminders = ReminderService();
      final prefs = await SharedPreferences.getInstance();
      final toneId = prefs.getString('taskAlertTone_${task.id}') ?? 'classic';
      final tone = alertTones.firstWhere(
        (item) => item.id == toneId,
        orElse: () => alertTones.first,
      );
      await reminders.scheduleTaskReminder(
        taskId: task.id,
        title: task.title,
        dueAt: task.dueAt,
        leadMinutes: task.reminderLeadMinutes,
        withAlarm: task.alarmEnabled,
        toneAssetPath: tone.assetPath,
      );
    }
    final now = DateTime.now();
    final allTasks = await db.select(db.tasks).get();
    final count = allTasks
        .where(
          (t) =>
              t.isDone &&
              t.completedAt != null &&
              t.completedAt!.year == now.year &&
              t.completedAt!.month == now.month &&
              t.completedAt!.day == now.day,
        )
        .toList();
    final goals = await db.select(db.goals).get();
    final daily =
        goals.where((g) => g.type == 'daily').firstOrNull?.targetCount ?? 3;
    await ref
        .read(streakRepositoryProvider)
        .recordDay(
          localDate: now,
          tasksCompleted: count.length,
          dailyGoal: daily,
        );
    if (done && context.mounted) await context.push('/task-complete');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => Card(
    margin: const EdgeInsets.only(bottom: 8),
    child: ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: (v) => _setDone(context, ref, v ?? false),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(
        '${task.category} • ${TimeOfDay.fromDateTime(task.dueAt).format(context)}',
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit_outlined),
        tooltip: 'Edit task',
        onPressed: () => context.push('/task/${task.id}'),
      ),
    ),
  );
}

class _HomeTaskCard extends ConsumerWidget {
  const _HomeTaskCard({required this.task, required this.isCompleted});
  final Task task;
  final bool isCompleted;
  String _format(BuildContext context, DateTime value) =>
      '${MaterialLocalizations.of(context).formatMediumDate(value)} • ${TimeOfDay.fromDateTime(value).format(context)}';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertAt = task.dueAt.subtract(
      Duration(minutes: task.reminderLeadMinutes),
    );
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: isCompleted
            ? () => showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(task.title),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (task.description.isNotEmpty) Text(task.description),
                      const SizedBox(height: 12),
                      Text('Category: ${task.category}'),
                      Text('Priority: ${task.priority}'),
                      Text('Deadline: ${_format(context, task.dueAt)}'),
                      Text('Alert: ${_format(context, alertAt)}'),
                      if (task.completedAt != null)
                        Text(
                          'Completed: ${_format(context, task.completedAt!)}',
                        ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              )
            : null,
        leading: isCompleted
            ? const Icon(Icons.check_circle, color: Colors.green)
            : Checkbox(
                value: task.isDone,
                onChanged: (v) =>
                    _TaskTile(task: task)._setDone(context, ref, v ?? false),
              ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deadline: ${_format(context, task.dueAt)}'),
              Text('Alert: ${_format(context, alertAt)}'),
            ],
          ),
        ),
        trailing: isCompleted ? const Icon(Icons.chevron_right) : null,
        isThreeLine: true,
      ),
    );
  }
}

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(
      title: _brandTitle('Goals'),
      actions: [_profileAction(context)],
    ),
    body: ref
        .watch(goalsProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Center(child: Text('Could not load goals.')),
          data: (goals) {
            final daily =
                goals
                    .where((g) => g.type == 'daily')
                    .firstOrNull
                    ?.targetCount ??
                3;
            final weekly =
                goals
                    .where((g) => g.type == 'weekly')
                    .firstOrNull
                    ?.targetCount ??
                15;
            final today = DateTime.now();
            final tasks = ref.watch(tasksProvider).value ?? <Task>[];
            final doneToday = tasks
                .where(
                  (t) =>
                      t.isDone &&
                      t.completedAt != null &&
                      t.completedAt!.year == today.year &&
                      t.completedAt!.month == today.month &&
                      t.completedAt!.day == today.day,
                )
                .length;
            final weekStart = DateTime(
              today.year,
              today.month,
              today.day,
            ).subtract(Duration(days: today.weekday - 1));
            final doneThisWeek = tasks
                .where(
                  (t) =>
                      t.isDone &&
                      t.completedAt != null &&
                      !t.completedAt!.isBefore(weekStart),
                )
                .length;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  'Today: $doneToday of $daily tasks',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (doneToday / daily).clamp(0.0, 1.0),
                ),
                ListTile(
                  title: const Text('Daily target'),
                  subtitle: Text('$daily tasks'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _edit(context, ref, 'daily', daily, 20),
                  ),
                ),
                ListTile(
                  title: const Text('Weekly target'),
                  subtitle: Text('$weekly tasks'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _edit(context, ref, 'weekly', weekly, 140),
                  ),
                ),
                Text(
                  'This week: $doneThisWeek of $weekly tasks',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (doneThisWeek / weekly).clamp(0.0, 1.0),
                ),
              ],
            );
          },
        ),
    bottomNavigationBar: const _MainTabs(index: 2),
  );
  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    String type,
    int current,
    int max,
  ) async {
    final controller = TextEditingController(text: '$current');
    final value = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${type == 'daily' ? 'Daily' : 'Weekly'} target'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Tasks (1–$max)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, int.tryParse(controller.text)),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (value != null && value >= 1 && value <= max)
      await ref.read(goalRepositoryProvider).setTarget(type, value);
  }
}

class StreakScreen extends ConsumerWidget {
  const StreakScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(
      title: _brandTitle('Streak history'),
      actions: [_profileAction(context)],
    ),
    body: ref
        .watch(streaksProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) =>
              const Center(child: Text('Could not load streak history.')),
          data: (days) {
            final byDate = {for (final d in days) d.date: d};
            int current = 0;
            var date = DateTime.now();
            var key = _dateKey(date);
            if (!(byDate[key]?.goalMet ?? false))
              date = date.subtract(const Duration(days: 1));
            for (var i = 0; i < 366; i++) {
              key = _dateKey(date);
              if (byDate[key]?.goalMet != true) break;
              current++;
              date = date.subtract(const Duration(days: 1));
            }
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Card(
                  child: ListTile(
                    leading: TweenAnimationBuilder<double>(
                      tween: Tween(begin: .75, end: 1),
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.elasticOut,
                      builder: (context, scale, child) =>
                          Transform.scale(scale: scale, child: child),
                      child: const Icon(
                        Icons.local_fire_department,
                        color: Colors.deepOrange,
                        size: 38,
                      ),
                    ),
                    title: Text('$current day streak'),
                    subtitle: const Text('Days you reached your daily goal'),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Recent activity',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ...days
                    .take(30)
                    .map(
                      (d) => ListTile(
                        leading: Icon(
                          d.goalMet
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: d.goalMet ? Colors.green : null,
                        ),
                        title: Text(d.date),
                        subtitle: Text('${d.tasksCompleted} tasks completed'),
                      ),
                    ),
              ],
            );
          },
        ),
    bottomNavigationBar: const _MainTabs(index: 1),
  );
  String _dateKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

class TaskCompleteScreen extends ConsumerWidget {
  const TaskCompleteScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(
      title: const Text('Task complete'),
      automaticallyImplyLeading: false,
    ),
    body: ref
        .watch(quotesProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => _content(context, ref, null),
          data: (quotes) =>
              _content(context, ref, quotes.isEmpty ? null : quotes.first),
        ),
  );
  Widget _content(BuildContext context, WidgetRef ref, Quote? quote) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: .65, end: 1),
            duration: const Duration(milliseconds: 650),
            curve: Curves.elasticOut,
            builder: (context, scale, child) =>
                Transform.scale(scale: scale, child: child),
            child: const Icon(
              Icons.celebration_outlined,
              size: 76,
              color: Color(0xFF287B70),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Streak started!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'Day ${DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays + 1} of your year',
          ),
          const SizedBox(height: 20),
          if (quote != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Text('“${quote.quoteText}”', textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: quote.authorImageAsset.isEmpty
                              ? null
                              : AssetImage(quote.authorImageAsset),
                          child: quote.authorImageAsset.isEmpty
                              ? const Icon(Icons.person, size: 16)
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Text(quote.author),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: quote == null
                    ? () => context.go('/')
                    : () async {
                        await ref
                            .read(quoteRepositoryProvider)
                            .setFavourite(quote.id, true);
                        if (context.mounted) context.go('/');
                      },
                icon: const Icon(Icons.favorite),
                label: const Text('Like quote'),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('Skip to Home'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});
  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  bool weekly = true;
  @override
  Widget build(BuildContext context) {
    final seeded = ref.watch(leaderboardSeedProvider);
    final data = ref.watch(
      weekly ? weeklyLeaderboardProvider : allTimeLeaderboardProvider,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        actions: [_profileAction(context)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('This week')),
                ButtonSegment(value: false, label: Text('All time')),
              ],
              selected: {weekly},
              onSelectionChanged: (v) => setState(() => weekly = v.first),
            ),
          ),
          Expanded(
            child: seeded.isLoading
                ? const Center(child: CircularProgressIndicator())
                : data.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const Center(
                      child: Text('Could not load leaderboard.'),
                    ),
                    data: (users) => users.isEmpty
                        ? const Center(
                            child: Text('No leaderboard entries found.'),
                          )
                        : ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, i) {
                              final u = users[i];
                              return ListTile(
                                leading: CircleAvatar(child: Text('${i + 1}')),
                                title: Text(u.name),
                                subtitle: Text(
                                  '${u.currentStreak} day streak • ${u.totalCompleted} completed',
                                ),
                                trailing: Text(
                                  weekly
                                      ? '${u.weeklyCompleted} this week'
                                      : '${u.totalPoints} pts',
                                ),
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const _MainTabs(index: 0),
    );
  }
}

class _AlertTonePreviewButton extends StatefulWidget {
  const _AlertTonePreviewButton({required this.toneId});
  final String toneId;

  @override
  State<_AlertTonePreviewButton> createState() =>
      _AlertTonePreviewButtonState();
}

class _AlertTonePreviewButtonState extends State<_AlertTonePreviewButton> {
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<void>? _completionSubscription;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _completionSubscription = _player.onPlayerComplete.listen((_) {
      if (mounted) setState(() => _isPlaying = false);
    });
  }

  @override
  void didUpdateWidget(covariant _AlertTonePreviewButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.toneId != widget.toneId) {
      unawaited(_player.stop());
      _isPlaying = false;
    }
  }

  Future<void> _togglePreview() async {
    if (_isPlaying) {
      await _player.stop();
      if (mounted) setState(() => _isPlaying = false);
      return;
    }
    final tone = alertTones.firstWhere(
      (item) => item.id == widget.toneId,
      orElse: () => alertTones.first,
    );
    try {
      await _player.stop();
      await _player.play(
        AssetSource(tone.assetPath.replaceFirst('assets/', '')),
      );
      if (mounted) setState(() => _isPlaying = true);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not play tone preview: $error')),
        );
      }
    }
  }

  @override
  void dispose() {
    unawaited(_completionSubscription?.cancel());
    unawaited(_player.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: _isPlaying ? 'Stop tone preview' : 'Preview alert tone',
    onPressed: _togglePreview,
    icon: Icon(
      _isPlaying ? Icons.stop_circle_outlined : Icons.play_circle_outline,
    ),
  );
}

class TaskFormScreen extends ConsumerStatefulWidget {
  const TaskFormScreen({super.key, this.taskId});
  final int? taskId;
  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  DateTime _due = DateTime.now().add(const Duration(hours: 1));
  String _category = 'General';
  String _priority = 'medium';
  String _toneId = 'classic';
  int _lead = 15;
  bool _alarm = true;
  @override
  void initState() {
    super.initState();
    _loadTaskAndTone();
  }

  Future<void> _loadTaskAndTone() async {
    final prefs = await SharedPreferences.getInstance();
    final taskId = widget.taskId;
    final existing = taskId == null
        ? null
        : await (ref
                  .read(databaseProvider)
                  .select(ref.read(databaseProvider).tasks)
                ..where((task) => task.id.equals(taskId)))
              .getSingleOrNull();
    if (!mounted) return;
    setState(() {
      _toneId =
          prefs.getString(
            taskId == null ? 'defaultAlertTone' : 'taskAlertTone_$taskId',
          ) ??
          'classic';
      if (existing != null) {
        _title.text = existing.title;
        _description.text = existing.description;
        _due = existing.dueAt;
        _category = existing.category;
        _priority = existing.priority;
        _lead = existing.reminderLeadMinutes;
        _alarm = existing.alarmEnabled;
      }
    });
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final repository = ref.read(taskRepositoryProvider);
    final id = widget.taskId;
    final int savedId;
    if (id == null) {
      final companion = TasksCompanion.insert(
        title: _title.text.trim(),
        description: Value(_description.text.trim()),
        category: Value(_category),
        priority: Value(_priority),
        dueAt: _due,
        reminderLeadMinutes: Value(_lead),
        alarmEnabled: Value(_alarm),
      );
      savedId = await repository.addTask(companion);
    } else {
      await repository.updateTask(
        TasksCompanion(
          id: Value(id),
          title: Value(_title.text.trim()),
          description: Value(_description.text.trim()),
          category: Value(_category),
          priority: Value(_priority),
          dueAt: Value(_due),
          reminderLeadMinutes: Value(_lead),
          alarmEnabled: Value(_alarm),
        ),
      );
      savedId = id;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('taskAlertTone_$savedId', _toneId);
    if (!kIsWeb) {
      final reminders = ReminderService();
      await reminders.initialize();
      await reminders.requestPermissions();
      final tone = alertTones.firstWhere(
        (item) => item.id == _toneId,
        orElse: () => alertTones.first,
      );
      await reminders.scheduleTaskReminder(
        taskId: savedId,
        title: _title.text.trim(),
        dueAt: _due,
        leadMinutes: _lead,
        withAlarm: _alarm,
        toneAssetPath: tone.assetPath,
      );
    }
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        tooltip: 'Back',
        onPressed: () => context.canPop() ? context.pop() : context.go('/'),
      ),
      title: Text(widget.taskId == null ? 'Add task' : 'Edit task'),
    ),
    body: Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Task details', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          TextFormField(
            controller: _title,
            decoration: const InputDecoration(
              labelText: 'Task title',
              prefixIcon: Icon(Icons.edit_note),
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Enter a title' : null,
          ),
          TextFormField(
            controller: _description,
            decoration: const InputDecoration(
              labelText: 'Description',
              prefixIcon: Icon(Icons.notes),
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _category,
            decoration: const InputDecoration(labelText: 'Category'),
            items: [
              'General',
              'Work',
              'Personal',
              'Health',
              'Study',
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => _category = v ?? 'General'),
          ),
          const SizedBox(height: 12),
          Text(
            'Schedule & reminders',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _priority,
            decoration: const InputDecoration(labelText: 'Priority'),
            items: ['low', 'medium', 'high']
                .map(
                  (e) =>
                      DropdownMenuItem(value: e, child: Text(e.toUpperCase())),
                )
                .toList(),
            onChanged: (v) => setState(() => _priority = v ?? 'medium'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Due date and time'),
            subtitle: Text(
              '${MaterialLocalizations.of(context).formatMediumDate(_due)} • ${TimeOfDay.fromDateTime(_due).format(context)}',
            ),
            trailing: const Icon(Icons.calendar_month),
            onTap: () async {
              final d = await showDatePicker(
                context: context,
                initialDate: _due,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (d == null || !context.mounted) return;
              final t = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(_due),
              );
              if (t != null)
                setState(
                  () =>
                      _due = DateTime(d.year, d.month, d.day, t.hour, t.minute),
                );
            },
          ),
          DropdownButtonFormField<int>(
            initialValue: _lead,
            decoration: const InputDecoration(
              labelText: 'Reminder before due time',
            ),
            items: [5, 10, 15, 30, 60]
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text('$e minutes')),
                )
                .toList(),
            onChanged: (v) => setState(() => _lead = v ?? 15),
          ),
          Builder(
            builder: (context) {
              final alertAt = _due.subtract(Duration(minutes: _lead));
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.notifications_active_outlined,
                  color: alertAt.isBefore(DateTime.now())
                      ? Theme.of(context).colorScheme.error
                      : null,
                ),
                title: Text(
                  'Alert time: ${MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay.fromDateTime(alertAt))}',
                ),
                subtitle: alertAt.isBefore(DateTime.now())
                    ? const Text(
                        'This alert time has already passed. Choose a later deadline or shorter reminder lead.',
                      )
                    : null,
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _toneId,
                  decoration: const InputDecoration(labelText: 'Alert tone'),
                  items: alertTones
                      .map(
                        (tone) => DropdownMenuItem(
                          value: tone.id,
                          child: Text(tone.label),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _toneId = value ?? 'classic'),
                ),
              ),
              _AlertTonePreviewButton(toneId: _toneId),
            ],
          ),
          SwitchListTile(
            title: const Text('Alarm sound (Android)'),
            value: _alarm,
            onChanged: (v) => setState(() => _alarm = v),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.check),
            label: const Text('Save task'),
          ),
        ],
      ),
    ),
  );
}
