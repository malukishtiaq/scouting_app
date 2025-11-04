import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../di/service_locator.dart';
import '../services/deep_link_handler.dart';
import '../../feature/account/presentation/screen/forgot_password/forgot_password_screen.dart';
import '../../feature/account/presentation/screen/login/login_screen.dart';
import '../../feature/account/presentation/screen/register/register_screen.dart';
import '../../feature/account/presentation/screen/welcome/welcome_screen.dart';
import '../../feature/splash/presentation/screen/splash_screen.dart';
import '../../feature/reels/presentation/screen/reels_screen.dart';
import '../../feature/reels/presentation/cubit/reels_cubit.dart';
import '../../feature/posts/presentation/screen/posts_screen.dart';
import '../../feature/posts/presentation/cubit/posts_cubit.dart';
import '../../feature/home/presentation/screen/home_tabbed_screen.dart';
import '../../feature/profile/presentation/screen/user_profile_screen.dart';
import '../../feature/settings/presentation/screen/my_profile_screen.dart';
import '../../feature/settings/presentation/screen/features/saved_posts_screen.dart';
import '../../feature/settings/presentation/screen/features/popular_posts_screen.dart';
import '../../feature/settings/presentation/screen/features/find_friends_screen.dart';
import '../../feature/settings/presentation/screen/features/movies_screen.dart';
import '../../feature/settings/presentation/screen/features/games_screen.dart';
import '../../feature/settings/presentation/screen/features/live_videos_screen.dart';
import '../../feature/settings/presentation/screen/features/advertising_screen.dart';

import '../constants/enums/route_type.dart';
import '../ui/screens/base_screen.dart';
import 'animations/animated_route.dart';
import 'animations/fade_route.dart';
import 'navigation_service.dart';

@lazySingleton
class NavigationRoute {
  Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // limit access on pages
    // final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.routeName:
        return FadeRoute(
          page: SplashScreen(param: SplashScreenParam()),
          settings: settings,
        );

      case WelcomeScreen.routeName:
        return FadeRoute(
          page: const WelcomeScreen(),
          settings: settings,
        );

      case LoginScreen.routeName:
        return FadeRoute(
          page: const LoginScreen(param: LoginScreenParam()),
          settings: settings,
        );
      case RegisterScreen.routeName:
        // Handle both RegisterScreenParam and Map arguments
        String? referralCode;

        if (settings.arguments is RegisterScreenParam) {
          // If arguments is already RegisterScreenParam, use it
          final param = settings.arguments as RegisterScreenParam;
          referralCode = param.referralCode;
        } else if (settings.arguments is Map<String, dynamic>) {
          // If arguments is a Map, extract referral code
          final args = settings.arguments as Map<String, dynamic>?;
          referralCode = args?['referralCode'] ?? args?['ref'];
        }

        // Fall back to deep link handler if no referral code
        referralCode ??= DeepLinkHandler.getPendingReferralCode();

        return FadeRoute(
          page: RegisterScreen(
            param: RegisterScreenParam(
              referralCode: referralCode,
            ),
          ),
          settings: settings,
        );
      case ForgotPasswordScreen.routeName:
        return FadeRoute(
          page: const ForgotPasswordScreen(param: ForgotPasswordParam()),
          settings: settings,
        );

      case ReelsScreen.routeName:
        return FadeRoute(
          page: BlocProvider(
            create: (context) => getIt<ReelsCubit>(),
            child: const ReelsScreen(),
          ),
          settings: settings,
        );

      case PostsScreen.routeName:
        return FadeRoute(
          page: BlocProvider(
            create: (context) => getIt<PostsCubit>()..loadPosts(),
            child: const PostsScreen(),
          ),
          settings: settings,
        );

      case HomeTabbedScreen.routeName:
        return FadeRoute(
          page: BlocProvider(
            create: (context) => getIt<PostsCubit>()..loadPosts(),
            child: HomeTabbedScreen(param: HomeTabbedScreenParam()),
          ),
          settings: settings,
        );

      case UserProfileScreenModern.routeName:
        final args = settings.arguments as Map<String, dynamic>?;
        return FadeRoute(
          page: UserProfileScreenModern(
            userId: args?['userId'] ?? '',
            username: args?['username'],
          ),
          settings: settings,
        );

      case MyProfileScreen.routeName:
        return FadeRoute(
          page: MyProfileScreen(param: MyProfileScreenParam()),
          settings: settings,
        );

      case SavedPostsScreen.routeName:
        return FadeRoute(
          page: SavedPostsScreen(param: SavedPostsScreenParam()),
          settings: settings,
        );

      case PopularPostsScreen.routeName:
        return FadeRoute(
          page: PopularPostsScreen(param: PopularPostsScreenParam()),
          settings: settings,
        );

      case FindFriendsScreen.routeName:
        return FadeRoute(
          page: FindFriendsScreen(param: FindFriendsScreenParam()),
          settings: settings,
        );
      case MoviesScreen.routeName:
        return FadeRoute(
          page: MoviesScreen(param: MoviesScreenParam()),
          settings: settings,
        );

      case GamesScreen.routeName:
        return FadeRoute(
          page: GamesScreen(param: GamesScreenParam()),
          settings: settings,
        );
      case LiveVideosScreen.routeName:
        return FadeRoute(
          page: LiveVideosScreen(param: LiveVideosScreenParam()),
          settings: settings,
        );

      case AdvertisingScreen.routeName:
        return FadeRoute(
          page: AdvertisingScreen(param: AdvertisingScreenParam()),
          settings: settings,
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  Route _getRoute<ParamType>({
    required RouteSettings settings,
    required BaseScreen Function(
      ParamType param,
    ) createScreen,
    RouteType? routeType,
  }) {
    try {
      final args = settings.arguments;
      if (args != null && args is ParamType) {
        final type = routeType ??
            RouteType
                .FADE; //(Platform.isIOS ? RouteType.SWIPABLE : RouteType.FADE);
        switch (type) {
          case RouteType.FADE:
            return FadeRoute(
              page: createScreen(
                args as ParamType,
              ),
              settings: settings,
            );
          case RouteType.ANIMATED:
            return AnimatedRoute(
              page: createScreen(
                args as ParamType,
              ),
              settings: settings,
            );
          // case RouteType.SWIPABLE:
          //   return SwipeablePageRoute(
          //     transitionDuration: const Duration(milliseconds: 500),
          //     canOnlySwipeFromEdge: true,
          //     builder: (context) {
          //       return createScreen(args as ParamType);
          //     },
          //     settings: settings,
          //   );
        }
      }
    } catch (e) {
      return _errorRoute();
    }

    return _errorRoute();
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          backgroundColor: Theme.of(
                  getIt<NavigationService>().getNavigationKey.currentContext!)
              .scaffoldBackgroundColor,
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ROUTE ERROR CHECK THE ROUTE GENERATOR'),
          ),
        );
      },
    );
  }
}
