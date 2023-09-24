import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_workout_event.dart';
part 'select_workout_state.dart';

class SelectWorkoutBloc extends Bloc<SelectWorkoutEvent, SelectWorkoutState> {
  SelectWorkoutBloc() : super(SelectWorkoutInitial()) {
    on<SelectWorkoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
