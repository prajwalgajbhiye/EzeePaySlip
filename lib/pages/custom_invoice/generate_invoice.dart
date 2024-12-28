// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../employee_enfo_classes/custom_classes.dart';
import '../home_page.dart';

class GenerateInvoice extends StatefulWidget {
  const GenerateInvoice({super.key});

  @override
  State<GenerateInvoice> createState() => _GenerateInvoiceState();
}

class _GenerateInvoiceState extends State<GenerateInvoice> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sacCodeController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _providerNameController =
      TextEditingController(text: "SATYAM CONSTRUCTION");
  final TextEditingController _providerAddressController = TextEditingController(
      text:
          "131, Plot NO.8, Gollapuram village, Gollapuram,          Sri   Sathyasai, Andhra Pradesh 515211");
  final TextEditingController _providerStateController =
      TextEditingController(text: "ANDHRAPRADESH");
  final TextEditingController _providerGistinNOController =
      TextEditingController(text: "37CLBPD8503R1ZQ");
  final TextEditingController _providerInvoiceNoController =
      TextEditingController(text: "SC 38");
  final TextEditingController _providerStateCodeController =
      TextEditingController(text: "37");
  final TextEditingController _receiverNameController =
      TextEditingController(text: "SUNFLAG IRON & STEEL CO. LTD");
  final TextEditingController _receiverInvoiceNoController =
      TextEditingController(text: (""));
  final TextEditingController _receiverAddressController = TextEditingController(
      text:
          ("P.O B HANDARA RAOD WARTHI, PIN NO 441905 DIST. BHANDARA (M.S)  INDIA."));
  final TextEditingController _receiverStateController =
      TextEditingController(text: ("MAHARASHTRA"));
  final TextEditingController _receiverStateCodeController =
      TextEditingController(text: ("27"));
  final TextEditingController _receiverGistinNOController =
      TextEditingController(text: ("27AACCS3376C1ZH"));

  int?
      _editingDescriptionIndex; // Null means no editing, index refers to the item being edited
  String _description = "";
  String _providerName =
      "SATYAM CONSTRUCTION"; // Variable to store the description text
  String _providerAddress =
      "131, Plot NO.8, Gollapuram village, Gollapuram,          Sri   Sathyasai, Andhra Pradesh 515211"; // Variable to store the description text
  String _providerStateCode = "37"; // Variable to store the description text
  String _providerGistinNo =
      "37CLBPD8503R1ZQ"; // Variable to store the description text
  String _providerState =
      "ANDHRAPRADESH"; // Variable to store the description text
  String _providerInvoiceNo = "SC 38";

  // Variable to store the description text
  String _receiverName =
      "SUNFLAG IRON & STEEL CO. LTD"; // Variable to store the description text
  String _receiverAddress =
      "P.O B HANDARA RAOD WARTHI, PIN NO 441905 DIST. BHANDARA (M.S)  INDIA."; // Variable to store the description text
  String _receiverState =
      "MAHARASHTRA"; // Variable to store the description text
  String _receiverStateCode = "27"; // Variable to store the description text
  String _receiverGistinNo =
      "27AACCS3376C1ZH"; // Variable to store the description text
  String _receiverInvoiceNo = ""; // Variable to store the description text
  // Variable to store the description text

  // List to store service details rows
  final List<Map<String, String>> _serviceDetails = [];

  String convertNumberToWords(double number) {
    if (number == 0) return "Zero";

    const ones = [
      '',
      'One',
      'Two',
      'Three',
      'Four',
      'Five',
      'Six',
      'Seven',
      'Eight',
      'Nine',
      'Ten',
      'Eleven',
      'Twelve',
      'Thirteen',
      'Fourteen',
      'Fifteen',
      'Sixteen',
      'Seventeen',
      'Eighteen',
      'Nineteen'
    ];

    const tens = [
      '',
      '',
      'Twenty',
      'Thirty',
      'Forty',
      'Fifty',
      'Sixty',
      'Seventy',
      'Eighty',
      'Ninety'
    ];

    String words = '';

    // Handle crores
    if (number >= 10000000) {
      words +=
          '${convertNumberToWords((number ~/ 10000000).toDouble())} Crore ';
      number %= 10000000;
    }

    // Handle lakhs
    if (number >= 100000) {
      words += '${convertNumberToWords((number ~/ 100000).toDouble())} Lakh ';
      number %= 100000;
    }

    // Handle thousands
    if (number >= 1000) {
      words += '${convertNumberToWords((number ~/ 1000).toDouble())} Thousand ';
      number %= 1000;
    }

    // Handle hundreds
    if (number >= 100) {
      words += '${convertNumberToWords((number ~/ 100).toDouble())} Hundred ';
      number %= 100;
    }

    // Handle tens
    if (number >= 20) {
      words += '${tens[(number ~/ 10).toInt()]} ';
      number %= 10;
    }

    // Handle ones (and numbers less than 20)
    if (number > 0) {
      words += '${ones[number.toInt()]} ';
    }

    return words.trim();
  }

  void _addServiceDetails() {
    setState(() {
      _serviceDetails.add({
        'sacCode': _sacCodeController.text,
        'qty': _qtyController.text,
        'rate': _rateController.text,
      });

      // Clear the input fields after adding
      _sacCodeController.clear();
      _qtyController.clear();
      _rateController.clear();
    });
  }

  double get _totalAmount {
    return _serviceDetails.fold(
      0.0,
      (sum, service) {
        double qty = double.tryParse(service['qty'] ?? '0') ?? 0.0;
        double rate = double.tryParse(service['rate'] ?? '0') ?? 0.0;
        return sum + (qty * rate);
      },
    );
  }

  double get _gstAmount => _totalAmount * 0.18;

  double get _finalGstAmount => _gstAmount + _totalAmount;

  String get formattedGstAmount {
    final formatter =
        NumberFormat('#,##0.00'); // Format with commas and 2 decimal places
    return formatter.format(_gstAmount);
  }

  String get formattedFinalGstAmount {
    final formatter =
        NumberFormat('#,##0.00'); // Format with commas and 2 decimal places
    return formatter.format(_finalGstAmount);
  }

  String get formattedTotalAmount {
    final formatter =
        NumberFormat('#,##0.00'); // Format with commas and 2 decimal places
    return formatter.format(_totalAmount);
  }

  void _addDescription() {
    setState(() {
      _description = _descriptionController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addProviderName() {
    setState(() {
      _providerName = _providerNameController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addProviderAddress() {
    setState(() {
      _providerAddress = _providerAddressController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addProviderState() {
    setState(() {
      _providerState = _providerStateController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addProviderStateCode() {
    setState(() {
      _providerStateCode = _providerStateCodeController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addProviderGistinNo() {
    setState(() {
      _providerGistinNo = _providerGistinNOController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addProviderInvoiceNo() {
    setState(() {
      _providerInvoiceNo = _providerInvoiceNoController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addReceiverName() {
    setState(() {
      _receiverName = _receiverNameController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addReceiverInvoiceNo() {
    setState(() {
      _receiverInvoiceNo = _receiverInvoiceNoController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addReceiverAddress() {
    setState(() {
      _receiverAddress = _receiverAddressController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addReceiverState() {
    setState(() {
      _receiverState = _receiverStateController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addReceiverStateCode() {
    setState(() {
      _receiverStateCode = _receiverStateCodeController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  void _addReceiverGistinNo() {
    setState(() {
      _receiverGistinNo = _receiverGistinNOController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  DateTime _selectedDate = DateTime.now(); // Default date is the current date.

  // Function to show the date picker and update the selected date.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Initial date (current date).
      firstDate: DateTime(2000), // The earliest date the user can select.
      lastDate: DateTime(2101), // The latest date the user can select.
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; // Update the selected date.
      });
    }
  }

  pw.Widget _pdfBuildDetailsContainer({
    required String serviceProviderDetails,
    required String serviceReceiverDetails,
    required pw.Font customFont, // Add the custom font as a parameter
  }) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(color: PdfColors.black),
          bottom: pw.BorderSide(color: PdfColors.black),
        ),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 5,
            child: pw.Container(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 3),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black),
              ),
              child: pw.Text(
                serviceProviderDetails,
                style: pw.TextStyle(fontSize: 8.5, font: customFont),
              ),
            ),
          ),
          pw.Expanded(
              flex: 5,
              child: pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                child: pw.Text(
                  serviceReceiverDetails,
                  style: pw.TextStyle(fontSize: 8.5, font: customFont),
                ),
              )),
        ],
      ),
    );
  }

  pw.Widget _pdfBuildServiceDetailsRow({
    required List<String> serviceProviderDetails,
    required List<String> serviceReceiverDetails,
    required pw.Font customFont, // Add the custom font as a parameter

    List<double>? fontSizes, // Font sizes for each line (optional)
  }) {
    pw.Widget buildDetailsColumn(
        List<String> details, List<double>? fontSizes) {
      return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: List.generate(details.length, (index) {
          return pw.Text(
            details[index],
            maxLines: 2,
            style: pw.TextStyle(
                fontSize: (fontSizes != null && index < fontSizes.length)
                    ? fontSizes[index]
                    : 10,
                font: customFont),
          );
        }).toList(),
      );
    }

    return pw.Row(
      children: [
        pw.Expanded(
          flex: 5,
          child: pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                right: pw.BorderSide(color: PdfColors.black),
              ),
            ),
            child: buildDetailsColumn(serviceProviderDetails, fontSizes),
          ),
        ),
        pw.Expanded(
          flex: 5,
          child: pw.Container(
            height: 100,
            padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(color: PdfColors.black),
              ),
            ),
            // padding: const pw.EdgeInsets.symmetric(horizontal: 2),
            child: buildDetailsColumn(serviceReceiverDetails, fontSizes),
          ),
        ),
      ],
    );
  }

  pw.Widget _pdfBuildServiceHeaderRow(pw.Font customFont) {
    pw.Widget buildHeaderCell(String text,
        {bool hasRightBorder = true, int flex = 1}) {
      return pw.Expanded(
        flex: flex,
        child: pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            border: pw.Border(
              right: hasRightBorder
                  ? const pw.BorderSide(color: PdfColors.black)
                  : pw.BorderSide.none,
            ),
          ),
          child: pw.Text(
            text,
            style: pw.TextStyle(fontSize: 10, font: customFont),
          ),
        ),
      );
    }

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Row(
        children: [
          buildHeaderCell("DESCRIPTION OF WORK/SERVICE", flex: 13),
          buildHeaderCell("SAC CODE", flex: 3),
          buildHeaderCell("QTY", flex: 3),
          buildHeaderCell("RATE", flex: 3),
          buildHeaderCell("AMOUNT", flex: 4, hasRightBorder: false),
        ],
      ),
    );
  }

  pw.SizedBox _pdfBuildEnterServiceDetailsRow(
      pw.Font customFont, pw.Font customBoldFont) {
    final numberFormat =
        NumberFormat('#,##0.00'); // Format with commas and two decimal points

    // Helper function to build table cells
    pw.Widget buildColumnCell(
      List<String> texts, {
      pw.Alignment alignment =
          pw.Alignment.center, // Added alignment parameter with default value
      int flex = 1,
      bool hasRightBorder = true,
      bool hasTopBorder = false, // New parameter for top border
      double height = 20,
    }) {
      return pw.Expanded(
        flex: flex,
        child: pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 2),
          alignment: alignment,
          height: height,
          decoration: pw.BoxDecoration(
            border: pw.Border(
              top: hasTopBorder
                  ? const pw.BorderSide(color: PdfColors.black)
                  : pw.BorderSide.none,
              right: hasRightBorder
                  ? const pw.BorderSide(color: PdfColors.black)
                  : pw.BorderSide.none,
            ),
          ),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: texts
                .map((text) => pw.Text(
                      text,
                      style: pw.TextStyle(
                        font: customFont, // Pass the custom font here

                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    }

    // Calculate total amount
    double totalAmount = _serviceDetails.fold(
      0.0,
      (sum, service) {
        double qty = double.tryParse(service['qty'] ?? '0') ?? 0.0;
        double rate = double.tryParse(service['rate'] ?? '0') ?? 0.0;
        return sum + (qty * rate);
      },
    );

    return pw.SizedBox(
      height: 300, // Fixed height for the container
      child: pw.Row(
        children: [
          // Fixed Description Column
          pw.Expanded(
            flex: 7, // Adjust flex value to control width
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 2),
              height: double.infinity,
              alignment: pw.Alignment.topCenter,
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  right: pw.BorderSide(color: PdfColors.black),
                ),
              ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(2.0),
                child: pw.Container(
                  alignment: pw.Alignment.topCenter,
                  height: double.infinity,
                  width: 200,
                  child: pw.Text(
                    textAlign: pw.TextAlign.center,
                    _description,
                    style: pw.TextStyle(
                        font: customBoldFont, // Pass the custom font here

                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),

          // Dynamic Rows for Service Details
          pw.Expanded(
            flex: 7,
            child: pw.Column(
              children: [
                // Rows for service details
                pw.Expanded(
                  child: pw.Column(
                    children: List.generate(14, (index) {
                      if (index < _serviceDetails.length) {
                        // Use existing service details
                        final service = _serviceDetails[index];
                        double qty =
                            double.tryParse(service['qty'] ?? '0') ?? 0.0;
                        double rate =
                            double.tryParse(service['rate'] ?? '0') ?? 0.0;
                        double amount = qty * rate;

                        return pw.Row(
                          children: [
                            buildColumnCell([service['sacCode'] ?? ''],
                                flex: 3),
                            buildColumnCell([service['qty'] ?? ''], flex: 3),
                            buildColumnCell([service['rate'] ?? ''], flex: 3),
                            buildColumnCell(
                              alignment: pw.Alignment.centerRight,
                              ['₹ ${numberFormat.format(amount)}'],
                              flex: 4,
                              hasRightBorder: true,
                            ),
                          ],
                        );
                      } else {
                        // Empty row
                        return pw.Row(
                          children: [
                            buildColumnCell([''], flex: 3),
                            buildColumnCell([''], flex: 3),
                            buildColumnCell([''], flex: 3),
                            buildColumnCell([''],
                                flex: 4, hasRightBorder: true),
                          ],
                        );
                      }
                    }),
                  ),
                ),
                // Total Amount Row with Top Border only on the final column
                pw.Row(
                  children: [
                    buildColumnCell([''], flex: 3),
                    buildColumnCell([''], flex: 3),
                    buildColumnCell([''], flex: 3),
                    buildColumnCell(
                      alignment: pw.Alignment.centerRight,
                      ['₹ $formattedTotalAmount'],
                      flex: 4,
                      hasRightBorder: true,
                      hasTopBorder: true, // Add top border only here
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<pw.Font> loadCustomFont() async {
    final fontData = await rootBundle.load('assets/fonts/Times New Roman.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<pw.Font> loadBoldCustomFont() async {
    final fontData =
        await rootBundle.load('assets/fonts/Times New Roman Bold.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<pw.Font> loadTNRCustomFont() async {
    final fontData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<void> _generateAndDownloadPdf(BuildContext context) async {
    final customFont = await loadTNRCustomFont();
    final timesNewRoman = await loadCustomFont();
    final boldTimesNewRoman = await loadBoldCustomFont();

    String formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate);

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        // margin: const pw.EdgeInsets.all(10), // Increase margin on all sides

        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30), // Increase margin on all sides
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Container(
              height: 700,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Container(
                        padding: pw.EdgeInsets.all(3),
                        child: pw.Text(
                          'TAX INVOICE',
                          style: pw.TextStyle(
                              fontSize: 11.5,
                              font: timesNewRoman,
                              fontWeight: pw.FontWeight.normal),
                        ),
                      ),
                      pw.Text(
                        'ORIGINAL',
                        style: pw.TextStyle(
                            fontSize: 11.5,
                            font: timesNewRoman,
                            fontWeight: pw.FontWeight.normal),
                      ),
                    ],
                  ),
                  _pdfBuildDetailsContainer(
                    serviceProviderDetails: "DETAILS OF SERVICE PROVIDER",
                    serviceReceiverDetails: "DETAILS OF SERVICE RECEIVER",
                    customFont: boldTimesNewRoman,
                  ),
                  _pdfBuildServiceDetailsRow(
                    serviceProviderDetails: [
                      "NAME:         $_providerName",
                      "ADDRESS:$_providerAddress",
                      "STATE                             $_providerState",
                      "",
                      "STATE CODE                 $_providerStateCode",
                      "GSTIN NO                       $_providerGistinNo",
                      "INVOICE NO                  $_providerInvoiceNo",
                      "INVOICE DATE             $formattedDate",
                    ],
                    // fontSizes: [10,10,10,10],
                    serviceReceiverDetails: [
                      "NAME:                    $_receiverName",
                      "ADDRESS: $_receiverAddress",
                      "STATE                    $_receiverState",
                      "  ",
                      "STATE CODE        $_receiverStateCode",
                      "GSTIN NO              $_receiverGistinNo",
                      "",
                      "PAN NO   ",
                    ],
                    customFont: boldTimesNewRoman,
                  ),
                  _pdfBuildServiceHeaderRow(boldTimesNewRoman),
                  _pdfBuildEnterServiceDetailsRow(
                      customFont, boldTimesNewRoman),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 10,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 2, vertical: 3),
                          width: double.infinity,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.black),
                              top: pw.BorderSide(color: PdfColors.black),
                            ),
                          ),
                          child: pw.Text(
                            "TAX PAYABLE ON REVERSE CHARGE BASIS: NO",
                            style: pw.TextStyle(
                                fontSize: 8.5, font: boldTimesNewRoman),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 16,
                        child: pw.Container(
                          height: 50,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.black),
                              right: pw.BorderSide(color: PdfColors.black),
                            ),
                          ),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Container(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 2),
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  "Total Tax Value (in words)",
                                  style: pw.TextStyle(
                                      fontSize: 11.5, font: timesNewRoman),
                                ),
                              ),
                              pw.Container(
                                  // color: PdfColors.red,
                                  padding: const pw.EdgeInsets.symmetric(
                                      horizontal: 2),
                                  alignment: pw.Alignment.centerLeft,
                                  child: pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          "Rupees",
                                          style: pw.TextStyle(
                                              fontSize: 11.5,
                                              font: timesNewRoman),
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Expanded(
                                          child: pw.Text(
                                            maxLines: 2,
                                            "${convertNumberToWords(_gstAmount)} ",
                                            style: pw.TextStyle(
                                                fontSize: 11.5,
                                                font: boldTimesNewRoman),
                                          ),
                                        )
                                      ])),
                            ],
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          alignment: pw.Alignment.center,
                          height: 50,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.black),
                              right: pw.BorderSide(color: PdfColors.black),
                            ),
                          ),
                          child: pw.Text(
                            "GST@18%",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 10, font: boldTimesNewRoman),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 7,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 2),
                          alignment: pw.Alignment.centerRight,
                          height: 50,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.black),
                            ),
                          ),
                          child: pw.Text(
                            '₹ $formattedGstAmount',
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(
                              font: customFont,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 7,
                        child: pw.Container(
                          height: 50,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.black),
                              right: pw.BorderSide(color: PdfColors.black),
                            ),
                          ),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Container(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 2),
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  "Rupees",
                                  style: pw.TextStyle(
                                      fontSize: 11.5, font: timesNewRoman),
                                ),
                              ),
                              pw.Container(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 2),
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  "${convertNumberToWords(_finalGstAmount)}",
                                  style: pw.TextStyle(
                                      font: boldTimesNewRoman, fontSize: 11.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 4,
                        child: pw.Container(
                          alignment: pw.Alignment.center,
                          height: 50,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.black),
                            ),
                          ),
                          child: pw.Text(
                            "TOTAL INVOICE VALUE",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 11.5, font: timesNewRoman),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 2),
                          alignment: pw.Alignment.centerRight,
                          height: 50,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.black),
                            ),
                          ),
                          child: pw.Text(
                            "₹ $formattedFinalGstAmount",
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(
                              font: customFont,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                        horizontal: 2, vertical: 3),
                    alignment: pw.Alignment.centerLeft,
                    width: double.infinity,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.black),
                      ),
                    ),
                    child: pw.Text(
                      "CERTIFIED THAT THE PARTICULARS GIVEN ABOVE ARE TRUE AND CORRECT",
                      style:
                          pw.TextStyle(fontSize: 8.5, font: boldTimesNewRoman),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 2, vertical: 4),
                          alignment: pw.Alignment.topRight,
                          child: pw.Text(
                            "For $_providerName",
                            style:
                                pw.TextStyle(fontSize: 10, font: timesNewRoman),
                          ),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 2, vertical: 4),
                          alignment: pw.Alignment.bottomRight,
                          child: pw.Text(
                            "AUTHORISED SIGNATURE",
                            style:
                                pw.TextStyle(fontSize: 9, font: timesNewRoman),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.only(left: 50),
                alignment: pw.Alignment.centerLeft,
                child: pw.Text("Note .This is computer generated invoice",
                    style: pw.TextStyle(fontSize: 10, font: timesNewRoman))),
          ]);
        },
      ),
    );

    // Save PDF file or share
    // Replace spaces with underscores
    final now = DateTime.now();
    final formattedDateTime =
        '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}';
    final fileName = '_Invoice_$formattedDateTime.pdf';

    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to $filePath')),
      );

      // Optionally, share the PDF
      await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
    } catch (e) {
      print("Error saving PDF: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(style: TextStyle(fontSize: 20), 'Invoice'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              double containerWidth = MediaQuery.of(context).size.width * 0.45;
              double containerHeight = MediaQuery.of(context).size.height * 0.8;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildContainer(
                    context,
                    containerWidth,
                    containerHeight,
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                style: TextStyle(
                                    fontSize: 10, fontFamily: "timesNewRoman"),
                                'TAX INVOICE',
                              ),
                              Text(
                                style: TextStyle(
                                    fontSize: 10, fontFamily: "timesNewRoman"),
                                'ORIGINAL',
                              ),
                            ],
                          ),
                          _buildDetailsContainer(
                            serviceProviderDetails:
                                "Details Of Service Provider",
                            serviceReceiverDetails:
                                "Details Of Service Receiver",
                          ),
                          _buildServiceDetailsRow(
                            serviceProviderDetails: [
                              "NAME:         $_providerName",
                              "ADDRESS:$_providerAddress",
                              "STATE                     $_providerState",
                              "STATE CODE                  $_providerStateCode",
                              "GSTIN NO                    $_providerGistinNo",
                              "INVOICE NO                    $_providerInvoiceNo",
                              "INVOICE DATE              $formattedDate",
                            ],
                            serviceReceiverDetails: [
                              "NAME:                    $_receiverName",
                              "ADDRESS: $_receiverAddress",
                              "STATE                   $_receiverState",
                              "STATE CODE       $_receiverStateCode",
                              "GSTIN NO              $_receiverGistinNo",
                              "PAN NO   ",
                            ],
                          ),
                          _buildServiceHeaderRow(),
                          _buildEnterServiceDetailsRow(),
                          Row(
                            children: [
                              Flexible(
                                  flex: 10,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom:
                                                BorderSide(color: Colors.black),
                                            top: BorderSide(
                                                color: Colors.black))),
                                    child: const Text(
                                      "TAX PAYABLE ON REVERSE CHARGE BASIS: NO",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 9,
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom:
                                                BorderSide(color: Colors.black),
                                            right: BorderSide(
                                                color: Colors.black))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                            "Total Tax Value (in words)",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "${convertNumberToWords(_gstAmount)} Rupees",
                                              style: const TextStyle(
                                                  fontSize: 10)),
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text("GST@18%",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 10)))),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  child: Text(
                                    '₹ $formattedGstAmount',
                                    // Display total with GST
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom:
                                                BorderSide(color: Colors.black),
                                            right: BorderSide(
                                                color: Colors.black))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                            "Rupees",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "${convertNumberToWords(_finalGstAmount)} Rupees",
                                              style: const TextStyle(
                                                  fontSize: 10)),
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                      child: const Text("TOTAL INVOICE VALUE",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 11)))),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: Text("₹ $formattedFinalGstAmount",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold)))),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Text(
                              "CERTIFIED THAT THE PARTICULARS GIVEN AROVE ARE TRUE AND CORRECT",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "For $_providerName",
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: const Text(
                                    "AUTHORISED SIGNATURE",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  buildContainer(
                    context,
                    containerWidth,
                    containerHeight,
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200,
                                child: ElevatedButton.icon(
                                  onPressed: () => _selectDate(context),
                                  icon: const Icon(Icons.date_range,
                                      color: Colors.white),
                                  label: const Text(
                                    'Select Date',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: Colors.teal,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white),
                                  child: Text("Invoice Date : $formattedDate "))
                            ],
                          ),
                          const SizedBox(height: 15),

                          const Divider(
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 15),
                          // Row for "Description of Work/Service"
                          Container(
                            // color: Colors.red,
                            height: 250,
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                    // color: Colors.red,
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            // width: MediaQuery.of(context).size.width *
                                            //     0.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.17,
                                            child: InvoiceTextField(
                                              labelText: '',
                                              hintText:
                                                  'Description of Work/Service',
                                              controller:
                                                  _descriptionController,
                                            )),
                                        // SizedBox(height: 10,),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton.icon(
                                            onPressed: _addDescription,
                                            icon: const Icon(Icons.add,
                                                color: Colors.white),
                                            label: const Text(
                                              'Add Description',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              backgroundColor: Colors.teal,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    // color: Colors.red,
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          // width: 150,
                                          child: InvoiceTextField(
                                            labelText: 'SAC Code',
                                            controller: _sacCodeController,
                                            hintText: 'SAC Code',
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05, // width: 150,
                                          child: InvoiceTextField(
                                            labelText: 'QTY',
                                            controller: _qtyController,
                                            hintText: 'QTY',
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05, // width: 150,
                                          child: InvoiceTextField(
                                            labelText: 'Rate',
                                            controller: _rateController,
                                            hintText: 'Rate',
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton.icon(
                                            onPressed: _addServiceDetails,
                                            // onPressed: _addServiceDetails,
                                            icon: const Icon(Icons.add,
                                                color: Colors.white),
                                            label: const Text(
                                              'Add ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              backgroundColor: Colors.teal,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
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
                          const SizedBox(height: 15),
                          const Divider(
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 15),

                          const Text(
                            "Provider Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width: 150,
                                  child: InvoiceTextField(
                                    labelText: 'Provider Name',
                                    controller: _providerNameController,
                                    hintText: 'Provider Name',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: _addProviderName,
                                    // onPressed: _addServiceDetails,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      'Add ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width: 150,
                                  child: InvoiceTextField(
                                    labelText: 'Provider Address',
                                    controller: _providerAddressController,
                                    hintText: 'Provider Address',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: _addProviderAddress,
                                    // onPressed: _addServiceDetails,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      'Add ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width: 150,
                                  child: InvoiceTextField(
                                    labelText: 'Provider State',
                                    controller: _providerStateController,
                                    hintText: 'Provider State',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: _addProviderState,
                                    // onPressed: _addServiceDetails,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      'Add ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width: 150,
                                  child: InvoiceTextField(
                                    labelText: 'Provider State Code',
                                    controller: _providerStateCodeController,
                                    hintText: 'Provider State Code',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: _addProviderStateCode,
                                    // onPressed: _addServiceDetails,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      'Add ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width: 150,
                                  child: InvoiceTextField(
                                    labelText: 'Provider GISTIN No',
                                    controller: _providerGistinNOController,
                                    hintText: 'Provider GISTIN No',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: _addProviderGistinNo,
                                    // onPressed: _addServiceDetails,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      'Add ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width: 150,
                                  child: InvoiceTextField(
                                    labelText: 'Provider Invoice No',
                                    controller: _providerInvoiceNoController,
                                    hintText: 'Provider Invoice No',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: _addProviderInvoiceNo,
                                    // onPressed: _addServiceDetails,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      'Add ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          const Divider(
                            color: Colors.grey,
                          ),

                          const Text(
                            "Receiver Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width: 150,
                                  child: InvoiceTextField(
                                    labelText: 'Receiver Name',
                                    controller: _receiverNameController,
                                    hintText: 'Receiver Name',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: _addReceiverName,
                                    // onPressed: _addServiceDetails,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      'Add ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width: 150,
                                  child: InvoiceTextField(
                                    labelText: 'Receiver Address',
                                    controller: _receiverAddressController,
                                    hintText: 'Receiver Address',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: _addReceiverAddress,
                                    // onPressed: _addServiceDetails,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      'Add ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width: 150,
                                  child: InvoiceTextField(
                                    labelText: 'Receiver State',
                                    controller: _receiverStateController,
                                    hintText: 'Receiver State',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: _addReceiverState,
                                    // onPressed: _addServiceDetails,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      'Add ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width: 150,
                                  child: InvoiceTextField(
                                    labelText: 'Receiver State Code',
                                    controller: _receiverStateCodeController,
                                    hintText: 'Receiver State Code',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: _addReceiverStateCode,
                                    // onPressed: _addServiceDetails,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      'Add ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width: 150,
                                  child: InvoiceTextField(
                                    labelText: 'Receiver GISTIN No',
                                    controller: _receiverGistinNOController,
                                    hintText: 'Receiver GISTIN No',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: _addReceiverGistinNo,
                                    // onPressed: _addServiceDetails,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      'Add ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // const SizedBox(height: 10),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       flex: 5,
                          //       child: SizedBox(
                          //         height:
                          //             MediaQuery.of(context).size.height * 0.06,
                          //         width: 150,
                          //         child: InvoiceTextField(
                          //           labelText: 'Receiver Invoice No',
                          //           controller: _receiverInvoiceNoController,
                          //           hintText: 'Receiver Invoice No',
                          //         ),
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       width: 10,
                          //     ),
                          //     Expanded(
                          //       flex: 2,
                          //       child: SizedBox(
                          //         height: 45,
                          //         child: ElevatedButton.icon(
                          //           onPressed: _addReceiverInvoiceNo,
                          //           // onPressed: _addServiceDetails,
                          //           icon: const Icon(Icons.add,
                          //               color: Colors.white),
                          //           label: const Text(
                          //             'Add ',
                          //             style: TextStyle(
                          //                 fontSize: 14, color: Colors.white),
                          //           ),
                          //           style: ElevatedButton.styleFrom(
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius:
                          //                     BorderRadius.circular(5)),
                          //             backgroundColor: Colors.teal,
                          //             padding: const EdgeInsets.symmetric(
                          //                 vertical: 15),
                          //             textStyle: const TextStyle(fontSize: 16),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _generateAndDownloadPdf(context),
                icon: const Icon(Icons.download, color: Colors.white),
                label: const Text(
                  'Download PDF',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnterServiceDetailsRow() {
    final numberFormat =
        NumberFormat('#,##0.00'); // Format with commas and two decimal points

    // Helper function to build table cells
    Widget buildColumnCell(
      List<String> texts, {
      Alignment alignment =
          Alignment.center, // Added alignment parameter with default value

      int flex = 1,
      bool hasRightBorder = true,
      bool hasTopBorder = false, // New parameter for top border
      double height = 20,
    }) {
      return Expanded(
        flex: flex,
        child: Container(
          alignment: alignment,
          height: height,
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              top: hasTopBorder
                  ? const BorderSide(color: Colors.black)
                  : BorderSide.none,
              right: hasRightBorder
                  ? const BorderSide(color: Colors.black)
                  : BorderSide.none,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: texts
                .map((text) => Text(
                      text,
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ))
                .toList(),
          ),
        ),
      );
    }

    // Calculate total amount
    double totalAmount = _serviceDetails.fold(
      0.0,
      (sum, service) {
        double qty = double.tryParse(service['qty'] ?? '0') ?? 0.0;
        double rate = double.tryParse(service['rate'] ?? '0') ?? 0.0;
        return sum + (qty * rate);
      },
    );

    return SizedBox(
      height: 200, // Fixed height for the container
      child: Row(
        children: [
          // Fixed Description Column
          Expanded(
            flex: 7, // Adjust flex value to control width
            child: Container(
              height: double.infinity,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: double.infinity,
                  width: 200,
                  child: Text(
                    textAlign: TextAlign.center,
                    _description,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),

          // Dynamic Rows for Service Details
          Expanded(
            flex: 7,
            child: Column(
              children: [
                // Rows for service details
                Expanded(
                  child: Column(
                    children: List.generate(9, (index) {
                      if (index < _serviceDetails.length) {
                        // Use existing service details
                        final service = _serviceDetails[index];
                        double qty =
                            double.tryParse(service['qty'] ?? '0') ?? 0.0;
                        double rate =
                            double.tryParse(service['rate'] ?? '0') ?? 0.0;
                        double amount = qty * rate;

                        return Row(
                          children: [
                            buildColumnCell([service['sacCode'] ?? ''],
                                flex: 2),
                            buildColumnCell([service['qty'] ?? ''], flex: 2),
                            buildColumnCell([service['rate'] ?? ''], flex: 1),
                            buildColumnCell(
                              alignment: Alignment.centerRight,
                              ['₹ ${numberFormat.format(amount)}'],
                              flex: 2,
                              hasRightBorder: true,
                            ),
                          ],
                        );
                      } else {
                        // Empty row
                        return Row(
                          children: [
                            buildColumnCell([''], flex: 2),
                            buildColumnCell([''], flex: 2),
                            buildColumnCell([''], flex: 1),
                            buildColumnCell([''],
                                flex: 2, hasRightBorder: true),
                          ],
                        );
                      }
                    }),
                  ),
                ),
                // Total Amount Row with Top Border only on the final column
                Row(
                  children: [
                    buildColumnCell([''], flex: 2),
                    buildColumnCell([''], flex: 2),
                    buildColumnCell([''], flex: 1),
                    buildColumnCell(
                      alignment: Alignment.centerRight,
                      ['₹ $formattedTotalAmount'],
                      flex: 2,
                      hasRightBorder: true,
                      hasTopBorder: true, // Add top border only here
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildColumnDescriptionCell(
    String text, {
    bool hasRightBorder = true,
    double height = 200,
  }) {
    return Expanded(
      flex: 7,
      child: Container(
          alignment: Alignment.topCenter,
          height: height,
          decoration: BoxDecoration(
            // color: Colors.blue,
            border: Border(
              right: hasRightBorder
                  ? const BorderSide(color: Colors.black)
                  : BorderSide.none,
            ),
          ),
          child: SizedBox(
            height: 200,
            width: 200,
            // color: Colors.green,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Widget buildColumnAmountCell(
    String text, {
    bool hasRightBorder = true,
    double height = 200,
  }) {
    return Expanded(
      flex: 7,
      child: Container(
          alignment: Alignment.topCenter,
          height: height,
          decoration: BoxDecoration(
            // color: Colors.blue,
            border: Border(
              right: hasRightBorder
                  ? const BorderSide(color: Colors.black)
                  : BorderSide.none,
            ),
          ),
          child: SizedBox(
            height: 200,
            width: 200,
            // color: Colors.green,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Widget _buildDetailsContainer({
    required String serviceProviderDetails,
    required String serviceReceiverDetails,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black),
                ),
              ),
              child: Text(
                serviceProviderDetails,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              serviceReceiverDetails,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetailsRow({
    required List<String> serviceProviderDetails,
    required List<String> serviceReceiverDetails,
  }) {
    Widget buildDetailsColumn(List<String> details) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: details.map((detail) {
          return Text(
            maxLines: 2,
            detail,
            style: const TextStyle(fontSize: 10),
          );
        }).toList(),
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.black),
              ),
            ),
            child: buildDetailsColumn(serviceProviderDetails),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            child: buildDetailsColumn(serviceReceiverDetails),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceHeaderRow() {
    Widget buildHeaderCell(String text,
        {bool hasRightBorder = true, int flex = 1}) {
      return Expanded(
        flex: flex,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              right: hasRightBorder
                  ? const BorderSide(color: Colors.black)
                  : BorderSide.none,
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          buildHeaderCell("DESCRIPTION OF WORK/SERVICE", flex: 7),
          buildHeaderCell("SAC CODE", flex: 2),
          buildHeaderCell("QTY", flex: 2),
          buildHeaderCell("RATE", flex: 1),
          buildHeaderCell("AMOUNT", flex: 2, hasRightBorder: false),
        ],
      ),
    );
  }
}

Widget buildContainer(
    BuildContext context, double width, double height, Widget child) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(2, 4))
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    ),
  );
}
