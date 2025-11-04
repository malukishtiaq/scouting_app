import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/settings_cubit.dart';
import '../../domain/entities/user_preferences_entity.dart';
import '../../../../core/services/navigation_style_manager.dart';
import '../../../../core/navigation/nav.dart';
import '../../../account/presentation/screen/login/login_screen.dart';
import 'theme_security_settings_screen.dart';
import 'notification_settings_screen.dart';
import 'privacy_settings_screen.dart';
import 'help_support_screen.dart';
import 'features/saved_posts_screen.dart';
import 'features/popular_posts_screen.dart';
import 'features/find_friends_screen.dart';
import 'features/movies_screen.dart';
import 'features/games_screen.dart';
import 'features/advertising_screen.dart';
import '../../../../core/providers/session_data.dart';
import '../../../../di/service_locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'my_profile_screen.dart';

/// Main settings screen matching Xamarin design
class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final NavigationStyleManager _styleManager = NavigationStyleManager.instance;

  @override
  void initState() {
    super.initState();
    // Load preferences when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<SettingsCubit>().loadPreferences();
        _loadNavigationStyle();
      }
    });
  }

  Future<void> _loadNavigationStyle() async {
    await _styleManager.getNavigationStyle();
    if (mounted) {
      setState(() {
        // Navigation style updated
      });
    }
  }

  @override
  void dispose() {
    // Reset status bar when leaving settings screen
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Configure status bar for settings screen
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Settings Title Header
            _buildTitleHeader(),
            // Main Content
            Expanded(
              child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  if (state is SettingsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SettingsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text('Error: ${state.message}'),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<SettingsCubit>().loadPreferences(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SettingsLoaded) {
                    return _buildSettingsContent(state.preferences);
                  }

                  return const Center(child: Text('No settings loaded'));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsContent(UserPreferencesEntity preferences) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Card
          _buildProfileCard(),

          const SizedBox(height: 16),

          // Main Features Grid (6 rows × 4 columns)
          _buildFeaturesGrid(),

          const SizedBox(height: 24),

          // Pro Account Button
          _buildProAccountButton(),

          const SizedBox(height: 24),

          // Other Settings Section
          const Text(
            'Other Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          // Settings List
          _buildSettingsList(),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid() {
    final features = [
      // Row 1
      {
        'icon': Icons.message_outlined,
        'title': 'Messages',
        'color': Colors.yellow
      },
      {
        'icon': Icons.people_outline,
        'title': 'Following',
        'color': Colors.purple
      },
      {
        'icon': Icons.touch_app_outlined,
        'title': 'Pokes',
        'color': Colors.pink
      },
      {
        'icon': Icons.photo_library_outlined,
        'title': 'Albums',
        'color': Colors.blue
      },

      // Row 2
      {'icon': Icons.image_outlined, 'title': 'My Images', 'color': Colors.red},
      {
        'icon': Icons.video_library_outlined,
        'title': 'My Videos',
        'color': Colors.orange
      },
      {
        'icon': Icons.bookmark_outline,
        'title': 'Saved Posts',
        'color': Colors.blue
      },
      {'icon': Icons.group_outlined, 'title': 'Groups', 'color': Colors.purple},

      // Row 3
      {'icon': Icons.flag_outlined, 'title': 'Pages', 'color': Colors.pink},
      {
        'icon': Icons.article_outlined,
        'title': 'Articles',
        'color': Colors.orange
      },
      {
        'icon': Icons.shopping_cart_outlined,
        'title': 'Market Place',
        'color': Colors.purple
      },
      {
        'icon': Icons.rocket_launch_outlined,
        'title': 'Boosted',
        'color': Colors.blue
      },

      // Row 4
      {
        'icon': Icons.local_fire_department_outlined,
        'title': 'Popular Posts',
        'color': Colors.purple
      },
      {'icon': Icons.event_outlined, 'title': 'Events', 'color': Colors.blue},
      {
        'icon': Icons.person_search_outlined,
        'title': 'Find Friends',
        'color': Colors.purple
      },
      {'icon': Icons.percent_outlined, 'title': 'Offers', 'color': Colors.grey},

      // Row 5
      {'icon': Icons.movie_outlined, 'title': 'Movies', 'color': Colors.yellow},
      {'icon': Icons.work_outline, 'title': 'Jobs', 'color': Colors.green},
      {
        'icon': Icons.lightbulb_outline,
        'title': 'Common Things',
        'color': Colors.pink
      },
      {
        'icon': Icons.history_outlined,
        'title': 'Memories',
        'color': Colors.orange
      },

      // Row 6
      {
        'icon': Icons.account_balance_wallet_outlined,
        'title': 'Funding',
        'color': Colors.blue
      },
      {
        'icon': Icons.sports_esports_outlined,
        'title': 'Games',
        'color': Colors.red
      },
      {
        'icon': Icons.videocam_outlined,
        'title': 'Live Videos',
        'color': Colors.pink
      },
      {
        'icon': Icons.campaign_outlined,
        'title': 'Advertising',
        'color': Colors.purple
      },

      // Row 7 - Referral & Ads Demo
      {
        'icon': Icons.share_outlined,
        'title': 'Referral Program',
        'color': Colors.green
      },
      {'icon': Icons.ad_units, 'title': 'Ads Demo', 'color': Colors.orange},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return _buildFeatureItem(
          icon: feature['icon'] as IconData,
          title: feature['title'] as String,
          color: feature['color'] as Color,
        );
      },
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return InkWell(
      onTap: () => _onFeatureTap(title),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProAccountButton() {
    return InkWell(
      onTap: () => _showComingSoon('Go Pro Account'),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            SizedBox(width: 8),
            Text(
              'Go Pro Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsItem(
            icon: Icons.person_outline,
            title: 'General Account',
            onTap: () => _navigateToGeneralAccount(),
          ),
          _buildDivider(),
          _buildSettingsItem(
            icon: Icons.lock_outline,
            title: 'Privacy',
            onTap: () => _navigateToPrivacy(),
          ),
          _buildDivider(),
          _buildSettingsItem(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () => _navigateToNotifications(),
          ),
          _buildDivider(),
          _buildSettingsItem(
            icon: Icons.link,
            title: 'Invitation Links',
            onTap: () => _showComingSoon('Invitation Links'),
          ),
          _buildDivider(),
          _buildSettingsItem(
            icon: Icons.info_outline,
            title: 'My Information',
            onTap: () => _showComingSoon('My Information'),
          ),
          _buildDivider(),
          _buildDivider(),
          _buildSettingsItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () => _navigateToHelpSupport(),
          ),
          _buildDivider(),
          _buildSettingsItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => _showLogoutDialog(),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : Colors.red,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isDestructive ? Colors.red : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.only(left: 56),
      color: Colors.grey.withOpacity(0.2),
    );
  }

  // Feature tap handler - Maps to actual Xamarin functionality
  void _onFeatureTap(String featureName) {
    switch (featureName) {
      case 'My Images':
        _navigateToMyImages();
        break;

      case 'Saved Posts':
        _navigateToSavedPosts();
        break;
      case 'Popular Posts':
        _navigateToPopularPosts();
        break;
      case 'Find Friends':
        _navigateToFindFriends();
        break;
      case 'Movies':
        _navigateToMovies();
        break;
      case 'Games':
        _navigateToGames();
        break;
      case 'Advertising':
        _navigateToAdvertising();
        break;

      case 'Ads Demo':
        _navigateToAdsDemo();
        break;
      default:
        _showComingSoon(featureName);
        break;
    }
  }

  void _navigateToMyImages() {
    Nav.to(
      '/my-images',
      arguments: {},
    );
  }

  void _navigateToSavedPosts() {
    Nav.to(
      SavedPostsScreen.routeName,
      arguments: SavedPostsScreenParam(),
    );
  }

  void _navigateToPopularPosts() {
    Nav.to(
      PopularPostsScreen.routeName,
      arguments: PopularPostsScreenParam(),
    );
  }

  void _navigateToFindFriends() {
    Nav.to(
      FindFriendsScreen.routeName,
      arguments: FindFriendsScreenParam(),
    );
  }

  void _navigateToMovies() {
    Nav.to(
      MoviesScreen.routeName,
      arguments: MoviesScreenParam(),
    );
  }

  void _navigateToGames() {
    Nav.to(
      GamesScreen.routeName,
      arguments: GamesScreenParam(),
    );
  }

  void _navigateToAdvertising() {
    Nav.to(
      AdvertisingScreen.routeName,
      arguments: AdvertisingScreenParam(),
    );
  }

  void _navigateToAdsDemo() {
    // Nav.to('/ads_demo', arguments: AdsDemoScreenParam());
  }

  // Navigation methods for settings
  void _navigateToGeneralAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: this.context.read<SettingsCubit>(),
          child: const ThemeSecuritySettingsScreen(),
        ),
      ),
    );
  }

  void _navigateToPrivacy() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: this.context.read<SettingsCubit>(),
          child: const PrivacySettingsScreen(),
        ),
      ),
    );
  }

  void _navigateToNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: this.context.read<SettingsCubit>(),
          child: const NotificationSettingsScreen(),
        ),
      ),
    );
  }

  void _navigateToHelpSupport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HelpSupportScreen(),
      ),
    );
  }

  void _showComingSoon(String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coming Soon'),
        content: Text('$feature feature is coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performLogout();
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performLogout() async {
    try {
      // Navigate to login screen
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(
              param: LoginScreenParam(from: LoginFrom.mainScreen),
            ),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: $e')),
        );
      }
    }
  }

  Widget _buildTitleHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.settings,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
          const SizedBox(width: 12),
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    // Get user info from session data
    final sessionData = getIt<SessionData>();
    final userName = sessionData.userProfile?.fullName ?? 'User';
    final userAvatar = sessionData.userProfile?.avatar ?? '';

    return InkWell(
      onTap: () {
        Nav.to(MyProfileScreen.routeName, arguments: MyProfileScreenParam());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 28,
              backgroundImage: userAvatar.isNotEmpty
                  ? CachedNetworkImageProvider(userAvatar)
                  : null,
              child: userAvatar.isEmpty
                  ? const Icon(Icons.person, size: 32)
                  : null,
            ),
            const SizedBox(width: 12),
            // Name and View Profile text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'View Profile',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue[600],
                    ),
                  ),
                ],
              ),
            ),
            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}
