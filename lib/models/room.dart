import 'room_status.dart';

class Room {
  final String id;
  final String number;
  final String name;
  final String type;
  final String description;
  final int pricePerNight;
  final String imageUrl;
  RoomStatus status;

  Room({
    required this.id,
    required this.number,
    required this.name,
    required this.type,
    required this.description,
    required this.pricePerNight,
    required this.imageUrl,
    this.status = RoomStatus.available,
  });
}