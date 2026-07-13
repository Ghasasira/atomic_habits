import 'package:atomic_habits/core/constants/enums.dart';
import 'package:atomic_habits/core/utils/date_x.dart';
import 'package:atomic_habits/core/utils/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeekdayMask', () {
    test('all-days mask contains every weekday', () {
      for (var wd = DateTime.monday; wd <= DateTime.sunday; wd++) {
        expect(kAllWeekdaysMask.hasWeekday(wd), isTrue);
      }
    });

    test('toggle turns individual days on and off', () {
      var mask = 0;
      mask = mask.toggleWeekday(DateTime.wednesday, true);
      expect(mask.hasWeekday(DateTime.wednesday), isTrue);
      expect(mask.hasWeekday(DateTime.thursday), isFalse);
      mask = mask.toggleWeekday(DateTime.wednesday, false);
      expect(mask.hasWeekday(DateTime.wednesday), isFalse);
    });
  });

  group('isDueOn', () {
    // A Wednesday.
    final wednesday = DateTime(2026, 7, 15);
    final thursday = DateTime(2026, 7, 16);

    test('daily is always due', () {
      expect(
        isDueOn(frequency: FrequencyType.daily, day: wednesday),
        isTrue,
      );
    });

    test('weekly is due only on selected weekdays', () {
      final wedOnly = 0.toggleWeekday(DateTime.wednesday, true);
      expect(
        isDueOn(
          frequency: FrequencyType.weekly,
          day: wednesday,
          weekdaysMask: wedOnly,
        ),
        isTrue,
      );
      expect(
        isDueOn(
          frequency: FrequencyType.weekly,
          day: thursday,
          weekdaysMask: wedOnly,
        ),
        isFalse,
      );
    });

    test('interval is due on the anchor and every N days after', () {
      final anchor = DateTime(2026, 7, 13); // Monday
      // every 3 days: due on 13th, 16th, 19th...
      expect(
        isDueOn(
          frequency: FrequencyType.interval,
          day: DateTime(2026, 7, 13),
          intervalDays: 3,
          anchorDate: anchor,
        ),
        isTrue,
      );
      expect(
        isDueOn(
          frequency: FrequencyType.interval,
          day: DateTime(2026, 7, 16),
          intervalDays: 3,
          anchorDate: anchor,
        ),
        isTrue,
      );
      expect(
        isDueOn(
          frequency: FrequencyType.interval,
          day: DateTime(2026, 7, 15),
          intervalDays: 3,
          anchorDate: anchor,
        ),
        isFalse,
      );
    });

    test('interval is never due before the anchor', () {
      expect(
        isDueOn(
          frequency: FrequencyType.interval,
          day: DateTime(2026, 7, 10),
          intervalDays: 3,
          anchorDate: DateTime(2026, 7, 13),
        ),
        isFalse,
      );
    });
  });

  group('frequencySummary', () {
    test('daily', () {
      expect(
        frequencySummary(
          frequency: FrequencyType.daily,
          weekdaysMask: kAllWeekdaysMask,
          intervalDays: 1,
        ),
        'Every day',
      );
    });

    test('weekly lists the chosen days', () {
      final mask = 0
          .toggleWeekday(DateTime.monday, true)
          .toggleWeekday(DateTime.friday, true);
      expect(
        frequencySummary(
          frequency: FrequencyType.weekly,
          weekdaysMask: mask,
          intervalDays: 1,
        ),
        'Mon, Fri',
      );
    });

    test('interval', () {
      expect(
        frequencySummary(
          frequency: FrequencyType.interval,
          weekdaysMask: kAllWeekdaysMask,
          intervalDays: 3,
        ),
        'Every 3 days',
      );
    });
  });

  group('formatMetric', () {
    test('drops trailing zeros', () {
      expect(formatMetric(3.0), '3');
      expect(formatMetric(3.5), '3.5');
      expect(formatMetric(10.25), '10.25');
    });
  });
}
