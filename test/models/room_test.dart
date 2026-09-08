import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_rooms/models/room.dart';
import 'package:hotel_rooms/models/room_status.dart';

void main() {
  group('Room', () {
    test('crée une chambre avec tous les champs requis', () {
      final room = Room(
        id: '1',
        number: '101',
        name: 'Chambre Test',
        type: 'Standard',
        description: 'Description test',
        pricePerNight: 100,
        imageUrl: 'assets/images/rooms/c1.jpg',
      );

      expect(room.id, '1');
      expect(room.number, '101');
      expect(room.name, 'Chambre Test');
      expect(room.pricePerNight, 100);
    });

    test('status par défaut est RoomStatus.available si non précisé', () {
      final room = Room(
        id: '2',
        number: '102',
        name: 'Chambre Sans Status',
        type: 'Standard',
        description: 'Description',
        pricePerNight: 50,
        imageUrl: 'assets/images/rooms/c1.jpg',
      );

      expect(room.status, RoomStatus.available);
    });

    test('accepte un status explicite différent de la valeur par défaut', () {
      final room = Room(
        id: '3',
        number: '103',
        name: 'Chambre Occupée',
        type: 'Deluxe',
        description: 'Description',
        pricePerNight: 150,
        imageUrl: 'assets/images/rooms/c2.jpg',
        status: RoomStatus.booked,
      );

      expect(room.status, RoomStatus.booked);
      expect(room.status, isNot(RoomStatus.available));
    });
  });
}