import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_http_request.dart';
import 'package:intl/intl.dart';
import 'package:time_flutter_course/Home/job_entries/format.dart';

void main() {
  group('hours', (){
    test('positive', () {
      expect(Format.hours(10), '10h');
    });
    test('zero', () {
      expect(Format.hours(0), '0h');
    });
    test('negative', () {
      expect(Format.hours(-5), '0h');
    });
    test('decimal', () {
      expect(Format.hours(4.5), '4.5h');
    });
  });

  group('data - GB Locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_BG';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('2019-08-12', () {
      expect(Format.date(DateTime(2019, 8, 12 )), '12 Aug 2019',
      );
    });
  });
}