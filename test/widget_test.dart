import 'package:flutter_test/flutter_test.dart';

import 'package:maps_and_geolocation/main.dart';

void main() {
  testWidgets('renders the map screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MapsApp());

    expect(find.text('OpenStreetMap'), findsOneWidget);
    expect(find.byTooltip('Obtener ubicación'), findsOneWidget);
  });
}
