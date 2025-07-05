import 'package:eventlyapproute/ui/home/tabs/profile/profile_tabs.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileTabs(),
    );
  }
}
