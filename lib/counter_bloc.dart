import 'dart:async';
import 'package:bloc01/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  final _counterStateController = StreamController<int>();
  //create a pointer of an array(initialized for UI)

  StreamSink<int> get _inCounter => _counterStateController.sink;
  //assign the values of the array

  Stream<int> get counter => _counterStateController.stream;
  //get the values of the array

  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }
  //event listener is initialized in constructor as a running process in the background

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    _inCounter.add(_counter);
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
