// bus_event.dart
import 'package:equatable/equatable.dart';

abstract class BusEvent extends Equatable {
  const BusEvent();

  @override
  List<Object> get props => [];
}

class FetchBusTrips extends BusEvent {
  final String departureCity;
  final String destinationCity;
  final String date;

  const FetchBusTrips({
    required this.departureCity,
    required this.destinationCity,
    required this.date,
  });

  @override
  List<Object> get props => [departureCity, destinationCity, date];
}
