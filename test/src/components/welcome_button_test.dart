import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pairs_game/components/welcome_button.dart';
import 'package:pairs_game/constants/ui_colors.dart';

void main() {
  testWidgets('WelcomeButton displays correct text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeButton(
          text: 'Start Game',
          onPressed: () {},
        ),
      ),
    );

    expect(find.text('Start Game'), findsOneWidget);
  });

  testWidgets('WelcomeButton calls onPressed when tapped',
      (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeButton(
          text: 'Play',
          onPressed: () {
            pressed = true;
          },
        ),
      ),
    );

    await tester.tap(find.byType(OutlinedButton));
    expect(pressed, isTrue);
  });

  testWidgets('WelcomeButton uses default color', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeButton(
          text: 'Default Color',
          onPressed: () {},
        ),
      ),
    );

    final outlinedButton =
        tester.widget<OutlinedButton>(find.byType(OutlinedButton));
    final ButtonStyle? style = outlinedButton.style;
    final side = style?.side?.resolve({});

    expect(side?.color, UIColors.green);
    expect(side?.width, 2);
  });

  testWidgets('WelcomeButton uses custom color', (WidgetTester tester) async {
    const customColor = Colors.red;
    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeButton(
          text: 'Custom Color',
          onPressed: () {},
          color: customColor,
        ),
      ),
    );

    final outlinedButton =
        tester.widget<OutlinedButton>(find.byType(OutlinedButton));
    final ButtonStyle? style = outlinedButton.style;
    final side = style?.side?.resolve({});

    expect(side?.color, customColor);
  });

  testWidgets('WelcomeButton has correct text style',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeButton(
          text: 'Styled Text',
          onPressed: () {},
        ),
      ),
    );

    final outlinedButton =
        tester.widget<OutlinedButton>(find.byType(OutlinedButton));
    final ButtonStyle? style = outlinedButton.style;
    final textStyle = style?.textStyle?.resolve({});

    expect(textStyle?.fontSize, 24);
    expect(textStyle?.fontWeight, FontWeight.bold);
  });
}
