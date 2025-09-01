// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/screens/listSegmentosScreen.dart';
import 'package:project/screens/listTesesScreen.dart';
import 'package:project/screens/searchScreen.dart';
import 'package:project/utils/theme_utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final FocusNode _node;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _tabController = TabController(length: 3, vsync: this);
  }

  double getScreenWidth(BuildContext context) {
    final size = (MediaQuery.of(context).size.width);
    return size >= 800 && size <= 1260 ? 4 : 7;
  }

  @override
  void dispose() {
    _node.dispose();
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: ThemeUtils.surfaceColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'lib/images/logo1.png',
                height: 230,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          indicatorColor: ThemeUtils.primaryColor,
          labelColor: ThemeUtils.primaryColor,
          unselectedLabelColor: Colors.black,
          controller: _tabController,
          tabs: const [
            Tab(text: "Gerar Documentos", icon: Icon(Icons.edit_document)),
            Tab(text: "Teses", icon: Icon(Icons.list_alt_sharp)),
            Tab(text: "Segmentos", icon: Icon(Icons.add_business_outlined)),
            //     Tab(text: 'Regimes', icon: Icon(Icons.edit_document))
          ],
        ),
      ),
      body: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: _tabController,
        children: const [
          SearchScreen(),
          ListTesesScreen(),
          SegmentosScreen(),
        ],
      ),
    );
  }
}
