import 'package:flutter/cupertino.dart';

class CustomDrawerNotifier extends ChangeNotifier {
  final AnimationController animationController;
  int _currentIndex = 0;

  CustomDrawerNotifier({required this.animationController});

  int get currentIndex => _currentIndex;

  void toggle() {
    if (animationController.isDismissed) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    notifyListeners();
  }

  void changePage(
    int index,
    PageController pageController,
    VoidCallback? onChanged,
  ) {
    _currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    toggle();
    notifyListeners();
    if (onChanged != null) onChanged();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
