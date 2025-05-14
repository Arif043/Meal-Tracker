import 'package:fitness_tracker/infrastructure/models/consumed_food_model.dart';
import 'package:fitness_tracker/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/food/food_bloc.dart';

const _barTitles = ['Ziele', 'Übersicht', 'Essen'];

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
              Tab(text: _barTitles[2]),
            ],
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          Placeholder(),
          HomePage(),
          Placeholder()
        ]),
        floatingActionButton: _tabController.index == 1 ? FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            BlocProvider.of<FoodBloc>(context).add(AddFoodEvent(ConsumedFood()));
          },) : null
    );
  }
}
