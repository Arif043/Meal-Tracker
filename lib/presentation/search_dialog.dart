import 'package:fitness_tracker/presentation/core/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/food/add/add_bloc.dart';
import '../application/food/food_bloc.dart';
import 'core/theme.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({super.key});
  @override
  Widget build(BuildContext context) {
    final foodBloc = context.read<FoodBloc>();
    // final addBloc = context.read<AddBloc>();
    final addBloc = BlocProvider.of<AddBloc>(context, listen: true);
    return AlertDialog(
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
                  Text('Essen hinzufügen'),
                ],
              )
              : Text('Essen hinzufügen'),
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
                children: [
                  _searchField(context, state.searchInput),
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
                            (context, index) => Padding(
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
                            leading: Image.network(
                              state.requestedFoods[index].thumbUrl!,
                            ),
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
                      Image.network(requestedFoods[index].thumbUrl!),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            requestedFoods[index].name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextTheme.of(context).bodyLarge,
                          ),
                          Text(
                            "Fett ${pretty(requestedFoods[index].fat!)}",
                            style: TextTheme.of(context).bodyMedium,
                          ),
                          Text(
                            "Kohlenhydrate ${pretty(requestedFoods[index].carbs!)}",
                          ),
                          Text(
                            "Protein ${pretty(requestedFoods[index].protein!)}",
                          ),
                          // Text(requestedFoods[index])
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(labelText: 'Menge hinzufügen'),
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
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Expanded(child: Container()),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    foodBloc.add(FoodCancelPressed());
                  },
                  child: Text(
                    'Abbrechen',
                    style: TextStyle(color: lightErrorColor),
                  ),
                ),
              ],
            ),
          ),
        if (addBloc.state is AddInitial || addBloc.state is AddShowDetails)
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              foodBloc.add(FoodCancelPressed());
            },
            child: Text('Abbrechen', style: TextStyle(color: lightErrorColor)),
          ),

        if (addBloc.state is AddShowDetails)
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              addBloc.add(AddItemSubmitted(amount: 1));
              foodBloc.add(FoodCancelPressed());
            },
            child: Text('Ok', style: TextStyle(color: Colors.green)),
          ),
      ],
    );
  }

  Widget _searchField(BuildContext context, String searchInput) {
    return TextField(
      controller: TextEditingController(text: searchInput),
      onChanged: (value) async {
        context.read<AddBloc>().add(AddRequested(value));
      },
    );
  }
}
