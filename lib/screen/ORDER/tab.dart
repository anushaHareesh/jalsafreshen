import 'package:flutter/material.dart';

class MyMainTabVarView extends StatefulWidget {
  const MyMainTabVarView({Key? key}) : super(key: key);

  @override
  _MyMainTabVarViewState createState() => _MyMainTabVarViewState();
}

class _MyMainTabVarViewState extends State<MyMainTabVarView>
    with TickerProviderStateMixin {
  late final TabController controllerForMainTabVarView =
      TabController(length: 3, vsync: this, initialIndex: 0);
  late final TabController topTabBarController =
      TabController(length: 2, vsync: this, initialIndex: 0);

  late PageController pageController = PageController();

  onPageChange(int index) {
    debugPrint("page num $index");
    controllerForMainTabVarView.animateTo(
      index ~/ 2,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
    topTabBarController.animateTo(
      index % 2,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );

    setState(() {});
  }

  void navigation(bool isTopController) {
    //skip 1st build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      int mainTabBarIndex = controllerForMainTabVarView.index;
      int topTabBarIndex = topTabBarController.index;

      /// switch to TopTabBar index=0
      if (!isTopController) {
        topTabBarIndex = 0;
        topTabBarController.index = 0;
      }
      debugPrint("main $mainTabBarIndex top $topTabBarIndex");

      pageController.animateToPage(
        topTabBarIndex + mainTabBarIndex * 2,
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          TabBar(
              controller: topTabBarController,
              tabs: const [
                Tab(text: "Page1"),
                Tab(text: "Page2"),
              ],
              onTap: (_) {
                navigation(true);
              }),
          Expanded(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: PageView(
                controller: pageController,
                onPageChanged: onPageChange,
                children: const [
                  Center(child: Text(' MyStful1 Page1')),
                  Center(child: Text(' MyStful1 Page2')),
                  Center(child: Text(' MyStful2 Page1')),
                  Center(child: Text(' MyStful2 Page2')),
                  Center(child: Text(' MyStful3 Page1')),
                  Center(child: Text(' MyStful3 Page2')),
                ],
              ),
            ),
          ),
          TabBar(
            // here i am use TabBar at the bottom of the screen instead of bottom Navigation Bar
            controller: controllerForMainTabVarView,
            onTap: (_) {
              navigation(false);
            },
            tabs: const [
              Tab(
                text: "My Stful 1",
              ),
              Tab(
                text: "My Stful 2",
              ),
              Tab(
                text: "My Stful 3",
              ),
            ],
          )
        ],
      ),
    );
  }
}
