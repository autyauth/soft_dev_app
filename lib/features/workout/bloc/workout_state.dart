part of 'workout_bloc.dart';

@immutable
abstract class WorkoutState {}

abstract class WorkoutActionState extends WorkoutState {}

class WorkoutInitial extends WorkoutState {}
