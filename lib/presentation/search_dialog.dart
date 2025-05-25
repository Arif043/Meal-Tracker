import 'package:easy_localization/easy_localization.dart';
import 'package:meal_tracker/presentation/core/format.dart';
import 'package:meal_tracker/presentation/core/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/home/add/add_bloc.dart';
import '../application/home/home_bloc.dart';
import 'core/theme.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {

  late final TextEditingController _amountTextController;

  @override
  void initState() {
    super.initState();
    _amountTextController = TextEditingController();
  }

  @override
  void dispose() {
    _amountTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodBloc = context.read<HomeBloc>();
    // final addBloc = context.read<AddBloc>();
    final addBloc = BlocProvider.of<AddBloc>(context, listen: true);
    return AlertDialog(
      backgroundColor: lightSurfaceColor,
      title:
          addBloc.state is AddShowDetails
              ? Row(
                children: [
                  IconButton(
                    onPressed: () {
                      addBloc.add(AddBackToResults());
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text('addDialogTitle'.tr()),
                ],
              )
              : Text('addDialogTitle'.tr()),
      content: BlocBuilder<AddBloc, AddState>(
        bloc: addBloc,
        builder: (context, state) {
          switch (state) {
            case AddInitial():
              return _searchField(context, state.searchInput);

            case AddShowRecommendation():
              // TODO: Handle this case.
              throw UnimplementedError();

            case AddLoading():
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _searchField(context, state.searchInput),
                  SizedBox(height: 20,),
                  Center(child: CircularProgressIndicator()),
                ],
              );

            case AddSuccess():
              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _searchField(context, state.searchInput),
                    SizedBox(height: 20),
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder:
                            (_, _) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Divider(thickness: 1),
                            ),
                        itemCount: state.requestedFoods.length,
                        itemBuilder: (context, index) {
                          // debugPrint(state.consumedFoods![0].name);
                          return ListTile(
                            onTap:
                                () =>
                                    addBloc.add(AddItemSelected(index: index)),
                            leading: ImageView(url: state.requestedFoods[index].thumbUrl!),
                            title: Text(
                              state.requestedFoods[index].name!,
                              textAlign: TextAlign.right,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );

            case AddShowDetails():
              var AddShowDetails(:requestedFoods, :index) = state;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ImageView(url: state.requestedFoods[index].thumbUrl!),
                      ),
                      Expanded(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              requestedFoods[index].name!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: lightDetailTitle,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "${'fat'.tr()}: ${prepareValue(requestedFoods[index].fat!)}", //${pretty(requestedFoods[index].fat!)}",
                              style: TextTheme.of(context).bodyMedium,
                            ),
                            Text(
                              "${'carbs'.tr()}: ${prepareValue(requestedFoods[index].carbs!)}", //${pretty(requestedFoods[index].carbs!)}",
                            ),
                            Text(
                              "${'protein'.tr()}: ${prepareValue(requestedFoods[index].protein!)}", //${pretty(requestedFoods[index].protein!)}",
                            ),
                            // Text(requestedFoods[index])
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _amountTextController,
                    decoration: InputDecoration(labelText: 'addQuantity'.tr()),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ],
              );

            case AddError():
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _searchField(context, state.searchInput),
                  SizedBox(height: 10,),
                  const Icon(Icons.error, size: 40, color: Colors.redAccent),
                  const SizedBox(height: 20),
                  Text(
                    state.failure.toString(),
                    style: TextTheme.of(context).displayLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
          }
        },
      ),
      actions: [
        if (addBloc.state is AddSuccess)
          Row(
            children: [
              IconButton(
                onPressed: (addBloc.state as AddSuccess).pageNumber == 1 ? null : () => addBloc.add(AddPreviousPagePressed()),
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              Text((addBloc.state as AddSuccess).pageNumber.toString()),
              IconButton(
                onPressed: () => addBloc.add(AddNextPagePressed()),
                icon: Icon(Icons.arrow_forward_ios_rounded),
              ),
              Expanded(child: Container()),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'cancel'.tr(),
                  style: TextStyle(color: lightErrorColor),
                ),
              ),
            ],
          ),

        if (addBloc.state is AddInitial || addBloc.state is AddShowDetails)
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('cancel'.tr(), style: TextStyle(color: lightErrorColor)),
          ),

        if (addBloc.state is AddShowDetails)
          TextButton(
            onPressed: () {
              if (_amountTextController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('enterValue'.tr()), backgroundColor: lightErrorColor,));
                return;
              }
              final state = addBloc.state as AddShowDetails;
              final item = state.requestedFoods[state.index];
              foodBloc.add(HomeFoodSubmitted(food: item, amount: double.parse(_amountTextController.text)));
              Navigator.pop(context);
            },
            child: Text('Ok', style: TextStyle(color: Colors.green)),
          ),
      ],
    );
  }

  Widget _searchField(BuildContext context, String searchInput) {
    return TextField(
      controller: TextEditingController(text: searchInput),
      decoration: InputDecoration(hintText: "searchForProducts".tr()),
      onChanged: (value) async {
        context.read<AddBloc>().add(AddRequested(value));
      },
    );
  }
}
