import 'package:fitness_tracker/application/target/target_bloc.dart';
import 'package:fitness_tracker/presentation/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TargetPage extends StatefulWidget {
  const TargetPage({Key? key}) : super(key: key);

  @override
  State<TargetPage> createState() => _TargetPageState();
}

class _TargetPageState extends State<TargetPage> {
  late final TextEditingController _fatCtr, _carbsCtr, _proteinCtr;

  @override
  void initState() {
    super.initState();
    final state = context.read<TargetBloc>().state;
    final fat = state.fat;
    final carbs = state.carbs;
    final protein = state.protein;
    _fatCtr = TextEditingController(text: fat.toString());
    _proteinCtr = TextEditingController(text: protein.toString());
    _carbsCtr = TextEditingController(text: carbs.toString());
  }

  @override
  void dispose() {
    _fatCtr.dispose();
    _proteinCtr.dispose();
    _carbsCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32, top: 8),
              child: Text(
                'Lege fest, wie viel du konsumieren willst',
                textAlign: TextAlign.center,
                style: TextTheme.of(context).displayLarge,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Fett'),
                    SizedBox(width: 10),
                    SizedBox(width: 75, child: TextField(controller: _fatCtr, keyboardType: TextInputType.number, inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))])),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Kohlenhydrate'),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 75,
                      child: TextField(controller: _carbsCtr, keyboardType: TextInputType.number, inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Protein'),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 75,
                      child: TextField(controller: _proteinCtr, keyboardType: TextInputType.number, inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 64),
            FilledButton(
              onPressed: () {
                context.read<TargetBloc>().add(
                  TargetValuesUpdated(
                    fat: int.parse(_fatCtr.text),
                    carbs: int.parse(_carbsCtr.text),
                    protein: int.parse(_proteinCtr.text),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ziel gespeichert"), backgroundColor: lightSuccess,));
              },
              child: Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }
}
