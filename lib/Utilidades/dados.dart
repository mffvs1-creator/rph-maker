import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
void main() {
  runApp(const DiceRollerApp());
}
 
// ─────────────────────────────────────────────
// Models
// ─────────────────────────────────────────────
 
class RollResult {
  final List<int> values;
  final int sides;
  final DateTime timestamp;
 
  RollResult({
    required this.values,
    required this.sides,
    required this.timestamp,
  });
 
  int get total => values.fold(0, (a, b) => a + b);
  int get count => values.length;
 
  String get label => '${count}d$sides';
  String get timeLabel {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    if (diff.inSeconds < 60) return 'Agora';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m atrás';
    return '${diff.inHours}h atrás';
  }
}
 
// ─────────────────────────────────────────────
// App
// ─────────────────────────────────────────────
 
class DiceRollerApp extends StatelessWidget {
  const DiceRollerApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dados RPG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5B8B),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Georgia',
      ),
      home: const DiceRollerHome(),
    );
  }
}
 
// ─────────────────────────────────────────────
// Home Screen
// ─────────────────────────────────────────────
 
class DiceRollerHome extends StatefulWidget {
  const DiceRollerHome({super.key});
 
  @override
  State<DiceRollerHome> createState() => _DiceRollerHomeState();
}
 
class _DiceRollerHomeState extends State<DiceRollerHome>
    with TickerProviderStateMixin {
  final Random _rng = Random();
  final List<RollResult> _history = [];
 
  int _selectedSides = 6;
  int _diceCount = 1;
  RollResult? _lastRoll;
 
  // Shake / bounce animation for dice
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
 
  // Fade-in for result
  late AnimationController _resultFadeController;
  late Animation<double> _resultFade;
 
  static const List<int> _diceSides = [4, 6, 8, 10, 12, 20,];
 
  // Face symbols per die type (used decoratively)
  static const Map<int, String> _diceEmoji = {
    4: '▲',
    6: '⬛',
    8: '◆',
    10: '◉',
    12: '⬠',
    20: '⬡',
  };
 
  @override
  void initState() {
    super.initState();
 
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -12.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12.0, end: 12.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 12.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));
 
    _resultFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _resultFade = CurvedAnimation(
      parent: _resultFadeController,
      curve: Curves.easeOut,
    );
  }
 
  @override
  void dispose() {
    _shakeController.dispose();
    _resultFadeController.dispose();
    super.dispose();
  }
 
  void _roll() {
    HapticFeedback.mediumImpact();
 
    final values = List.generate(
      _diceCount,
      (_) => _rng.nextInt(_selectedSides) + 1,
    );
 
    final result = RollResult(
      values: values,
      sides: _selectedSides,
      timestamp: DateTime.now(),
    );
 
    setState(() {
      _lastRoll = result;
      _history.insert(0, result);
      if (_history.length > 50) _history.removeLast();
    });
 
    _shakeController.forward(from: 0);
    _resultFadeController.forward(from: 0);
  }
 
  void _clearHistory() {
    setState(() => _history.clear());
  }
 
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
 
    return Scaffold(
      backgroundColor: const Color(0xFF12100E),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildDiceSelector(colors),
            _buildRollArea(colors),
            _buildCountSelector(colors),
            _buildRollButton(colors),
            const SizedBox(height: 8),
            _buildHistorySection(colors),
          ],
        ),
      ),
    );
  }
 
  // ── Header ───────────────────────────────────
 
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 4),
      child: Row(
        children: [
          const Text(
            'DADOS',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: 7,
              color: Color(0xFF2E5B8B),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2E5B8B),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'RPG',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w200,
              letterSpacing: 7,
              color: Color(0xFF5A788F),
            ),
          ),
          const Spacer(),
          if (_history.isNotEmpty)
            TextButton(
              onPressed: _clearHistory,
              child: const Text(
                'limpar histórico',
                style: TextStyle(
                  color: Color(0xFF5A788F),
                  fontSize: 13,
                  letterSpacing: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
 
  // ── Die-type Selector ─────────────────────────
 
  Widget _buildDiceSelector(ColorScheme colors) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: _diceSides.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final sides = _diceSides[i];
          final selected = sides == _selectedSides;
          return GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _selectedSides = sides);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF2E5B8B)
                    : const Color(0xFF1E1C18),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF2E5B8B)
                      : const Color(0xFF2E2C28),
                  width: 1.5,
                ),
              ),
              child: Text(
                'd$sides',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: selected
                      ? const Color(0xFF12100E)
                      : const Color(0xFF5A788F),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
 
  // ── Roll Area (big result display) ─────────────
 
  Widget _buildRollArea(ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: child,
          );
        },
        child: Container(
          height: 170,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1814),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF2A2820),
              width: 1.5,
            ),
          ),
          child: _lastRoll == null
              ? _buildEmptyRollState()
              : _buildRollResultDisplay(),
        ),
      ),
    );
  }
 
  Widget _buildEmptyRollState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _diceEmoji[_selectedSides] ?? '⬛',
            style: const TextStyle(fontSize: 40, color: Color(0xFF2A2820)),
          ),
          const SizedBox(height: 8),
          Text(
            'Role para começar',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.2),
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildRollResultDisplay() {
    final roll = _lastRoll!;
    return FadeTransition(
      opacity: _resultFade,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Individual dice values
            if (roll.count > 1)
              Wrap(
                spacing: 8,
                runSpacing: 6,
                alignment: WrapAlignment.center,
                children: roll.values
                    .map((v) => _buildMiniDie(v, roll.sides))
                    .toList(),
              ),
            if (roll.count > 1) const SizedBox(height: 10),
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (roll.count > 1)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 6, right: 8),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 3,
                        color: Color(0xFF5A788F),
                      ),
                    ),
                  ),
                Text(
                  '${roll.total}',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2E5B8B),
                    height: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              roll.label,
              style: const TextStyle(
                fontSize: 12,
                letterSpacing: 3,
                color: Color(0xFF5A788F),
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _buildMiniDie(int value, int sides) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF252320),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF2E2C28)),
      ),
      child: Text(
        '$value',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2E5B8B),
        ),
      ),
    );
  }
 
  // ── Dice Count Selector ───────────────────────
 
  Widget _buildCountSelector(ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Row(
        children: [
          const Text(
            'Quantidade de dados',
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 2,
              color: Color(0xFF5A788F),
            ),
          ),
          const Spacer(),
          _CountButton(
            icon: Icons.remove,
            onTap: _diceCount > 1
                ? () => setState(() => _diceCount--)
                : null,
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 28,
            child: Text(
              '$_diceCount',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2E5B8B),
              ),
            ),
          ),
          const SizedBox(width: 16),
          _CountButton(
            icon: Icons.add,
            onTap: _diceCount < 20
                ? () => setState(() => _diceCount++)
                : null,
          ),
        ],
      ),
    );
  }
 
  // ── Roll Button ───────────────────────────────
 
  Widget _buildRollButton(ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: GestureDetector(
        onTap: _roll,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF2E5B8B),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2E5B8B).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _diceEmoji[_selectedSides] ?? '⬛',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 10),
              const Text(
                'ROLAR',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                  color: Color(0xFF12100E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 
  // ── History Section ───────────────────────────
 
  Widget _buildHistorySection(ColorScheme colors) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Row(
              children: [
                const Text(
                  'HISTÓRICO',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 4,
                    color: Color(0xFF5A788F),
                  ),
                ),
                const SizedBox(width: 8),
                if (_history.isNotEmpty)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1C18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_history.length}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF5A788F),
                        letterSpacing: 0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: _history.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum lançamento ainda',
                      style: TextStyle(
                        color: Color(0xFF5A788F),
                        fontSize: 13,
                        letterSpacing: 2,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                    itemCount: _history.length,
                    itemBuilder: (context, i) =>
                        _HistoryTile(roll: _history[i], index: i),
                  ),
          ),
        ],
      ),
    );
  }
}
 
