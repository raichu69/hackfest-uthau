import 'package:flutter/material.dart';
import 'dart:math';

class BusBookingPage extends StatefulWidget {
  @override
  _BusBookingPageState createState() => _BusBookingPageState();
}

class _BusBookingPageState extends State<BusBookingPage> {
  String passengerName = '';
  String contactNumber = '';
  List<int> bookedSeats = [];
  int numberOfPassengers = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Booking'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    passengerName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Passenger Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    contactNumber = value;
                  });
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    numberOfPassengers = int.tryParse(value) ?? 1;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of Passengers',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Select Seat:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 2 columns, a gap, and 2 more columns
                  crossAxisSpacing: 10.0, // Gap between columns
                  mainAxisSpacing: 10.0, // Gap between rows
                  childAspectRatio: 1.2,
                ),
                itemCount: 30,
                itemBuilder: (context, index) {
                  int seatNumber = index + 1;
                  bool isBooked = bookedSeats.contains(seatNumber);
                  bool isSelectable =
                      !isBooked && seatNumber <= numberOfPassengers;

                  return GestureDetector(
                    onTap: isSelectable
                        ? () {
                            setState(() {
                              if (isBooked) {
                                bookedSeats.remove(seatNumber);
                              } else {
                                bookedSeats.add(seatNumber);
                              }
                            });
                          }
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isBooked
                            ? Colors.green
                            : isSelectable
                                ? Colors.grey[300]
                                : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          seatNumber.toString(),
                          style: TextStyle(
                            color: isBooked ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle booking logic here
                  if (passengerName.isNotEmpty &&
                      contactNumber.isNotEmpty &&
                      numberOfPassengers > 0) {
                    List<int> availableSeats =
                        List.generate(30, (index) => index + 1);
                    availableSeats
                        .shuffle(); // Shuffle the list to get random seat numbers
                    bookedSeats =
                        availableSeats.sublist(0, min(numberOfPassengers, 30));

                    print(
                        'Booking confirmed for $passengerName. Seats: $bookedSeats');
                  } else {
                    print(
                        'Please fill in all the details and select the correct number of passengers.');
                  }
                },
                child: Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
