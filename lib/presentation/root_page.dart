import 'package:easy_localization/easy_localization.dart';
import 'package:meal_tracker/presentation/home_page.dart';
import 'package:meal_tracker/presentation/target_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/home/home_bloc.dart';

final _barTitles = ['overview'.tr(), 'target'.tr()];

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 0;
    _tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Meal Tracker'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _optionsMenuHandler,
            itemBuilder: (BuildContext context) {
              return {'privacy', 'about'}.map((
                String choice,
              ) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice.tr()),
                );
              }).toList();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: _barTitles[0]),
            Tab(text: _barTitles[1]),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [HomePage(), TargetPage()],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                context.read<HomeBloc>().add(HomeAddPressed());
              },
            )
          : null,
    );
  }

  void _optionsMenuHandler(String item) {
    switch (item) {
      case 'about':
        showAboutDialog(
          context: context,
          applicationName: 'Meal Tracker',
          applicationLegalese: '© Arif Ertugrul',
          applicationVersion: '1.0',
          applicationIcon: SizedBox(
            height: 32,
            width: 32,
            child: Image.asset('assets/icons/icon.png'),
          ),
        );
        break;
      case 'privacy':
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('privacy'.tr()),
            content: SingleChildScrollView(
              child: Text('privacyContent'.tr()),
            ),
          ),
        );
    }
  }
}