// ─────────────────────────────────────────────
// Widgets
// ─────────────────────────────────────────────
 
class _CountButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
 
  const _CountButton({required this.icon, required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: () {
        if (enabled) {
          HapticFeedback.selectionClick();
          onTap!();
        }
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1C18),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF2E2C28),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled ? const Color(0xFF2E5B8B) : const Color(0xFF333028),
        ),
      ),
    );
  }
}
 
class _HistoryTile extends StatelessWidget {
  final RollResult roll;
  final int index;
 
  const _HistoryTile({required this.roll, required this.index});
 
  @override
  Widget build(BuildContext context) {
    final isFirst = index == 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isFirst
              ? const Color(0xFF1E1A12)
              : const Color(0xFF161412),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isFirst
                ? const Color(0xFF34445D)
                : const Color(0xFF1E1C18),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Badge
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isFirst
                    ? const Color(0xFF2E2410)
                    : const Color(0xFF1A1814),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${roll.total}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: isFirst
                          ? const Color(0xFF2E5B8B)
                          : const Color(0xFF34445D),
                      height: 1,
                    ),
                  ),
                  Text(
                    roll.label,
                    style: const TextStyle(
                      fontSize: 9,
                      letterSpacing: 1,
                      color: Color(0xFF34445D),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            // Values
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (roll.count > 1)
                    Text(
                      roll.values.join('  ·  '),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF5A788F),
                        letterSpacing: 1,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                  else
                    const SizedBox.shrink(),
                  Text(
                    roll.count == 1
                        ? 'Um dado · d${roll.sides}'
                        : '${roll.count} Dados · d${roll.sides}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF3A3830),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            // Time
            Text(
              roll.timeLabel,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF3A3830),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}