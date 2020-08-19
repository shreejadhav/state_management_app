part of 'timer_bloc.dart';

@immutable
abstract class TimerState {
  final int duration;
  const TimerState(this.duration);
}

class InitialTimerState extends TimerState {
  InitialTimerState(int duration) : super(duration);
}

class RunningTimerState extends TimerState{
  RunningTimerState(int duration) : super(duration);
}

class PausedTimerState extends TimerState{
  PausedTimerState(int duration) : super(duration);
}

class CompletedTimerState extends TimerState{
  CompletedTimerState(int duration) : super(duration);

}