import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quantity_package/src/quantity_button.dart';

void main() {
  testWidgets('quantity button', (tester) async {
    int value = 1;
    int maxValue = 2;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: QuantityButton(
                    value: value,
                    onChangeValue: (value) => print('changed'),
                    maxValue: maxValue,
                    isLoading: false,
                  ),
                ),
              ],
            )),
      ),
    );
    await _testAvailabilityOfIcons(tester, value);
    await _addValueTest(tester, value);

    await _removeValueTest(tester, value);

    //max value test
    await _maxValueTest(tester, value);
  });
}

Future _testAvailabilityOfIcons(WidgetTester tester, int value) async {
  await tester.pump();
  expect(find.byIcon(Icons.add), findsOneWidget);
  expect(find.byIcon(Icons.remove), findsOneWidget);
  expect(
      find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == (value).toString().padLeft(2, '0')),
      findsOneWidget);
}

Future _addValueTest(WidgetTester tester, int value) async {
  await tester.tap(find.byIcon(Icons.add));

  await tester.pump();
  expect(
      find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == (value + 1).toString().padLeft(2, '0')),
      findsOneWidget);
}

Future _removeValueTest(WidgetTester tester, int value) async {
  await tester.tap(find.byIcon(Icons.remove));
  await tester.pump();

  expect(
      find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == (value).toString().padLeft(2, '0')),
      findsWidgets);
}

Future _maxValueTest(WidgetTester tester, int value) async {
  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();
  await tester.tap(find.byIcon(Icons.add));

  expect(
      find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == (value + 1).toString().padLeft(2, '0')),
      findsOneWidget);
  expect(
      find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == (value + 2).toString().padLeft(2, '0')),
      findsNothing);
}
