// ignore_for_file: directives_ordering

//* Screens

export 'main.dart';
export 'firebase_options.dart';
export 'view/screens/auth/login_screen.dart';
export 'view/screens/auth/register_screen.dart';
export 'view/screens/auth/forget_password_screen.dart';
export 'view/screens/auth/auth_screen.dart';
export 'view/screens/home/home_screen.dart';
export 'view/screens/routing/routing_screen.dart';
export 'view/screens/chat/chats_screen.dart';
export 'view/screens/chat/chat_screen.dart';
export 'view/screens/profile/profile_screen.dart';
export 'view/screens/profile/edit_profile_screen.dart';
export 'view/screens/profile/content_details_screen.dart';
export 'view/screens/profile/searched_profile_screen.dart';
export 'view/screens/error/routing_error_screen.dart';
export 'view/screens/search/search_screen.dart';
export 'view/widgets/private/workout/workouts_showcase.dart';
export 'view/screens/programs/workout_details_screen.dart';
export 'view/screens/programs/programs_screen.dart';
export 'view/screens/programs/program_details_screen.dart';
export 'view/screens/programs/add_exercise_screen.dart';
export 'view/screens/programs/add_workout_screen.dart';

//* Widgets

export 'view/widgets/public/qm_block.dart';
export 'view/widgets/public/qm_text.dart';
export 'view/widgets/public/qm_textfield.dart';
export 'view/widgets/public/qm_dialog.dart';
export 'view/widgets/public/qm_loader.dart';
export 'view/widgets/public/qm_avatar.dart';
export 'view/widgets/public/qm_icon_button.dart';
export 'view/widgets/public/qm_nice_touch.dart';
export 'view/widgets/public/qn_image.dart';
export 'view/widgets/public/qm_shimmer.dart';
export 'view/widgets/public/qm_custom_tab_bar.dart';
export 'view/widgets/private/auth/choose_user_type.dart';
export 'view/widgets/private/auth/forgot_password_text.dart';
export 'view/widgets/private/routing/routing_drawer.dart';
export 'view/widgets/private/workout/big_add_workout_button.dart';
export 'view/widgets/private/workout/small_add_workout_button.dart';
export 'view/widgets/private/exercise/add_exercise_block.dart';
export 'view/widgets/private/exercise/exercise_block.dart';
export 'view/widgets/private/profile/edit_profile_text_field.dart';
export 'view/widgets/private/profile/follow_and_message_button.dart';
export 'view/widgets/private/chat/message_bubble.dart';
export 'view/widgets/private/programs/programs_showcase.dart';
export 'view/widgets/private/programs/add_program.dart';
export 'view/widgets/private/programs/program_block.dart';
export 'view/widgets/private/programs/trainee_sheet.dart';
export 'view/widgets/private/home/indicator.dart';
export 'view/widgets/private/workout/workout_block.dart';
export 'view/screens/profile/add_content_screen.dart';

//* Controllers

export 'controllers/routing/route_controller.dart';
export 'controllers/theme/theme_controller.dart';
export 'controllers/validation/validation_controller.dart';

//* Utils

export 'utils/utils.dart';
export 'utils/auth/register_util.dart';
export 'utils/auth/login_util.dart';
export 'utils/auth/forget_password_util.dart';
export 'utils/auth/logout_util.dart';
export 'utils/workouts/workouts_util.dart';
export 'utils/workouts/exercise_util.dart';
export 'utils/profile/profile_util.dart';
export 'utils/chat/chat_util.dart';
export 'utils/programs/programs_util.dart';
export 'utils/providers/user_provider.dart';
export 'utils/providers/programs_provider.dart';
export 'utils/providers/workouts_provider.dart';
export 'utils/providers/chats_provider.dart';
export 'utils/providers/locale_provider.dart';
export 'utils/providers/analytics_provider.dart';
export 'utils/providers/content_provider.dart';

//* Models

export 'models/user/user_model.dart';
export 'models/workout/exercise_model.dart';
export 'models/workout/workout_model.dart';
export 'models/profile/content_model.dart';
export 'models/chat/chat_model.dart';
export 'models/programs/program_model.dart';
export 'models/enums/user_type.dart';
export 'models/chat/message_model.dart';
export 'models/enums/message_type.dart';
export 'models/enums/exercise_content_type.dart';
export 'models/analytics/general_analytics.dart';
export 'models/extensions/object_extension.dart';

//* Constants

export 'constants/db_paths_constants.dart';
export 'constants/routes_constants.dart';
export 'constants/private_constants.dart';
export 'constants/message_type_constants.dart';
export 'constants/simple_constants.dart';
export 'constants/exercise_showcase_constants.dart';
export 'constants/user_type_constants.dart';
export 'constants/asset_path_constants.dart';
export 'constants/color_constants.dart';
export 'constants/analytics_event_names_constants.dart';

//* Packages

export 'package:firebase_auth/firebase_auth.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:eva_icons_flutter/eva_icons_flutter.dart';
export 'package:image_picker/image_picker.dart';
export 'package:permission_handler/permission_handler.dart';
export 'package:firebase_storage/firebase_storage.dart';
export 'dart:convert';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'generated/l10n.dart';
export 'package:go_router/go_router.dart';
export 'package:responsive_framework/responsive_framework.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:flutter_animate/flutter_animate.dart';
export 'dart:io' hide HeaderValue;
export 'package:flutter/foundation.dart' hide describeIdentity, shortHash;
export 'package:uuid/uuid.dart';
export 'package:slimy_card/slimy_card.dart';
export 'dart:async' hide AsyncError;
export 'package:url_strategy/url_strategy.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage, CachedNetworkImageProvider;
export 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
export 'package:pattern_background/pattern_background.dart';
export 'package:firebase_analytics/firebase_analytics.dart';
export 'package:fl_chart/fl_chart.dart';
export 'package:fade_shimmer/fade_shimmer.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
