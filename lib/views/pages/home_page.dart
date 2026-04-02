import 'package:explore_flutter_2/data/constants.dart';
import 'package:explore_flutter_2/models/user_model.dart';
import 'package:explore_flutter_2/services/store/user_store.dart';
import 'package:explore_flutter_2/views/pages/course_page.dart';
import 'package:explore_flutter_2/views/widgets/container_widget.dart';
import 'package:explore_flutter_2/views/widgets/hero_widget.dart';
import 'package:explore_flutter_2/views/widgets/profile_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userStore = UserStore();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkProfileStatus();
    });
  }

  Future<void> _checkProfileStatus() async {
    final userModel = await _userStore.getUser();

    if (userModel != null) {
      if (!userModel.isProfileComplete) {
        final prefs = await SharedPreferences.getInstance();
        final String key = "pop_up_shown_${userModel.uid}";
        final bool hasShown = prefs.getBool(key) ?? false;

        if (!hasShown && mounted) {
          _showCompleteProfileBottomSheet(context, userModel);
          await prefs.setBool(key, true);
        }
      }
    }
  }

  void _showCompleteProfileBottomSheet(BuildContext context, UserModel user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(
            context,
          ).viewInsets.bottom, // ikut naik kalau ada keyboard
        ),
        child: ProfileFormWidget(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          HeroWidget(
            title: "Tutur.id",
            tag: "hero1",
            imgUrl: "assets/images/rei_1.jpeg",
            nextPage: CoursePage(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: KCardData.length,
              itemBuilder: (context, index) {
                final data = KCardData[index];
                return ContainerWidget(title: data.title, desc: data.desc);
              },
            ),
          ),
        ],
      ),
    );
  }
}
