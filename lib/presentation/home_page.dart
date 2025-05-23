import 'dart:io';
import 'package:fitness_tracker/application/target/target_bloc.dart';
import 'package:fitness_tracker/presentation/core/image_view.dart';
import 'package:fitness_tracker/presentation/overview_without_target.dart';
import 'package:fitness_tracker/presentation/search_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../application/home/add/add_bloc.dart';
import '../application/home/home_bloc.dart';
import 'core/format.dart';
import 'core/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) {
          if (state.status == HomeStatus.add) {
            showAddDialog(
              context,
              DateTime.now().subtract(Duration(days: 10)),
              DateTime.now(),
            );
          }
        },
        builder: (BuildContext context, state) {
          return Column(
            children: [
              OverviewWithoutTarget(
                fat: state.accumulatedFat,
                protein: state.accumulatedProtein,
                carbs: state.accumulatedCarbs,
                initial: state.time,
              ),
              SizedBox(height: 20),
              Divider(color: containerColorLight, thickness: 0.4),
              SizedBox(height: 20),
              if (state.consumedFoods != null)
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.consumedFoods!.length,
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemBuilder: (context, index) => Dismissible(
                      onDismissed: (direction) {
                        context.read<HomeBloc>().add(HomeFoodRemoved(index));
                      },
                      key: ValueKey(state.consumedFoods![index].id),
                      background: Container(
                        alignment: Alignment
                            .centerLeft, // wo das Hintergrund-Widget erscheint
                        padding: const EdgeInsets.only(left: 20),
                        child: const Icon(Icons.delete),
                      ),
                      direction: DismissDirection.startToEnd,
                      resizeDuration: Duration(milliseconds: 200),
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        color: containerColorLight,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: ImageView(
                                      url: state
                                          .consumedFoods![index]
                                          .food!
                                          .thumbUrl!,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          state.consumedFoods![index].name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: lightDetailTitle.copyWith(
                                            color: containerTextColorLight,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Fett: ${state.consumedFoods![index].fat.toString().isNotEmpty ? "${pretty(state.consumedFoods![index].fat)}g" : prepareValue(state.consumedFoods![index].fat.toString())}", //${pretty(requestedFoods[index].fat!)}",
                                          style: TextTheme.of(context)
                                              .bodyMedium
                                              ?.copyWith(
                                                color: containerTextColorLight,
                                              ),
                                        ),
                                        Text(
                                          "Kohlenhydrate: ${state.consumedFoods![index].carbs.toString().isNotEmpty ? "${pretty(state.consumedFoods![index].carbs)}g" : prepareValue(state.consumedFoods![index].carbs.toString())}",
                                          style: TextTheme.of(context)
                                              .bodyMedium
                                              ?.copyWith(
                                                color: containerTextColorLight,
                                              ),
                                        ),
                                        Text(
                                          "Protein: ${state.consumedFoods![index].protein.toString().isNotEmpty ? "${pretty(state.consumedFoods![index].protein)}g" : prepareValue(state.consumedFoods![index].protein.toString())}",
                                          style: TextTheme.of(context)
                                              .bodyMedium
                                              ?.copyWith(
                                                color: containerTextColorLight,
                                              ),
                                        ),
                                        // Text(requestedFoods[index])
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void showAddDialog(BuildContext context, DateTime from, DateTime to) {
    showDialog(
      useSafeArea: true,
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => AddBloc(GetIt.I()),
          child: SearchDialog(),
        );
      },
    );
  }
}
