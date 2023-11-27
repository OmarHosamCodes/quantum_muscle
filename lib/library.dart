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

//* Widgets

export 'view/widgets/qm_block.dart';
export 'view/widgets/qm_text.dart';
export 'view/widgets/qm_textfield.dart';
export 'view/widgets/private/choose_user_type.dart';
export 'view/widgets/private/forgot_password_text.dart';
export 'view/widgets/private/home_search_bar.dart';
export 'view/widgets/private/Routing_drawer.dart';
export 'view/widgets/qm_dialog.dart';
export 'view/widgets/qm_avatar.dart';
export 'view/widgets/private/add_workout.dart';

//* Controllers

export 'controllers/routing/route_controller.dart';
export 'controllers/theme/theme_controller.dart';
export 'controllers/validation/validation_controller.dart';

//* Utils

export 'utils/auth/register_utile.dart';

//* Models

export 'models/user_model.dart';
export 'models/exercise_model.dart';
export 'models/workout_model.dart';

//* Constants

export 'constants/color_constants.dart';
export 'constants/asset_path_constants.dart';
export 'constants/route_name_constants.dart';
export 'constants/db_paths_constants.dart';

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
export 'package:get/get.dart' hide Condition;
export 'package:flutter_animate/flutter_animate.dart';
