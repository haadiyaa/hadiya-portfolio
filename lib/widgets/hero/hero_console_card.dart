import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../theme/app_theme.dart';

/// Interactive developer IDE/console card for the Hero section.
class HeroConsoleCard extends HookWidget {
  final bool isDark;

  const HeroConsoleCard({super.key, required this.isDark});

  static const _tabs = ['developer.dart', 'offline_sync.dart', 'stack.json'];

  static const _codeSnippets = [
    // developer.dart
    '''class HaadiyaCT extends FlutterDeveloper {
  final exp = Duration(years: 3);
  final focus = ['Enterprise ERP', 'Offline-First'];
  final stateStack = [Riverpod, BLoC, Hooks];

  @override
  App buildEnterpriseApp() => ScalableArchitecture(
    cleanArchitecture: true,
    responsiveLayouts: ['Mobile', 'Desktop', 'Web'],
    performance: '60-120 FPS Target',
  );
}''',

    // offline_sync.dart
    '''Future<void> syncOfflineData() async {
  final localDB = await SQLiteDatabase.open();
  final pending = await localDB.getPendingTransactions();
  
  for (final record in pending) {
    final res = await erpApi.pushSync(record);
    if (res.isSuccess) await localDB.markSynced(record.id);
  }
  emit(SyncState.synchronized(localDB.stats));
}''',

    // stack.json
    '''{
  "name": "Haadiya CT",
  "title": "Flutter Developer",
  "frameworks": ["Flutter 3.x", "Dart", "WPF C#"],
  "storage": ["SQLite", "SQFlite", "Hive", "REST"],
  "methodology": ["Clean Architecture", "TDD", "CI/CD"],
  "status": "Available for Opportunities"
}'''
  ];

  @override
  Widget build(BuildContext context) {
    final activeTab = useState(0);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppTheme.darkBorder : Colors.black87,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryCyan.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Mac-style Window Title Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF161B22),
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              border: Border(bottom: BorderSide(color: Color(0xFF21262D))),
            ),
            child: Row(
              children: [
                _dot(const Color(0xFFFF5F56)),
                const SizedBox(width: 8),
                _dot(const Color(0xFFFFBD2E)),
                const SizedBox(width: 8),
                _dot(const Color(0xFF27C93F)),
                const SizedBox(width: 16),
                // Tabs
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_tabs.length, (i) {
                        final isSelected = activeTab.value == i;
                        return InkWell(
                          onTap: () => activeTab.value = i,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF0D1117) : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: isSelected
                                  ? Border.all(color: const Color(0xFF30363D))
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  i == 2 ? Icons.data_object_rounded : Icons.code_rounded,
                                  size: 12,
                                  color: isSelected ? AppTheme.primaryCyan : Colors.white38,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _tabs[i],
                                  style: TextStyle(
                                    fontFamily: 'Courier',
                                    fontSize: 11.5,
                                    color: isSelected ? Colors.white : Colors.white54,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Code Display Area with Line Numbers
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Line numbers
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(10, (idx) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.5),
                      child: Text(
                        '${idx + 1}',
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          color: Color(0xFF484F58),
                          fontSize: 12.5,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 16),
                // Code content
                Expanded(
                  child: Text(
                    _codeSnippets[activeTab.value],
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      color: Color(0xFFE6EDF3),
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Status Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF161B22),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
              border: Border(top: BorderSide(color: Color(0xFF21262D))),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle_outline_rounded, size: 12, color: AppTheme.accentEmerald),
                SizedBox(width: 6),
                Text(
                  'Sound Null Safety',
                  style: TextStyle(fontFamily: 'Courier', color: AppTheme.accentEmerald, fontSize: 11),
                ),
                Spacer(),
                Text(
                  '60 FPS Target • Dart 3.x',
                  style: TextStyle(fontFamily: 'Courier', color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
