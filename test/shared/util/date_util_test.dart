import 'package:flutter_test/flutter_test.dart';
import 'package:uponorflix/shared/util/date_util.dart';

void main() {
  test('Should format the date correctly', () {
    final date = DateTime(2021, 1, 31);
    const expected = "31/1/2021";

    final result = DateUtil.getFormattedDate(date);

    expect(result, expected);
  });
}
