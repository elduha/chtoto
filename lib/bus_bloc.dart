import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_service.dart';
import 'bus_event.dart';
import 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  final ApiService apiService;

  BusBloc({required this.apiService}) : super(BusState.initial());

  @override
  Stream<BusState> mapEventToState(BusEvent event) async* {
    if (event is FetchBusTrips) {
      yield state.copyWith(isLoading: true);
      try {
        final busTrips = await apiService.fetchBusTrips(event.departureCity, event.destinationCity, event.date);
        yield state.copyWith(busTrips: busTrips, isLoading: false, error: '');
      } catch (e) {
        yield state.copyWith(isLoading: false, error: e.toString());
      }
    }
  }
}
