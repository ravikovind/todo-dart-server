import 'package:client/features/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:client/core/route/routes.dart';
import 'package:client/core/utils/constants.dart';
import 'package:client/debug/navigation_observer.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:string_contains/string_contains.dart';

class AppRouter {
  AppRouter({
    required this.observer,
    required this.user,
  }) {
    _router = GoRouter(
      initialLocation: kInitialRoute,
      observers: [observer],
      errorBuilder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      height: MediaQuery.of(context).size.width * 0.5,
                      child: SvgPicture.asset(
                        'assets/svgs/not_found.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'An unknown error occurred.\n404 Not Available(Sorry, the page you are looking for no longer exists!).',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),

                    /// Go back button
                    OutlinedButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_ios),
                      label: const Text(
                        'Go Back',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      redirect: (context, state) {
        final location = state.matchedLocation;
        final accessToken = HydratedBloc.storage.read(kToken)?.toString();
        final authenticated =
            !user.state.id.isNullOrEmpty && !accessToken.isNullOrEmpty;
        final authRoute = location.startsWith(kAuthRoute);
        if (location.isEmpty) {
          return kInitialRoute;
        } else if (authenticated && authRoute) {
          return kInitialRoute;
        } else if (!authenticated && !authRoute) {
          return kAuthRoute;
        }
        return null;
      },
      routes: <RouteBase>[],
    );
  }

  late final GoRouter _router;
  final NavigationObserver observer;
  final UserBloc user;
  GoRouter get router => _router;
}
