import '../models/room.dart';
import '../models/room_status.dart';

// room_mock.dart - transformer en repository simple
class RoomRepository {
  RoomRepository._();

  static final List<Room> _initialRooms  = [
    Room(
      id: '1',
      number: '101',
      name: 'Chambre Standard Coquet',
      type: 'Standard',
      description:
          'Une chambre lumineuse et épurée, parfaite pour les séjours professionnels. Équipée d\'un lit Queen-size et d\'un espace de travail fonctionnel.',
      pricePerNight: 85,
      imageUrl: 'assets/images/rooms/c1.jpg',
      status: RoomStatus.available,
    ),
    Room(
      id: '2',
      number: '102',
      name: 'Chambre Deluxe Jardin',
      type: 'Deluxe',
      description:
          'Profitez d\'un accès direct et privatif au jardin de l\'hôtel. Cette chambre spacieuse propose un lit King-size et une salle de bain en marbre.',
      pricePerNight: 130,
      imageUrl: 'assets/images/rooms/c2.jpg',
      status: RoomStatus.booked,
    ),
    Room(
      id: '3',
      number: '201',
      name: 'Suite Impériale Océan',
      type: 'Suite',
      description:
          'Notre plus belle suite. Elle offre une vue panoramique sur l\'océan, un grand salon séparé et un jacuzzi privatif sur la terrasse.',
      pricePerNight: 350,
      imageUrl: 'assets/images/rooms/c3.jpg',
      status: RoomStatus.available,
    ),
    Room(
      id: '4',
      number: '202',
      name: 'Studio Famille Horizon',
      type: 'Studio',
      description:
          'Idéal pour les familles ou les longs séjours. Ce studio comprend un lit double, deux lits superposés discrets ainsi qu\'une kitchenette.',
      pricePerNight: 180,
      imageUrl: 'assets/images/rooms/c4.jpg',
      status: RoomStatus.booked,
    ),
    Room(
      id: '5',
      number: '305',
      name: 'Chambre Éco Douillette',
      type: 'Standard',
      description:
          'Chambre compacte mais parfaitement agencée sous les combles. Idéale pour les voyageurs solos cherchant le confort à petit prix.',
      pricePerNight: 65,
      imageUrl: 'assets/images/rooms/c5.jpg',
      status: RoomStatus.maintenance,
    ),
  ];
  
  static List<Room> _rooms = List.of(_initialRooms);

  static List<Room> getAll() => List.unmodifiable(_rooms);

  static Room? getById(String id) {
    for (final room in _rooms) {
      if (room.id == id) return room;
    }
    return null;
  }

  static void add(Room room) {
    _rooms.add(room);
  }

  static void reset() => _rooms = List.of(_initialRooms);
}
