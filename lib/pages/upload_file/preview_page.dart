import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  final Map<String, String> employeeData;
  final String employeeName;
  final int employeeNumber; // Add an integer for Sr. No.

  const PreviewPage({
    super.key,
    required this.employeeData,
    required this.employeeName,
    required this.employeeNumber, // Pass Sr. No.
  });

  @override
  Widget build(BuildContext context) {
    final int workingDaysCount = _calculateWorkingDays();
    final double overtimeDaysCount = _calculateOvertimeDays(); // Changed to double for fractional days

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Employee Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Sr. No.
                  Text(
                    '$employeeNumber.',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Employee Name
                  Text(
                    employeeName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1.5, height: 20),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Container for "Day" data
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Working Days',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  workingDaysCount.toString(),
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1.5),
                            Flexible(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  spacing: 30,
                                  runSpacing: 15,
                                  children: _buildEmployeeInfoRows(isDay: true),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Container for "OT" data
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Overtime Days',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  overtimeDaysCount.toStringAsFixed(3), // Display as one decimal
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1.5),
                            Flexible(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  spacing: 30,
                                  runSpacing: 5,
                                  children: _buildEmployeeInfoRows(isDay: false),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildEmployeeInfoRows({required bool isDay}) {
    List<Widget> rows = [];

    employeeData.forEach((key, value) {
      // Filter keys based on whether they are day-related or OT-related
      bool isDayEntry = key.startsWith('Day');
      bool isOTEntry = key.startsWith('OT');

      if ((isDay && isDayEntry) || (!isDay && isOTEntry)) {
        rows.add(
          buildDetailColumn(
            label: key,
            value: value,
          ),
        );
      }
    });

    return rows;
  }


  Widget buildDetailColumn({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        alignment: Alignment.center,
        height: 70,
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateWorkingDays() {
    int workingDays = 0;
    employeeData.forEach((key, value) {
      if (key.startsWith('Day') && value.isNotEmpty && _isAlphabetic(value)) {
        workingDays += 1;
      }
    });
    return workingDays;
  }

  double _calculateOvertimeDays() {
    int overtimeTotal = 0;
    employeeData.forEach((key, value) {
      if (key.startsWith('OT') && int.tryParse(value) != null) {
        overtimeTotal += int.parse(value);
      }
    });
    return overtimeTotal / 8; // Convert hours to days
  }

  bool _isAlphabetic(String value) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }
}
