import 'package:go_router/go_router.dart';
import 'package:test/views/catScreen.dart';
import 'package:test/views/eventListScreen.dart';
import 'package:test/views/signinScreen.dart';
import 'package:test/views/webViewScereen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => CategoryScreen(),
    ),
    GoRoute(
      path: '/eventList',
      builder: (context, state) {
        final url = state.uri.queryParameters['url']!;
        final category = state.uri.queryParameters['category']!;
        return EventListScreen(url: url, category: category);
      },
    ),
    GoRoute(
      path: '/webview',
      builder: (context, state) {
        final url = state.uri.queryParameters['url']!;
        final title = state.uri.queryParameters['title'] ?? 'Event';
        return WebviewScreen(url: url, title: title);
      },
    ),
  ],
);
