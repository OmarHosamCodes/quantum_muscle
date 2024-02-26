// ignore_for_file: directives_ordering

//* Screens

export 'main.dart';
export 'firebase_options.dart';
export 'view/screens/auth/login_screen.dart' show LoginScreen;
export 'view/screens/auth/register_screen.dart' show RegisterScreen;
export 'view/screens/auth/forget_password_screen.dart'
    show ForgetPasswordScreen;
export 'view/screens/auth/auth_screen.dart' show AuthScreen, authPageController;
export 'view/screens/home/home_screen.dart' show HomeScreen;
export 'view/screens/routing/routing_screen.dart' show RoutingScreen;
export 'view/screens/chat/chats_screen.dart' show ChatsScreen;
export 'view/screens/chat/chat_screen.dart' show ChatScreen;
export 'view/screens/profile/profile_screen.dart' show ProfileScreen;
export 'view/screens/profile/edit_profile_screen.dart' show EditProfileScreen;
export 'view/screens/profile/content_details_screen.dart'
    show ContentDetailsScreen;
export 'view/screens/profile/searched_profile_screen.dart'
    show SearchedProfileScreen;
export 'view/screens/error/routing_error_screen.dart' show RoutingErrorScreen;
export 'view/screens/search/search_screen.dart' show SearchScreen;
export 'view/widgets/private/workout/workouts_showcase.dart'
    show WorkoutsShowcase;
export 'view/screens/programs/workout_details_screen.dart'
    show WorkoutDetailsScreen;
export 'view/screens/programs/programs_screen.dart' show ProgramsScreen;
export 'view/screens/programs/program_details_screen.dart'
    show ProgramDetailsScreen;
export 'view/screens/programs/add_exercise_screen.dart' show AddExerciseScreen;
export 'view/screens/programs/add_workout_screen.dart' show AddWorkoutScreen;
export 'view/screens/profile/add_content_screen.dart' show AddContentScreen;

//* Widgets

export 'view/widgets/public/qm_block.dart' show QmBlock;
export 'view/widgets/public/qm_text.dart' show QmSimpleText, QmText;
export 'view/widgets/public/qm_textfield.dart' show QmTextField;
export 'view/widgets/public/qm_dialog.dart' show openQmDialog;
export 'view/widgets/public/qm_loader.dart' show QmLoader;
export 'view/widgets/public/qm_avatar.dart' show QmAvatar;
export 'view/widgets/public/qm_button.dart' show QmButton;
export 'view/widgets/public/qn_image.dart' show QmImage;
export 'view/widgets/public/qm_shimmer.dart' show QmShimmer;
export 'view/widgets/public/qm_custom_tab_bar.dart' show QmCustomTabBar;
export 'view/widgets/public/qm_divider.dart' show QmDivider;
export 'view/widgets/private/auth/choose_user_type.dart' show UserTypeChooser;
export 'view/widgets/private/auth/forgot_password_text.dart'
    show ForgotPasswordTextWidget;
export 'view/widgets/private/routing/routing_drawer.dart' show RoutingDrawer;
export 'view/widgets/private/workout/add_workout_button.dart'
    show AddWorkoutBlock;
export 'view/widgets/private/exercise/add_exercise_block.dart'
    show AddExerciseTile;
export 'view/widgets/private/exercise/exercise_block.dart' show ExerciseBlock;
export 'view/widgets/private/profile/follow_and_message_button.dart'
    show FollowAndMessageButton;
export 'view/widgets/private/chat/message_bubble.dart' show MessageBubble;
export 'view/widgets/private/programs/programs_showcase.dart'
    show ProgramsShowcase;
export 'view/widgets/private/programs/add_program.dart' show AddProgramBlock;
export 'view/widgets/private/programs/program_block.dart' show ProgramBlock;
export 'view/widgets/private/programs/trainee_sheet.dart'
    show openAddTraineeSheet;
export 'view/widgets/private/home/indicator.dart' show Indicator;
export 'view/widgets/private/workout/workout_block.dart' show WorkoutBlock;
export 'view/widgets/private/chat/bubbles.dart' show Bubbles;
//* Controllers

export 'controllers/routing/route_controller.dart' show RoutingController;
export 'controllers/theme/theme_controller.dart' show ThemeController;
export 'controllers/validation/validation_controller.dart'
    show ValidationController;

//* Utils

