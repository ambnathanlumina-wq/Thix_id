import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thix_id/auth/auth_controller.dart';
import 'package:thix_id/models/event_item.dart';

// Pages
import 'presentation/home/home_page.dart';
import 'presentation/auth/login_page.dart';
import 'presentation/auth/personal_registration_page.dart';
import 'presentation/auth/enterprise_registration_page.dart';
import 'presentation/payment/payment_gateway_page.dart';
import 'presentation/payment/activation_receipt_page.dart';
import 'presentation/profile/public_profile_page.dart';
import 'presentation/dashboard/user_dashboard_page.dart';
import 'presentation/enterprise/enterprise_dashboard_page.dart';
import 'presentation/chat/thix_chat_page.dart';
import 'presentation/vault/document_vault_page.dart';
import 'presentation/settings/settings_page.dart';
import 'presentation/network/network_page.dart';
import 'presentation/jobs/jobs_page.dart';
import 'presentation/jobs/job_apply_page.dart';
import 'presentation/jobs/job_details_page.dart';
import 'presentation/jobs/job_dashboard_page.dart';
import 'presentation/recruiter/recruiter_portal_page.dart';
import 'presentation/opportunities/opportunities_page.dart';
import 'presentation/opportunities/opportunity_apply_page.dart';
import 'presentation/opportunities/opportunity_details_page.dart';
import 'presentation/events/events_page.dart';
import 'presentation/events/event_details_page.dart';
import 'presentation/events/event_register_page.dart';
import 'presentation/events/event_ticket_page.dart';
import 'presentation/events/user_event_dashboard_page.dart';
import 'presentation/education/education_page.dart';
import 'presentation/training/training_home_page.dart';
import 'presentation/training/training_details_page.dart';
import 'presentation/training/learning_dashboard_page.dart';
import 'presentation/training/lesson_player_page.dart';
import 'presentation/admin/admin_page.dart';
import 'presentation/thix_market/thix_market_page.dart';
import 'presentation/thix_sante/thix_sante_page.dart';
import 'presentation/thix_reservation/thix_reservation_page.dart';
import 'presentation/thix_money/thix_money_page.dart';
import 'presentation/thix_media/thix_media_page.dart';
import 'presentation/admin/pages/admin_media_page.dart';

class NoTransitionPage<T> extends Page<T> {
  final Widget child;
  const NoTransitionPage({required this.child, super.key});

  @override
  Route<T> createRoute(BuildContext context) {
    return MaterialPageRoute(builder: (context) => child, settings: this);
  }
}

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String personalReg = '/personal-reg';
  static const String enterpriseReg = '/enterprise-reg';
  static const String paymentGateway = '/payment-gateway';
  static const String activationReceipt = '/activation-receipt';
  static const String publicProfile = '/profile/:userId';
  static const String userDashboard = '/user-dashboard';
  static const String enterpriseDashboard = '/enterprise-dashboard';
  static const String chat = '/chat';
  static const String vault = '/vault';
  static const String settings = '/settings';
  static const String network = '/network';
  static const String jobs = '/jobs';
  static const String jobDetails = '/jobs/:jobId';
  static const String jobApply = '/jobs/:jobId/apply';
  static const String jobDashboard = '/job-dashboard';
  static const String recruiterPortal = '/recruiter-portal';
  static const String opportunities = '/opportunities';
  static const String opportunityDetails = '/opportunities/:opportunityId';
  static const String opportunityApply = '/opportunities/:opportunityId/apply';
  static const String events = '/events';
  static const String eventDetails = '/events/:eventId';
  static const String eventRegister = '/events/:eventId/register';
  static const String eventTicket = '/events/:eventId/ticket/:registrationId';
  static const String userEventDashboard = '/events/me';
  static const String education = '/education';
  static const String trainingHome = '/training';
  static const String trainingDetails = '/training/:trainingId';
  static const String learningDashboard = '/learning-dashboard';
  static const String lessonPlayer = '/lesson/:lessonId';
  static const String admin = '/admin';
  static const String adminMedia = '/admin/media';
  static const String thixMarket = '/thix-market';
  static const String thixSante = '/thix-sante';
  static const String thixReservation = '/thix-reservation';
  static const String thixMoney = '/thix-money';
  static const String thixMedia = '/thix-media';
}

