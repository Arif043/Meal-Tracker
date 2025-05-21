import 'package:fitness_tracker/presentation/home_page.dart';
import 'package:fitness_tracker/presentation/target_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/food/food_bloc.dart';

const _barTitles = ['Übersicht', 'Ziel'];

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
    _tabController = TabController(length:2, vsync: this);
    _tabController.index = 1;
    _tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Fitness'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: _barTitles[0]),
              Tab(text: _barTitles[1]),
            ],
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          HomePage(),
          TargetPage()
        ]),
        floatingActionButton: _tabController.index == 0 ? FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            context.read<FoodBloc>().add(FoodAddPressed());
          },) : null
    );
  }
}
