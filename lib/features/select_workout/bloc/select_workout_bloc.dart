import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_workout_event.dart';
part 'select_workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(WorkoutInitial()) {
    on<WorkoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
