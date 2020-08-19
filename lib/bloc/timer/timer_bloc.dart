import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:state_management_app/bloc/timer/Ticker.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const _duration=60;
  final Ticker _ticker;
  StreamSubscription<int> _tickerSubscription;

  TimerBloc(this._ticker) :assert(_ticker!=null), super(InitialTimerState(_duration));


  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if(event is StartedTimeEvent){
      yield* _mapTimerStartedToState(event);
    }else if(event is TimerTickedEvent){
      yield* _mapTimerTickedToState(event);
    }else if(event is PausedTimerEvent){
      yield* _mapTimerPausedToState(event);
    }else if(event is ResumedTimerEvent){
      yield* _mapTimerResumedToState(event);
    } else if (event is ResetTimerEvent) {
      yield* _mapTimerResetToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapTimerStartedToState(StartedTimeEvent start) async* {
    yield RunningTimerState(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TimerTickedEvent(duration)));
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTickedEvent tick) async* {
    yield tick.duration > 0 ? RunningTimerState(tick.duration) : CompletedTimerState(tick.duration);
  }

  Stream<TimerState> _mapTimerPausedToState(PausedTimerEvent pause) async* {
    if (state is RunningTimerState) {
      _tickerSubscription?.pause();
      yield PausedTimerState(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(ResumedTimerEvent resume) async* {
    if (state is PausedTimerState) {
      _tickerSubscription?.resume();
      yield RunningTimerState(state.duration);
    }
  }


  Stream<TimerState> _mapTimerResetToState(ResetTimerEvent reset) async* {
    _tickerSubscription?.cancel();
    yield InitialTimerState(_duration);
  }
}
