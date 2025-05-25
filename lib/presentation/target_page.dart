import 'package:easy_localization/easy_localization.dart';
import 'package:meal_tracker/application/target/target_bloc.dart';
import 'package:meal_tracker/presentation/core/theme.dart';
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
    _fatCtr = TextEditingController(text: fat.toString() != '0' ? fat.toString() : '');
    _proteinCtr = TextEditingController(text: protein.toString() != '0' ? protein.toString() : '');
    _carbsCtr = TextEditingController(text: carbs.toString() != '0' ? carbs.toString() : '');
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
                'targetHeader'.tr(),
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
                    Text('carbs'.tr()),
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
                    Text('fat'.tr()),
                    SizedBox(width: 10),
                    SizedBox(width: 75, child: TextField(controller: _fatCtr, keyboardType: TextInputType.number, inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))])),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('protein'.tr()),
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
                if (_fatCtr.text.isEmpty || _carbsCtr.text.isEmpty || _proteinCtr.text.isEmpty)
                  return;
                context.read<TargetBloc>().add(
                  TargetValuesUpdated(
                    fat: int.parse(_fatCtr.text.isEmpty ? '0' : _fatCtr.text),
                    carbs: int.parse(_carbsCtr.text.isEmpty ? '0' : _carbsCtr.text),
                    protein: int.parse(_proteinCtr.text.isEmpty ? '0' : _proteinCtr.text),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("success".tr()), backgroundColor: lightSuccess,));
              },
              child: Text('save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
