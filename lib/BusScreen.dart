import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'api_service.dart';
import 'bus_bloc.dart';
import 'bus_event.dart';
import 'bus_state.dart';

class BusScreen extends StatefulWidget {
  const BusScreen({Key? key}) : super(key: key);

  @override
  _BusScreenState createState() => _BusScreenState();
}

class _BusScreenState extends State<BusScreen> {
  late TextEditingController _departureController;
  late TextEditingController _destinationController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _departureController = TextEditingController();
    _destinationController = TextEditingController();
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Trips'),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocProvider(
        create: (context) => BusBloc(apiService: ApiService()),
        child: BlocBuilder<BusBloc, BusState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: _departureController,
                    decoration: InputDecoration(
                      labelText: 'Departure City',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _destinationController,
                    decoration: InputDecoration(
                      labelText: 'Destination City',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.map),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await _selectDate(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      onPrimary: Colors.white,
                    ),
                    child: Text(
                      'Select Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      context.read<BusBloc>().add(
                        FetchBusTrips(
                          departureCity: _departureController.text,
                          destinationCity: _destinationController.text,
                          date: DateFormat('yyyy-MM-dd').format(_selectedDate),
                        ),
                      );
                    },
                    child: Text('Show Buses'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                  SizedBox(height: 20),
                  if (state.isLoading)
                    CircularProgressIndicator()
                  else if (state.error.isNotEmpty)
                    Text('Нет автобусов', style: TextStyle(fontSize: 18, color: Colors.red))
                  else if (state.busTrips == null || state.busTrips!.isEmpty)
                    Text('Нет автобусов', style: TextStyle(fontSize: 18, color: Colors.red))
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.busTrips!.length,
                          itemBuilder: (context, index) {
                            final trip = state.busTrips![index];
                            return Card(
                              elevation: 4.0,
                              margin: EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('Route Number: ${trip['RouteNum']}'),
                                subtitle: Text('Carrier: ${trip['Carrier']}'),
                                trailing: Icon(Icons.directions_bus),
                              ),
                            );
                          },
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}