import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_rooms/datas/room_repository.dart';
import 'package:hotel_rooms/models/room.dart';
import 'package:hotel_rooms/models/room_status.dart';
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
  // Réinitialise les données réelles avant/après chaque test pour éviter
  // qu'un test n'influence le suivant.
  setUp(() => RoomRepository.reset());
  tearDown(() => RoomRepository.reset());

  group('RoomsListScreen (widget réel)', () {
    testWidgets('affiche toutes les chambres au chargement', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      final totalRooms = RoomRepository.getAll().length;
      expect(find.text(RoomRepository.getAll().first.name), findsOneWidget);
      // Le GridView doit contenir une carte par chambre.
      expect(find.byType(GridView), findsOneWidget);
      expect(find.text(RoomRepository.getAll()[totalRooms - 1].name),
          findsOneWidget);
    });

    testWidgets('filtre les résultats via la recherche texte', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      // On tape un nom qui ne correspond qu'à une seule chambre.
      final targetRoom = RoomRepository.getAll().first;
      await tester.enterText(find.byType(TextField), targetRoom.name);
      await tester.pumpAndSettle();

      expect(find.text(targetRoom.name), findsOneWidget);
      // Une autre chambre connue ne doit plus apparaître.
      final otherRoom = RoomRepository.getAll()[1];
      expect(find.text(otherRoom.name), findsNothing);
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

  group('Room / RoomRepository (logique métier)', () {
    test('getAll() retourne la liste initiale de chambres', () {
      final rooms = RoomRepository.getAll();
      expect(rooms, isNotEmpty);
      expect(rooms.every((r) => r.id.isNotEmpty), isTrue);
    });

    test('add() ajoute bien une nouvelle chambre à la liste', () {
      final countBefore = RoomRepository.getAll().length;

      RoomRepository.add(Room(
        id: 'test-1',
        number: '999',
        name: 'Chambre Test',
        type: 'Standard',
        description: 'Chambre créée pour un test',
        pricePerNight: 50,
        imageUrl: 'assets/images/rooms/c1.jpg',
        status: RoomStatus.available,
      ));

      final countAfter = RoomRepository.getAll().length;
      expect(countAfter, countBefore + 1);
      expect(RoomRepository.getById('test-1')?.name, 'Chambre Test');
    });

    test('getById() retourne null pour un id inexistant', () {
      expect(RoomRepository.getById('id-qui-n-existe-pas'), isNull);
    });
  });
}