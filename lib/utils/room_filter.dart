import '../models/room.dart';

List<Room> filterRooms(
  List<Room> rooms, {
  required String searchQuery,
  required String selectedType,
}) {
  final normalizedQuery = searchQuery.trim().toLowerCase();

  return rooms.where((room) {
    final matchesSearch = normalizedQuery.isEmpty ||
        room.name.toLowerCase().contains(normalizedQuery);
    final matchesType =
        selectedType == 'Tous' || room.type == selectedType;
    return matchesSearch && matchesType;
  }).toList();
}

List<String> availableRoomTypes(List<Room> rooms) {
  return <String>[
    'Tous',
    ...{for (final room in rooms) room.type},
  ];
}