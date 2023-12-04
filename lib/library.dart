// ignore_for_file: depend_on_referenced_packages

library library;

//* Screens

export 'main.dart';
export 'firebase_options.dart';
export 'view/screens/auth/login_screen.dart';
export 'view/screens/auth/register_screen.dart';
export 'view/screens/auth/forgot_password_screen.dart';
export 'view/screens/home/home_screen.dart';
export 'view/screens/routing/routing_screen.dart';
export 'view/screens/chat/chat_screen.dart';
export 'view/screens/profile/profile_screen.dart';
export 'view/screens/home/workoutDetails/workout_details_screen.dart';
export 'view/screens/auth/auth_screen.dart';
export 'view/screens/error/routing_error_screen.dart';

//* Widgets

export 'view/widgets/qm_block.dart';
export 'view/widgets/qm_text.dart';
export 'view/widgets/qm_textfield.dart';
export 'view/widgets/qm_dialog.dart';
export 'view/widgets/qm_avatar.dart';
export 'view/widgets/private/choose_user_type.dart';
export 'view/widgets/private/forgot_password_text.dart';
export 'view/widgets/private/home_search_bar.dart';
export 'view/widgets/private/Routing_drawer.dart';
export 'view/widgets/private/workoutButtons/big_add_workout_button.dart';
export 'view/widgets/private/workoutButtons/small_add_workout_button.dart';
export 'view/widgets/private/workoutButtons/qm_icon_button.dart';
export 'view/widgets/private/exerciseBlocks/exercise_block.dart';
export 'view/widgets/private/exerciseBlocks/add_exercise_block.dart';

//* Controllers

export 'controllers/routing/route_controller.dart';
export 'controllers/theme/theme_controller.dart';
export 'controllers/validation/validation_controller.dart';

//* Utils

export 'utils/auth/register_util.dart';
export 'utils/auth/login_util.dart';
export 'utils/auth/forgot_password_util.dart';
export 'utils/workouts/workouts_util.dart';

//* Models

export 'models/user_model.dart';
export 'models/exercise_model.dart';
export 'models/workout_model.dart';
export 'models/user_image_model.dart';

//* Constants

export 'constants/color_constants.dart';
export 'constants/asset_path_constants.dart';
export 'constants/db_paths_constants.dart';
export 'constants/routes_constants.dart';

//* Packages

export 'package:firebase_auth/firebase_auth.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter_native_splash/flutter_native_splash.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:eva_icons_flutter/eva_icons_flutter.dart';
export 'package:image_picker/image_picker.dart';
export 'package:permission_handler/permission_handler.dart';
export 'package:firebase_storage/firebase_storage.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'dart:convert';
export 'package:intl/message_lookup_by_library.dart';
export 'package:intl/src/intl_helpers.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'generated/l10n.dart';
export 'package:go_router/go_router.dart';
export 'package:responsive_framework/responsive_framework.dart';
export 'package:flutter_test/flutter_test.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart';
// export 'package:flutter_animate/flutter_animate.dart';
export 'dart:io' hide HeaderValue;
export 'package:flutter/foundation.dart' hide shortHash, describeIdentity;
export 'package:uuid/uuid.dart';
export 'package:slimy_card/slimy_card.dart';
export 'dart:async' hide AsyncError;
export 'package:url_strategy/url_strategy.dart';
