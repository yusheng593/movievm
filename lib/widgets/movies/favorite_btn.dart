import 'package:flutter/material.dart';
import 'package:movievm/constants/my_app_icons.dart';

class FavoriteBtnWidget extends StatelessWidget {
  const FavoriteBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // TODO: add to favorites.
      },
      icon: const Icon(
        MyAppIcons.favoriteOutlineRounded,
        // color: Colors.red,
        size: 20,
      ),
    );
  }
}
