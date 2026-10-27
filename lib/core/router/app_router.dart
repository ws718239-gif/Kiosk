import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/admin_settings/presentation/screens/admin_settings_screen.dart';
import '../../features/host_directory/presentation/screens/host_directory_screen.dart';
import '../../features/host_directory/domain/models/host_model.dart';
import '../../features/visitor_checkin/presentation/screens/visitor_checkin_screen.dart';
import '../../features/visitor_badge/presentation/screens/visitor_badge_screen.dart';
import '../../features/visitor_checkin/domain/models/visitor_model.dart';
import '../../features/today_visitors/presentation/screens/today_visitors_screen.dart';
import '../i18n/app_strings.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const KioskDashboardScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0.0, 0.03),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                child: child,
              ),
            );
          },
        ),
      ),
      GoRoute(
        path: '/admin',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AdminSettingsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0.0, 0.03),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                child: child,
              ),
            );
          },
        ),
      ),
      GoRoute(
        path: '/hosts',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HostDirectoryScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0.0, 0.03),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                child: child,
              ),
            );
          },
        ),
      ),
      GoRoute(
        path: '/checkin',
        pageBuilder: (context, state) {
          final extra = state.extra;
          if (extra is! HostModel) {
            return MaterialPage<void>(
              key: state.pageKey,
              child: Scaffold(
                body: Center(child: Text('Something went wrong'.tr(context))),
              ),
            );
          }
          final host = extra;
          return CustomTransitionPage(
            key: state.pageKey,
            child: VisitorCheckInScreen(host: host),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                    child: SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0.0, 0.03),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                      child: child,
                    ),
                  );
                },
          );
        },
      ),
      GoRoute(
        path: '/badge',
        pageBuilder: (context, state) {
          final extra = state.extra;
          if (extra is! VisitorModel) {
            return MaterialPage<void>(
              key: state.pageKey,
              child: Scaffold(
                body: Center(child: Text('Something went wrong'.tr(context))),
              ),
            );
          }
          final visitor = extra;
          return CustomTransitionPage(
            key: state.pageKey,
            child: VisitorBadgeScreen(visitor: visitor),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                    child: SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0.0, 0.03),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                      child: child,
                    ),
                  );
                },
          );
        },
      ),
      GoRoute(
        path: '/today_visitors',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const TodayVisitorsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0.0, 0.03),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                child: child,
              ),
            );
          },
        ),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),
  );
});

class KioskDashboardScreen extends StatelessWidget {
  const KioskDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Kiosk',
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings_outlined, size: 48.sp),
              constraints: BoxConstraints(minWidth: 64.w, minHeight: 64.h),
              padding: EdgeInsets.all(8.r),
              tooltip: 'Admin Settings'.tr(context),
              onPressed: () => context.push('/admin'),
            ),
            SizedBox(width: 8.w),
          ],
          bottom: TabBar(
            labelColor: colorScheme.primary,
            unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
            indicatorColor: colorScheme.primary,
            indicatorWeight: 3.h,
            labelStyle: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.normal,
            ),
            tabs: [
              Tab(
                icon: const Icon(Icons.how_to_reg_outlined),
                text: 'Visitor Check-in'.tr(context),
              ),
              Tab(
                icon: const Icon(Icons.list_alt_outlined),
                text: "Today's Visitors".tr(context),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Visitor Check-in Card View
            SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 650.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16.h),
                      // Hero Card
                      Card(
                        elevation: 4,
                        shadowColor: colorScheme.primary.withValues(alpha: 0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(32.w),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20.r),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.verified_user_outlined,
                                  size: 56.sp,
                                  color: colorScheme.primary,
                                ),
                              ),
                              SizedBox(height: 32.h),
                              SizedBox(
                                width: double.infinity,
                                height: 56.h,
                                child: ElevatedButton.icon(
                                  onPressed: () => context.push('/hosts'),
                                  icon: Icon(Icons.arrow_forward, size: 22.sp),
                                  label: Text(
                                    'Start Visitor Check-in'.tr(context),
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.primary,
                                    foregroundColor: colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    elevation: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Tab 2: Today's Visitors Card View
            SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 650.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16.h),
                      Card(
                        elevation: 4,
                        shadowColor: colorScheme.primary.withValues(alpha: 0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(32.w),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20.r),
                                decoration: BoxDecoration(
                                  color: colorScheme.secondary.withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.people_alt_outlined,
                                  size: 56.sp,
                                  color: colorScheme.secondary,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "Today's Visitor Logs".tr(context),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(height: 32.h),
                              SizedBox(
                                width: double.infinity,
                                height: 56.h,
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      context.push('/today_visitors'),
                                  icon: Icon(Icons.list_alt, size: 22.sp),
                                  label: Text(
                                    "Open Today's Visitors Log".tr(context),
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.secondary,
                                    foregroundColor: colorScheme.onSecondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    elevation: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
