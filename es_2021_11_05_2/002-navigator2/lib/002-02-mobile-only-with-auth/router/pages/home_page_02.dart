/*
 * Copyright 2020 Cagatay Ulusoy (Ulus Oy Apps). All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:navigator_2/002-02-mobile-only-with-auth/home_screen_02.dart';

class HomePage extends Page {
  final Function(String) onColorTap;
  final VoidCallback onLogout;

  HomePage({
    required this.onColorTap,
    required this.onLogout,
  }) : super(key: ValueKey('HomePage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return HomeScreen(
          onColorTap: onColorTap,
          onLogout: onLogout,
        );
      },
    );
  }
}
