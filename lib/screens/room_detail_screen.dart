import 'package:flutter/material.dart';

import '../datas/room_mock.dart';

class RoomDetailScreen extends StatelessWidget {
  final String roomId;
  const RoomDetailScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final room = rooms.firstWhere((r) => r.id == roomId);

    return Scaffold(
      appBar: AppBar(
        title: Text(room.name),
      ),
      body: ListView(
        children: [
          Image.asset(room.imageUrl, height: 250, fit: BoxFit.cover),
          Padding(padding: const EdgeInsets.all(16.0), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(room.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(room.description, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 16),
              Text('Prix par nuit: ${room.pricePerNight.toStringAsFixed(2)} CFA', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text('Status: ${room.status.roomStatusShowed.toString().split('.').last}', style: Theme.of(context).textTheme.titleMedium),
            ],
          )),
        ],
      ),
    );
  }
}