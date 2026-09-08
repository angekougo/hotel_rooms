import 'package:flutter/material.dart';

import '../datas/room_repository.dart';

class RoomDetailScreen extends StatelessWidget {
  final String roomId;
  const RoomDetailScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final room = RoomRepository.getById(roomId);

    if (room == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chambre introuvable')),
        body: const Center(
          child: Text('Cette chambre n\'existe pas ou plus.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(room.name),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;

          final image = Image.asset(
            room.imageUrl,
            height: isTablet ? null : 250,
            fit: BoxFit.cover,
          );

          final details = Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(room.name,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(room.description,
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 16),
                Text(
                    'Prix par nuit: ${room.pricePerNight.toStringAsFixed(2)} CFA',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                    'Status: ${room.status.roomStatusShowed.toString().split('.').last}',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          );

          if (isTablet) {
            // Image et détails côte à côte, chacun sur la moitié de l'écran.
            return Row(
              children: [
                Expanded(
                    child: SizedBox(height: double.infinity, child: image)),
                Expanded(child: SingleChildScrollView(child: details)),
              ],
            );
          }

          // Mobile : comportement actuel, empilé verticalement.
          return ListView(
            children: [image, details],
          );
        },
      ),
    );
  }
}
