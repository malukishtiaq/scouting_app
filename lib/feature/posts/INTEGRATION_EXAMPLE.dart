/// Example: How to integrate Posts feature into your app
///
/// This file shows different ways to add the Posts feature to your existing app.
/// Choose the method that best fits your app's architecture.
///
/// API Documentation: https://scouting.terveys.io/docs
/// Base URL: https://scouting.terveys.io
/// Authentication: Not required (public API)

import 'package:flutter/material.dart';
import 'package:scouting_app/feature/posts/posts_export.dart';

// ============================================================================
// EXAMPLE 1: Add to existing bottom navigation
// ============================================================================

class ExampleBottomNavigation extends StatefulWidget {
  const ExampleBottomNavigation({super.key});

  @override
  State<ExampleBottomNavigation> createState() =>
      _ExampleBottomNavigationState();
}

class _ExampleBottomNavigationState extends State<ExampleBottomNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          // Your existing screens
          Center(child: Text('Home')),
          Center(child: Text('Search')),

          // 👇 Add Posts screen here
          PostsScreen(),

          // Your other screens
          Center(child: Text('Profile')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),

          // 👇 Add Posts navigation item here
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Posts'),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 2: Add as a route
// ============================================================================

class ExampleRoutes {
  static const String posts = '/posts';
  static const String postDetail = '/post-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // 👇 Add Posts route
      case posts:
        return MaterialPageRoute(builder: (_) => const PostsScreen());

      // 👇 Add Post Detail route (optional)
      case postDetail:
        final postId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => PostDetailPage(postId: postId),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}

// Usage:
// Navigator.pushNamed(context, ExampleRoutes.posts);
// Navigator.pushNamed(context, ExampleRoutes.postDetail, arguments: 1);

// ============================================================================
// EXAMPLE 3: Add to drawer menu
// ============================================================================

class ExampleDrawer extends StatelessWidget {
  const ExampleDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Menu')),

          // Your existing menu items
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),

          // 👇 Add Posts menu item
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Posts'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PostsScreen()),
              );
            },
          ),

          // Your other menu items
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 4: Standalone page with app bar
// ============================================================================

class ExampleStandalonePage extends StatelessWidget {
  const ExampleStandalonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scouting Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Access cubit through context if needed
              // context.read<PostsCubit>().refreshPosts();
            },
          ),
        ],
      ),
      // 👇 Use Posts screen without its own app bar
      body: const PostsScreen(),
    );
  }
}

// ============================================================================
// EXAMPLE 5: Tab view integration
// ============================================================================

class ExampleTabView extends StatelessWidget {
  const ExampleTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Content'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.video_library), text: 'Reels'),
              // 👇 Add Posts tab
              Tab(icon: Icon(Icons.list), text: 'Posts'),
              Tab(icon: Icon(Icons.photo), text: 'Photos'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Reels')),
            // 👇 Add Posts screen in tab view
            PostsScreen(),
            Center(child: Text('Photos')),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 6: Post Detail Page (separate screen for single post)
// ============================================================================

class PostDetailPage extends StatelessWidget {
  final int postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    // You can implement this using PostsCubit's loadPostById method
    // This is just a placeholder showing the concept
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: Center(
        child: Text('Post Detail for ID: $postId'),
        // You would use BlocProvider and PostsCubit here
        // See README.md for complete example
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 7: Add to existing home screen
// ============================================================================

class ExampleHomeScreen extends StatelessWidget {
  const ExampleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Your existing widgets
            const ListTile(title: Text('Welcome!')),

            // 👇 Add Posts as a section
            ListTile(
              title: const Text('Browse Posts'),
              subtitle: const Text('View scouting posts from the community'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PostsScreen()),
                );
              },
            ),

            // Your other widgets
            const ListTile(title: Text('Other content')),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// NOTES:
// ============================================================================
//
// 1. Choose the integration method that best fits your app's architecture
// 2. The PostsScreen is a complete, self-contained widget
// 3. It includes its own BlocProvider, so no additional setup needed
// 4. For custom implementations, see README.md
// 5. Official API Documentation: https://scouting.terveys.io/docs
// 6. API does not require authentication (public API)
// 7. Pagination: 10 posts per page
//
// ============================================================================