class AppRouter {
  static GoRouter create(AuthController auth) {
    return GoRouter(
      initialLocation: AppRoutes.home,
      refreshListenable: auth,
      redirect: (context, state) {
        final isLoggedIn = auth.isAuthenticated;
        final location = state.matchedLocation;

        final isAuthPage = location == AppRoutes.login ||
            location == AppRoutes.personalReg ||
            location == AppRoutes.enterpriseReg;

        if (!isLoggedIn && !isAuthPage) {
          return AppRoutes.login;
        }
        if (isLoggedIn && isAuthPage) {
          return AppRoutes.userDashboard;
        }
        return null;
      },
      routes: [
        // ==================== AUTH ROUTES ====================
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => const NoTransitionPage(child: HomePage()),
        ),
        GoRoute(
          path: AppRoutes.login,
          pageBuilder: (context, state) => const NoTransitionPage(child: LoginPage()),
        ),
        GoRoute(
          path: AppRoutes.personalReg,
          pageBuilder: (context, state) => const NoTransitionPage(child: PersonalRegistrationPage()),
        ),
        GoRoute(
          path: AppRoutes.enterpriseReg,
          pageBuilder: (context, state) => const NoTransitionPage(child: EnterpriseRegistrationPage()),
        ),

        // ==================== PAYMENT ROUTES ====================
        GoRoute(
          path: AppRoutes.paymentGateway,
          pageBuilder: (context, state) => const NoTransitionPage(child: PaymentGatewayPage()),
        ),
        GoRoute(
          path: AppRoutes.activationReceipt,
          pageBuilder: (context, state) => const NoTransitionPage(child: ActivationReceiptPage()),
        ),

        // ==================== DASHBOARD ROUTES ====================
        GoRoute(
          path: AppRoutes.userDashboard,
          pageBuilder: (context, state) => const NoTransitionPage(child: UserDashboardPage()),
        ),
        GoRoute(
          path: AppRoutes.enterpriseDashboard,
          pageBuilder: (context, state) => const NoTransitionPage(child: EnterpriseDashboardPage()),
        ),

        // ==================== PROFILE ROUTES ====================
        GoRoute(
          path: AppRoutes.publicProfile,
          pageBuilder: (context, state) {
            final userId = state.pathParameters['userId'] ?? '';
            return NoTransitionPage(child: PublicProfilePage(userId: userId));
          },
        ),

        // ==================== CORE FEATURE ROUTES ====================
        GoRoute(
          path: AppRoutes.chat,
          pageBuilder: (context, state) => const NoTransitionPage(child: ThixChatPage()),
        ),
        GoRoute(
          path: AppRoutes.vault,
          pageBuilder: (context, state) => const NoTransitionPage(child: DocumentVaultPage()),
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (context, state) => const NoTransitionPage(child: SettingsPage()),
        ),
        GoRoute(
          path: AppRoutes.network,
          pageBuilder: (context, state) => const NoTransitionPage(child: NetworkPage()),
        ),

        // ==================== JOBS ROUTES ====================
        GoRoute(
          path: AppRoutes.jobs,
          pageBuilder: (context, state) => const NoTransitionPage(child: JobsPage()),
        ),
        GoRoute(
          path: AppRoutes.jobDetails,
          pageBuilder: (context, state) {
            final jobId = state.pathParameters['jobId'] ?? '';
            return NoTransitionPage(child: JobDetailsPage(jobId: jobId));
          },
        ),
        GoRoute(
          path: AppRoutes.jobApply,
          pageBuilder: (context, state) {
            final jobId = state.pathParameters['jobId'] ?? '';
            return NoTransitionPage(child: JobApplyPage(jobId: jobId));
          },
        ),
        GoRoute(
          path: AppRoutes.jobDashboard,
          pageBuilder: (context, state) => const NoTransitionPage(child: JobDashboardPage()),
        ),
        GoRoute(
          path: AppRoutes.recruiterPortal,
          pageBuilder: (context, state) => const NoTransitionPage(child: RecruiterPortalPage()),
        ),

        // ==================== OPPORTUNITIES ROUTES ====================
        GoRoute(
          path: AppRoutes.opportunities,
          pageBuilder: (context, state) => const NoTransitionPage(child: OpportunitiesPage()),
        ),
        GoRoute(
          path: AppRoutes.opportunityDetails,
          pageBuilder: (context, state) {
            final opportunityId = state.pathParameters['opportunityId'] ?? '';
            return NoTransitionPage(child: OpportunityDetailsPage(opportunityId: opportunityId));
          },
        ),
        GoRoute(
          path: AppRoutes.opportunityApply,
          pageBuilder: (context, state) {
            final opportunityId = state.pathParameters['opportunityId'] ?? '';
            return NoTransitionPage(child: OpportunityApplyPage(opportunityId: opportunityId));
          },
        ),

        // ==================== EVENTS ROUTES ====================
        GoRoute(
          path: AppRoutes.events,
          pageBuilder: (context, state) => const NoTransitionPage(child: EventsPage()),
        ),
        GoRoute(
          path: AppRoutes.eventDetails,
          pageBuilder: (context, state) {
            final eventId = state.pathParameters['eventId'] ?? '';
            return NoTransitionPage(child: EventDetailsPage(eventId: eventId));
          },
        ),
        GoRoute(
          path: AppRoutes.eventRegister,
          pageBuilder: (context, state) {
            final eventId = state.pathParameters['eventId'] ?? '';
            return NoTransitionPage(
              child: EventRegisterPage(
                event: EventItem.placeholder(id: eventId),
              ),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.eventTicket,
          pageBuilder: (context, state) {
            final eventId = state.pathParameters['eventId'] ?? '';
            final registrationId = state.pathParameters['registrationId'] ?? '';
            return NoTransitionPage(
              child: EventTicketPage(eventId: eventId, registrationId: registrationId),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.userEventDashboard,
          pageBuilder: (context, state) => const NoTransitionPage(child: UserEventDashboardPage()),
        ),

        // ==================== EDUCATION & TRAINING ROUTES ====================
        GoRoute(
          path: AppRoutes.education,
          pageBuilder: (context, state) => const NoTransitionPage(child: EducationPage()),
        ),
        GoRoute(
          path: AppRoutes.trainingHome,
          pageBuilder: (context, state) => const NoTransitionPage(child: TrainingHomePage()),
        ),
        GoRoute(
          path: AppRoutes.trainingDetails,
          pageBuilder: (context, state) {
            final trainingId = state.pathParameters['trainingId'] ?? '';
            return NoTransitionPage(child: TrainingDetailsPage(trainingId: trainingId));
          },
        ),
        GoRoute(
          path: AppRoutes.learningDashboard,
          pageBuilder: (context, state) => const NoTransitionPage(child: LearningDashboardPage()),
        ),
        GoRoute(
          path: AppRoutes.lessonPlayer,
          pageBuilder: (context, state) {
            final lessonId = state.pathParameters['lessonId'] ?? '';
            return NoTransitionPage(child: LessonPlayerPage(lessonId: lessonId));
          },
        ),

        // ==================== ADMIN ROUTES ====================
        GoRoute(
          path: AppRoutes.admin,
          pageBuilder: (context, state) => const NoTransitionPage(child: AdminPage()),
        ),
        GoRoute(
          path: AppRoutes.adminMedia,
          pageBuilder: (context, state) => const NoTransitionPage(child: AdminMediaPage()),
        ),

        // ==================== THIX SERVICES ROUTES ====================
        GoRoute(
          path: AppRoutes.thixMarket,
          pageBuilder: (context, state) => const NoTransitionPage(child: ThixMarketPage()),
        ),
        GoRoute(
          path: AppRoutes.thixSante,
          pageBuilder: (context, state) => const NoTransitionPage(child: ThixSantePage()),
        ),
        GoRoute(
          path: AppRoutes.thixReservation,
          pageBuilder: (context, state) => const NoTransitionPage(child: ThixReservationPage()),
        ),
        GoRoute(
          path: AppRoutes.thixMoney,
          pageBuilder: (context, state) => const NoTransitionPage(child: ThixMoneyPage()),
        ),
        GoRoute(
          path: AppRoutes.thixMedia,
          pageBuilder: (context, state) => const NoTransitionPage(child: ThixMediaPage()),
        ),
      ],
    );
  }
}
