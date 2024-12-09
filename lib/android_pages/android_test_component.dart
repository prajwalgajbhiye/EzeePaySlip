// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'package:pdf/widgets.dart' as pw;
//
//
// pw.Widget buildEmployeeSection(
//     Map<String, dynamic> employee, String selectedMonth, int selectedYear) {
//   String formatDate(String? date) {
//     if (date == null || date.isEmpty) {
//       return 'N/A';
//     }
//
//     try {
//       final inputFormats = [
//         DateFormat('yyyy-MM-dd'),
//         DateFormat('MM/dd/yyyy'),
//         DateFormat('dd/MM/yyyy'),
//       ];
//
//       DateTime parsedDate;
//       for (final format in inputFormats) {
//         try {
//           parsedDate = format.parse(date);
//           return DateFormat('d-MMM-yyyy').format(parsedDate);
//         } catch (e) {}
//       }
//
//       return 'N/A';
//     } catch (e) {
//       print("Invalid date format: $date");
//       return 'N/A';
//     }
//   }
//
//   double parseDouble(dynamic value) {
//     if (value == null) return 0.0;
//     if (value is double) return value;
//     if (value is String) {
//       return double.tryParse(value) ?? 0.0;
//     }
//     return 0.0;
//   }
//
//   // All your calculations remain unchanged...
//
//   return pw.Container(
//     child: pw.Column(
//       children: [
//         pw.Text(
//           'SATYAM CONSTRUCTION',
//           style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.Text(
//           'BHANDARA',
//           style: const pw.TextStyle(fontSize: 8, color: PdfColors.black),
//         ),
//         pw.RichText(
//           text: pw.TextSpan(
//             children: [
//               const pw.TextSpan(
//                 text: 'Pay Slip for the month of: ',
//                 style: pw.TextStyle(color: PdfColors.black, fontSize: 8),
//               ),
//               pw.TextSpan(
//                 text: selectedMonth,
//                 style: pw.TextStyle(
//                   fontWeight: pw.FontWeight.bold,
//                   fontSize: 8,
//                 ),
//               ),
//               const pw.TextSpan(
//                 text: ' - ',
//                 style: pw.TextStyle(color: PdfColors.black, fontSize: 8),
//               ),
//               pw.TextSpan(
//                 text: "$selectedYear",
//                 style: pw.TextStyle(
//                   color: PdfColors.black,
//                   fontSize: 8,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         pw.SizedBox(height: 10),
//         // Rest of your code remains unchanged...
//       ],
//     ),
//   );
// }
