import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_rooms/datas/room_repository.dart';
import 'package:hotel_rooms/models/room.dart';
import 'package:hotel_rooms/models/room_status.dart';

void main() {
  setUp(() => RoomRepository.reset());
  tearDown(() => RoomRepository.reset());

  group('RoomRepository', () {
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