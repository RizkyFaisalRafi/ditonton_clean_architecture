import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_drawer_notifier.dart';
import 'package:movies/module/movies.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:about/module/about.dart';

class CustomDrawer extends StatefulWidget {
  final PageController pageController;
  final ValueChanged<int>? onPageChanged;

  const CustomDrawer({
    super.key,
    required this.pageController,
    this.onPageChanged,
  });

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  AnimationController get animationController => _animationController;

  final List<Widget> _pages = [
    HomeMoviePage(),
    TvSeriesPage(),
    WatchlistMoviesPage(),
    WatchlistTvPage(),
    AboutPage(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  void toggle() =>
      _animationController.isDismissed
          ? _animationController.forward()
          : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) =>
              CustomDrawerNotifier(animationController: _animationController),
      child: Consumer<CustomDrawerNotifier>(
        builder: (context, provider, _) {
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              // double slide = 255.0 * _animationController.value;
              // double scale = 1 - (_animationController.value * 0.3);
              double slide = 255.0 * provider.animationController.value;
              double scale = 1 - (provider.animationController.value * 0.3);

              return Stack(
                children: [
                  _buildDrawer(context, provider),
                  Transform(
                    transform:
                        Matrix4.identity()
                          ..translate(slide)
                          ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: PageView(
                      controller: widget.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        provider.setCurrentIndex(index);
                      },
                      children: _pages,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    CustomDrawerNotifier provider, {
    required IconData icon,
    required String title,
    required int index,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        provider.changePage(
          index,
          widget.pageController,
          () => widget.onPageChanged?.call(index),
        );
      },
      selected: provider.currentIndex == index,
    );
  }

  Widget _buildDrawer(BuildContext context, CustomDrawerNotifier provider) {
    return Container(
      color: Colors.grey.shade900,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/circle-g.png'),
              backgroundColor: Colors.grey.shade900,
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
            decoration: BoxDecoration(color: Colors.grey.shade900),
          ),
          _buildDrawerItem(
            context,
            provider,
            icon: Icons.movie,
            title: 'Movies',
            index: 0,
          ),
          _buildDrawerItem(
            context,
            provider,
            icon: Icons.tv_rounded,
            title: 'TV Series',
            index: 1,
          ),
          _buildDrawerItem(
            context,
            provider,
            icon: Icons.save_alt,
            title: 'Watchlist Movie',
            index: 2,
          ),
          _buildDrawerItem(
            context,
            provider,
            icon: Icons.save_alt,
            title: 'Watchlist Tv Series',
            index: 3,
          ),
          _buildDrawerItem(
            context,
            provider,
            icon: Icons.info_outline,
            title: 'About',
            index: 4,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
