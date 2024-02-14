// bus_state.dart
import 'package:equatable/equatable.dart';

class BusState extends Equatable {
  final List<Map<String, dynamic>> busTrips;
  final bool isLoading;
  final String error;

  const BusState({
    required this.busTrips,
    required this.isLoading,
    required this.error,
  });

  factory BusState.initial() => BusState(busTrips: [], isLoading: false, error: '');

  BusState copyWith({
    List<Map<String, dynamic>>? busTrips,
    bool? isLoading,
    String? error,
  }) {
    return BusState(
      busTrips: busTrips ?? this.busTrips,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [busTrips, isLoading, error];
}
