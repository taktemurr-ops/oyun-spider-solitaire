import 'package:flutter_test/flutter_test.dart';
import 'package:kart_motoru/kart_motoru.dart';
import 'package:oyun_spider_solitaire/oyun_spider_solitaire.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(spiderConfig.title.length, 33);
    expect(spiderConfig.tagline.length, 33);
    for (final s in spiderConfig.tutorial) {
      expect(s.text.length, 33);
    }
  });

  test('bölümler çözülebilir ve kazanılır', () {
    final planner = LevelPlanner(gameId: spiderId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = spiderRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final l = gl.puzzle;
      final g = SolGame(l.variant, l.start);
      var guard = 0;
      while (!g.won && guard++ < 3000) {
        final m = g.hint(cap: 40000 * 2);
        expect(m, isNotNull, reason: 'bölüm $lv');
        g.play(m!);
      }
      expect(g.won, isTrue, reason: 'bölüm $lv');
    }
  });
}
