import 'package:flutter/material.dart';

class TargetPage extends StatelessWidget {
  const TargetPage({Key? key}) : super(key: key);

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
                  SizedBox(width: 10,),
                  SizedBox(
                    width: 75,
                    child: TextField(controller: TextEditingController()),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Kohlenhydrate'),
                  SizedBox(width: 10,),
                  SizedBox(
                    width: 75,
                    child: TextField(controller: TextEditingController()),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Protein'),
                  SizedBox(width: 10,),
                  SizedBox(
                    width: 75,
                    child: TextField(controller: TextEditingController()),
                  ),
                ],
              )
            ],),
            SizedBox(height: 32,),
            FilledButton(onPressed: (){}, child: Text('Speichern'),)
          ],
        ),
      ),
    );
  }
}
