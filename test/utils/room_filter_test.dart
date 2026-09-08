import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_rooms/models/room.dart';
import 'package:hotel_rooms/utils/room_filter.dart';

Room _room(String name, String type) => Room(
      id: name,
      number: '1',
      name: name,
      type: type,
      description: '',
      pricePerNight: 50,
      imageUrl: 'assets/images/rooms/c1.jpg',
    );

void main() {
  final rooms = [
    _room('Chambre Standard Coquet', 'Standard'),
    _room('Chambre Deluxe Jardin', 'Deluxe'),
    _room('Suite Présidentielle', 'Suite'),
  ];

  group('filterRooms', () {
    test('sans filtre, retourne toutes les chambres', () {
      final result = filterRooms(rooms, searchQuery: '', selectedType: 'Tous');
      expect(result.length, 3);
    });

    test('filtre par texte de recherche, insensible à la casse', () {
      final result =
          filterRooms(rooms, searchQuery: 'DELUXE', selectedType: 'Tous');
      expect(result.length, 1);
      expect(result.first.name, 'Chambre Deluxe Jardin');
    });

    test('filtre par type de chambre', () {
      final result =
          filterRooms(rooms, searchQuery: '', selectedType: 'Suite');
      expect(result.length, 1);
      expect(result.first.type, 'Suite');
    });

    test('combine recherche texte et filtre par type', () {
      final result = filterRooms(rooms,
          searchQuery: 'chambre', selectedType: 'Standard');
      expect(result.length, 1);
      expect(result.first.name, 'Chambre Standard Coquet');
    });

    test('ignore les espaces superflus dans la recherche', () {
      final result =
          filterRooms(rooms, searchQuery: '  deluxe  ', selectedType: 'Tous');
      expect(result.length, 1);
    });

    test('retourne une liste vide si rien ne correspond', () {
      final result = filterRooms(rooms,
          searchQuery: 'zzz_inexistant', selectedType: 'Tous');
      expect(result, isEmpty);
    });
  });

  group('availableRoomTypes', () {
    test('retourne Tous en premier suivi des types distincts', () {
      final types = availableRoomTypes(rooms);
      expect(types.first, 'Tous');
      expect(types, containsAll(['Standard', 'Deluxe', 'Suite']));
      expect(types.length, 4);
    });
  });
}