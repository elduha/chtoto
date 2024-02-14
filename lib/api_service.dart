import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchBusTrips(String departureCity, String destinationCity, String date) async {
    try {
      final response = await _dio.get('https://bibiptrip.com/api/avibus/search_trips_cities/', queryParameters: {
        'departure_city': departureCity,
        'destination_city': destinationCity,
        'date': date,
      });

      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to load bus trips');
      }
    } catch (e) {
      throw Exception('Failed to load bus trips: $e');
    }
  }
}
