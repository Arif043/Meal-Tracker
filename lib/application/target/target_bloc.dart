import 'package:bloc/bloc.dart';
import 'package:fitness_tracker/infrastructure/service/sp_service.dart';
import 'package:meta/meta.dart';

part 'target_event.dart';
part 'target_state.dart';

class TargetBloc extends Bloc<TargetEvent, TargetState> {

  final SpService _sharedPref;

  TargetBloc(this._sharedPref) : super(TargetState(protein: 0, fat: 0, carbs: 0)) {
    on<TargetValuesUpdated>((event, emit) async{
      await _sharedPref.saveTarget(event.fat, event.carbs, event.protein);
      add(TargetLoadValues());
    });

    on<TargetLoadValues>((event, emit) async {
      final (:carbs, :fat, :protein) = await _sharedPref.loadTarget();
      emit(TargetState(fat: fat, carbs: carbs, protein: protein));
    },);
  }
}
