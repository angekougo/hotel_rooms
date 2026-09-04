enum RoomStatus {
  available('Disponible'),
  booked('Réservé'),
  occupied('occupée'),
  maintenance('En maintenance');

  final String roomStatusShowed;

  const RoomStatus(this.roomStatusShowed);
}
