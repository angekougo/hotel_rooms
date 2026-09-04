import 'package:go_router/go_router.dart';

import '../screens/add_room_screen.dart';
import '../screens/home_screen.dart';
import '../screens/room_detail_screen.dart';
import '../screens/rooms_list_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
        path: '/rooms', builder: (context, state) => const RoomsListScreen()),
    GoRoute(
        path: '/room/:roomId',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return RoomDetailScreen(roomId: roomId);
        }),
    GoRoute(
        path: '/add-room', builder: (context, state) => const AddRoomScreen()),
  ],
);
