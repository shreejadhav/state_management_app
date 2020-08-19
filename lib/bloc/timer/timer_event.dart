part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent {
  const TimerEvent();
}

class StartedTimeEvent extends TimerEvent {
  final int duration;

  const StartedTimeEvent(this.duration);

  @override
  String toString() {
    return "TimerStarted { duration: $duration }";
  }
}

class PausedTimerEvent extends TimerEvent {}

class ResumedTimerEvent extends TimerEvent{}
class ResetTimerEvent extends TimerEvent{}
class TimerTickedEvent extends TimerEvent{
  final int duration;
  const TimerTickedEvent(this.duration);
}