export 'utils/utils.dart' show Utils;
export 'utils/auth/register_util.dart' show RegisterUtil;
export 'utils/auth/login_util.dart' show LoginUtil;
export 'utils/auth/forget_password_util.dart'
    show ForgetPasswordUtil, forgetPasswordProvider;
export 'utils/auth/logout_util.dart' show LogoutUtil;
export 'utils/workouts/workouts_util.dart' show WorkoutUtil;
export 'utils/workouts/exercise_util.dart' show ExerciseUtil;
export 'utils/profile/profile_util.dart' show ProfileUtil;
export 'utils/chat/chat_util.dart' show ChatUtil;
export 'utils/programs/programs_util.dart' show ProgramUtil;
export 'utils/providers/user_provider.dart' show userProvider, userTypeProvider;
export 'utils/providers/programs_provider.dart'
    show
        programExercisesProvider,
        programTraineesAvatarsProvider,
        programWorkoutsProvider,
        programsProvider;
export 'utils/providers/workouts_provider.dart'
    show
        exercisesProvider,
        publicExercisesProvider,
        publicWorkoutsProvider,
        workoutsProvider;
export 'utils/providers/chats_provider.dart' show chatsProvider;
export 'utils/providers/locale_provider.dart' show localeProvider;
export 'utils/providers/analytics_provider.dart' show generalAnalyticsProvider;
export 'utils/providers/content_provider.dart' show contentProvider;
export 'utils/user/user_util.dart' show UserUtil;
export 'utils/providers/choose_provider.dart' show chooseProvider;
export 'utils/providers/search_provider.dart' show searchStateNotifierProvider;

//* Models

export 'models/user/user_model.dart' show UserModel;
export 'models/workout/exercise_model.dart' show ExerciseModel;
export 'models/workout/workout_model.dart' show WorkoutModel;
export 'models/profile/content_model.dart' show ContentModel;
export 'models/chat/chat_model.dart' show ChatModel;
export 'models/programs/program_model.dart' show ProgramModel;
export 'models/enums/user_type.dart' show UserType;
export 'models/chat/message_model.dart' show MessageModel;
export 'models/enums/message_type.dart' show MessageType;
export 'models/enums/exercise_content_type.dart' show ExerciseContentType;
export 'models/analytics/general_analytics.dart' show GeneralAnalyticsModel;

//* Constants

export 'constants/db_paths_constants.dart' show DBPathsConstants;
export 'constants/routes_constants.dart' show Routes;
export 'constants/private_constants.dart' show PrivateConstants;
export 'constants/message_type_constants.dart' show MessageTypeConstants;
export 'constants/simple_constants.dart' show SimpleConstants;
export 'constants/exercise_content_constants.dart'
    show ExerciseContentConstants;
export 'constants/user_type_constants.dart' show UserTypeConstants;
export 'constants/asset_path_constants.dart' show AssetPathConstants;
export 'constants/color_constants.dart' show ColorConstants;
export 'constants/analytics_event_names_constants.dart'
    show AnalyticsEventNamesConstants;

//* Packages

export 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException, User;
export 'package:flutter/material.dart';
export 'package:flutter/services.dart'
    show
        Clipboard,
        ClipboardData,
        DeviceOrientation,
        PlatformException,
        SystemChrome;
export 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseApp, FirebaseOptions;
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:eva_icons_flutter/eva_icons_flutter.dart' show EvaIcons;
export 'package:image_picker/image_picker.dart'
    show ImagePicker, ImageSource, PickedFile, XFile;
export 'package:permission_handler/permission_handler.dart';
export 'package:firebase_storage/firebase_storage.dart';
export 'dart:convert';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'generated/l10n.dart';
export 'package:go_router/go_router.dart';
export 'package:responsive_framework/responsive_framework.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'dart:io' hide HeaderValue;
export 'package:flutter/foundation.dart' hide describeIdentity, shortHash;
export 'package:slimy_card/slimy_card.dart';
export 'dart:async' hide AsyncError;
export 'package:url_strategy/url_strategy.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage, CachedNetworkImageProvider;
export 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
export 'package:pattern_background/pattern_background.dart' show DotPainter;
export 'package:firebase_analytics/firebase_analytics.dart';
export 'package:fl_chart/fl_chart.dart';
export 'package:fade_shimmer/fade_shimmer.dart';
export 'package:uuid/uuid.dart' show Uuid;
export 'package:marquee_text/marquee_text.dart' show MarqueeText;
export 'package:hive_flutter/hive_flutter.dart';
