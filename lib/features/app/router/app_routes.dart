enum AppRoutes {
  splash('/splash'),
  login('/login'),
  register('/register'),
  authRoute('/auth'),
  fullscreen('/fullscreen'), // Fullscreen Image View route
  chatList('/'), // Main chat list route
  chat('/chat',path: '/chat/:chat_id'),
  profile('/profile');


  const AppRoutes(this.route, {this.path});
  final String route;
  final String? path;


  String get name => route.replaceAll('/', '');

}
