import 'package:flutter/material.dart';

const _barTitles = ['Ziele', 'Übersicht', 'Essen'];
class RootPage extends StatefulWidget {

  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with SingleTickerProviderStateMixin {
  
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {

    }));
  }

  @override
  Widget build(BuildContext context) {
    bool f = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness'),
        bottom: TabBar(
            controller: _tabController,
            tabs: [
          Tab(text: _barTitles[0],),
          Tab(text: _barTitles[1],),
          Tab(text: _barTitles[2],)
        ]),
      ),
      body: TabBarView(children: [

      ],),
    );
  }
}
