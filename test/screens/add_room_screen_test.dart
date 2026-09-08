import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_rooms/datas/room_repository.dart';
import 'package:hotel_rooms/screens/add_room_screen.dart';

void main() {
  setUp(() => RoomRepository.reset());
  tearDown(() => RoomRepository.reset());

  late GoRouter router;

  Widget buildTestApp() {
    router = GoRouter(
      initialLocation: '/rooms',
      routes: [
        GoRoute(
          path: '/rooms',
          builder: (context, state) => const Scaffold(body: Text('Rooms List')),
        ),
        GoRoute(
          path: '/add-room',
          builder: (context, state) => const AddRoomScreen(),
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router);
  }

  group('AddRoomScreen', () {
    testWidgets('ajoute une chambre au RoomRepository quand le formulaire est valide',
        (tester) async {
      await tester.pumpWidget(buildTestApp());
      router.push('/add-room'); // on empile réellement AddRoomScreen sur /rooms
      await tester.pumpAndSettle();

      final countBefore = RoomRepository.getAll().length;

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Chambre E2E Test');
      await tester.enterText(fields.at(1), 'Standard');
      await tester.enterText(fields.at(2), '99');
      await tester.enterText(fields.at(3), '404');

      await tester.tap(find.text('Enregister'));
      await tester.pumpAndSettle();

      expect(RoomRepository.getAll().length, countBefore + 1);
      expect(RoomRepository.getAll().any((r) => r.name == 'Chambre E2E Test'), isTrue);
    });

    testWidgets('n\'ajoute rien si le formulaire est invalide (champs vides)',
        (tester) async {
      await tester.pumpWidget(buildTestApp());
      router.push('/add-room');
      await tester.pumpAndSettle();

      final countBefore = RoomRepository.getAll().length;

      await tester.tap(find.text('Enregister'));
      await tester.pumpAndSettle();

      expect(RoomRepository.getAll().length, countBefore);
      expect(find.text('Nom obligatoire'), findsOneWidget);
    });
  });
}