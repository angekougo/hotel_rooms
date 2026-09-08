import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_rooms/datas/room_repository.dart';
import 'package:hotel_rooms/screens/room_detail_screen.dart';
import 'package:hotel_rooms/screens/rooms_list_screen.dart';

Widget buildTestApp() {
  final router = GoRouter(
    initialLocation: '/rooms',
    routes: [
      GoRoute(
        path: '/rooms',
        builder: (context, state) => const RoomsListScreen(),
      ),
      GoRoute(
        path: '/room/:roomId',
        builder: (context, state) =>
            RoomDetailScreen(roomId: state.pathParameters['roomId']!),
      ),
      GoRoute(
        path: '/add-room',
        builder: (context, state) => const Scaffold(body: Text('Add Room')),
      ),
    ],
  );
  return MaterialApp.router(routerConfig: router);
}

void main() {
  setUp(() => RoomRepository.reset());
  tearDown(() => RoomRepository.reset());

  group('RoomsListScreen', () {
    testWidgets('affiche toutes les chambres au chargement', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      final totalRooms = RoomRepository.getAll().length;
      expect(find.text(RoomRepository.getAll().first.name), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
      expect(find.text(RoomRepository.getAll()[totalRooms - 1].name),
          findsOneWidget);
    });

    testWidgets('filtre les résultats via la recherche texte', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      final targetRoom = RoomRepository.getAll().first;
      await tester.enterText(find.byType(TextField), targetRoom.name);
      await tester.pumpAndSettle();

      expect(
        find.descendant(
            of: find.byType(GridView), matching: find.text(targetRoom.name)),
        findsOneWidget,
      );
      final otherRoom = RoomRepository.getAll()[1];
      expect(
        find.descendant(
            of: find.byType(GridView), matching: find.text(otherRoom.name)),
        findsNothing,
      );
    });

    testWidgets('affiche un message quand aucun résultat ne correspond',
        (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'zzz_inexistant_zzz');
      await tester.pumpAndSettle();

      expect(find.text('Aucune chambre trouvée.'), findsOneWidget);
    });
  });
}
