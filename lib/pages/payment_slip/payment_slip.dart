import 'dart:io';
import 'package:EzeePayslip/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../new_custom_screen.dart';

class PaymentSlip extends StatefulWidget {
  final String employeeCode;
  final String name;
  final String bankName;
  final String bankAccountNo;
  final String dateOfBirth;
  final String grade;
  final String pfAccountNo;
  final String universalAccountNo;
  final String esi;
  final String workingDays;
  final String weeklyOff;
  final String leaveDay;
  final String ph;
  final String basicWagesRate;

  final String basicWagesAmount;
  final String arrearBasicWages;
  final String hraRate;
  final String arrearHraAmount;

  final String prfRate;
  final String prfAmount;
  final String washRate;
  final String washAmount;
  final String sheRate;
  final String sheAmount;
  final String medRate;
  final String medAmount;
  final String specialRate;
  final String specialAmount;
  final String skillRate;
  final String skillAmount;
  final String tiffinReimRate;
  final String tiffinReimAmount;

  final String arearOtherAmount;
  final String educationAmount;
  final String heavyDutyAmount;
  final String attAmount;
  final String misclEarning;
  final String overtimeAmount;
  final String leaveEncashment;
  final String pmgkyBenifit;
  final String otDays;
  final String otDaysAmounts;

  final String gpa;
  final String unionFund;
  final String contractLabourChildrenwelfarefund;
  final String canteen;
  final String wagesAdvance;
  final String arrearProfessionaltax;
  final String cmRelifeFund;
  final String medicalClaim;
  final String benvolentFund;
  final String incomeTax;
  final String loanRecovery;
  final String pfLoanInterest;
  final String misclDedn;
  final String labourWelfareFund;

  final String hraAmount;
  final String tiffinAllowanceRate;
  final String tiffinAllowanceAmount;
  final String otherAllowanceRate;
  final String otherAllowanceAmount;
  final String providentFund;
  final String professionalTax;
  final String employeeStateInsurance;
  final String grossEarning;
  final String grossDeduction;
  final String netSalary;
  final String netSalaryInWord;

  final String month;
  final int year;

  const PaymentSlip(
      {super.key,
        required this.employeeCode,
        required this.name,
        required this.bankName,
        required this.bankAccountNo,
        required this.dateOfBirth,
        required this.grade,
        required this.universalAccountNo,
        required this.esi,
        required this.workingDays,
        required this.weeklyOff,
        required this.leaveDay,
        required this.ph,
        required this.basicWagesRate,
        required this.basicWagesAmount,
        required this.hraRate,
        required this.hraAmount,
        required this.tiffinAllowanceRate,
        required this.tiffinAllowanceAmount,
        required this.otherAllowanceRate,
        required this.otherAllowanceAmount,
        required this.providentFund,
        required this.professionalTax,
        required this.employeeStateInsurance,
        required this.grossEarning,
        required this.grossDeduction,
        required this.netSalary,
        required this.netSalaryInWord,
        required this.prfRate,
        required this.prfAmount,
        required this.washRate,
        required this.washAmount,
        required this.sheRate,
        required this.sheAmount,
        required this.medRate,
        required this.medAmount,
        required this.specialRate,
        required this.specialAmount,
        required this.skillRate,
        required this.skillAmount,
        required this.tiffinReimRate,
        required this.tiffinReimAmount,
        required this.arearOtherAmount,
        required this.educationAmount,
        required this.heavyDutyAmount,
        required this.attAmount,
        required this.misclEarning,
        required this.overtimeAmount,
        required this.leaveEncashment,
        required this.pmgkyBenifit,
        required this.otDays,
        required this.gpa,
        required this.unionFund,
        required this.contractLabourChildrenwelfarefund,
        required this.canteen,
        required this.wagesAdvance,
        required this.arrearProfessionaltax,
        required this.cmRelifeFund,
        required this.medicalClaim,
        required this.benvolentFund,
        required this.incomeTax,
        required this.loanRecovery,
        required this.pfLoanInterest,
        required this.misclDedn,
        required this.labourWelfareFund,
        required this.otDaysAmounts,
        required this.month,
        required this.year,
        required this.arrearBasicWages,
        required this.arrearHraAmount, required this.pfAccountNo});

  @override
  State<PaymentSlip> createState() => _PaymentSlipState();
}

class _PaymentSlipState extends State<PaymentSlip> {
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

    // Handle lakhs
    if (number >= 100000) {
      words += '${ones[(number ~/ 100000).toInt()]} Lakh ';
      number %= 100000;
    }

    // Handle ten thousands and thousands
    if (number >= 20000) {
      words += '${tens[(number ~/ 10000).toInt()]} ';
      number %= 10000;
      words += '${ones[(number ~/ 1000).toInt()]} Thousand ';
      number %= 1000;
    } else if (number >= 1000) {
      // For numbers between 1000 and 19999
      words += '${ones[(number ~/ 1000).toInt()]} Thousand ';
      number %= 1000;
    }

    // Handle hundreds
    if (number >= 100) {
      words += '${ones[(number ~/ 100).toInt()]} Hundred ';
      number %= 100;
    }

    // Handle tens
    if (number >= 20) {
      words += '${tens[(number ~/ 10).toInt()]} ';
      number %= 10;
    }

    // Handle ones (and numbers less than 20)
    if (number > 0 && number < 20) {
      words += '${ones[number.toInt()]} ';
    }

    return words.trim();
  }

  pw.Widget _earningRow(
      String title1,
      String title2,
      String title3,
      String title4,
      String title5,
      // String title2,
      // String value2,
      ) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              flex: 6,
              child: pw.Container(
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(width: 0.5, color: PdfColors.grey)),
                child: pw.Text(
                  title1,
                  style:
                  pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            pw.Expanded(
              flex: 3,
              child: pw.Container(
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                        top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                        right: pw.BorderSide(width: 0.5,color: PdfColors.grey))),
                child: pw.Text(
                  title2,
                  style:
                  pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            pw.Expanded(
              flex: 4,
              child: pw.Container(
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                        top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                        // bottom: BorderSide(color: Colors.grey),
                        right: pw.BorderSide(width: 0.5,color: PdfColors.grey))),
                child: pw.Text(
                  title3,
                  style:
                  pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            pw.Expanded(
              flex: 9,
              child: pw.Container(
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                        top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                        // bottom: BorderSide(color: Colors.grey),
                        right: pw.BorderSide(width: 0.5,color: PdfColors.grey))),
                child: pw.Text(
                  title4,
                  style:
                  pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            pw.Expanded(
              flex: 4,
              child: pw.Container(
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                        top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                        // bottom: BorderSide(color: Colors.grey),
                        right: pw.BorderSide(width: 0.5,color: PdfColors.grey))),
                child: pw.Text(
                  title5,
                  style:
                  pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _earningPaymentRow(String title1, String title2, String title3) {
    // Convert title2 and title3 to double and check if they are zero
    final double value2 = double.tryParse(title2) ?? 0;
    final double value3 = double.tryParse(title3) ?? 0;

    // If both values are 0, return an empty widget to skip rendering this row
    if (value2 == 0 && value3 == 0) {
      return pw.SizedBox();
    }
    return pw.Container(
      // decoration: const pw.BoxDecoration(
      //     border: pw.Border(
      //       bottom: pw.BorderSide(width: 0.5,color: PdfColors.red),
      //     )),
      // margin: pw.EdgeInsets.only(left: 2),
      // color: PdfColors.red,
      width: 277.65, // Ensures that the width is bounded
      child: pw.Row(
        children: [
          pw.Flexible(
            flex: 6,
            child: pw.Container(
              padding: const pw.EdgeInsets.only(left: 2),
              alignment: pw.Alignment.centerLeft,
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    // left: pw.BorderSide(width: 0.5,color: PdfColors.red),
                  )),
              child: pw.Text(
                title1,
                style: const pw.TextStyle(
                  fontSize: 9,
                ),
              ),
            ),
          ),
          pw.Flexible(
            flex: 3,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                title2,
                style: const pw.TextStyle(
                  fontSize: 9,
                ),
              ),
            ),
          ),
          pw.Flexible(
            flex: 4,
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 2),

              alignment: pw.Alignment.centerRight,
              decoration: const pw.BoxDecoration(
                  border:
                  pw.Border(right: pw.BorderSide(width: 0.5,color: PdfColors.grey,))),
              child: pw.Text(
                title3,
                style: const pw.TextStyle(
                  fontSize: 9,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _deductionPaymentRow(String title4, String title5) {
    final double value5 = double.tryParse(title5) ?? 0;

    // If both values are 0, return an empty widget to skip rendering this row
    if (value5 == 0) {
      return pw.SizedBox();
    }
    return pw.Container(
      // color: PdfColors.blue,
      width: 277.5, // Ensures that the width is bounded
      child: pw.Row(
        children: [
          pw.Flexible(
            flex: 9,
            child: pw.Container(
              padding: const pw.EdgeInsets.only(left: 2),
              alignment: pw.Alignment.centerLeft,
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    // left: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                  )),
              child: pw.Text(
                title4,
                style: const pw.TextStyle(
                  fontSize: 9,
                ),
              ),
            ),
          ),
          pw.Flexible(
            flex: 4,
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 2),
              alignment: pw.Alignment.centerRight,
              // decoration: const pw.BoxDecoration(
              //     border:
              //         pw.Border(right: pw.BorderSide(width: 0.5,color: PdfColors.grey))),
              child: pw.Text(
                title5,
                style: const pw.TextStyle(
                  fontSize: 9,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _grossEarningRow(
      String title1,
      String title2,
      String title3,
      String title4,
      ) {
    return pw.Container(
        margin: const pw.EdgeInsets.all(1),
        decoration: pw.BoxDecoration(
            border: pw.Border.all(width: 0.5, color: PdfColors.grey)),
        child: pw.Row(
          children: [
            pw.Expanded(
              flex: 9,
              child: pw.Container(
                // width: MediaQuery.of(context).size.width*0.2,
                padding: const pw.EdgeInsets.only(left: 2),

                decoration: const pw.BoxDecoration(
                    border:
                    pw.Border(right: pw.BorderSide(width: 0.5,color: PdfColors.grey))),
                child: pw.Text(
                  title1,
                  style: pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Container(width: 10),
            // Container(width: 10),
            pw.Expanded(
              flex: 4,
              child: pw.Container(
                alignment: pw.Alignment.centerRight,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      // bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                      // top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                        right: pw.BorderSide(width: 0.5,color: PdfColors.grey))),
                child: pw.SizedBox(
                  // color: Colors.grey,
                  child: pw.Text(
                    title2,
                    style: pw.TextStyle(
                      fontSize: 9,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Container(width: 10),
            pw.Expanded(
              flex: 9,
              child: pw.Container(
                padding: const pw.EdgeInsets.only(left: 2),
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      // bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                      // top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                        right: pw.BorderSide(width: 0.5,color: PdfColors.grey))),
                child: pw.SizedBox(
                  // color: Colors.blueAccent,
                  child: pw.Text(
                    title3,
                    style: pw.TextStyle(
                      fontSize: 9,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Container(width: 10),
            pw.Expanded(
              flex: 4,
              child: pw.Container(
                alignment: pw.Alignment.centerRight,

                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      // bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                      // top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                      // right: pw.BorderSide(width: 0.5,color: PdfColors.grey)
                    )),
                // color: Colors.orange,
                child: pw.Text(
                  title4,
                  style: pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Container(width: 10),
          ],
        ));
  }


  int parseAndRoundNetSalary(double value) {
    // Round up to the next integer and return as int
    return value.ceil();
  }

// Function to generate the net salary row in the PDF
  pw.Widget _netSalaryRow(String title1, double netSalary) {
    final int roundedNetSalary = parseAndRoundNetSalary(netSalary);
    final String formattedRoundedNetSalary = roundedNetSalary.toStringAsFixed(2); // Format with two decimal places


    return pw.Row(
      children: [
        pw.Flexible(
          flex: 6,
          child: pw.Container(
            padding: const pw.EdgeInsets.only(left: 2),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                // bottom: pw.BorderSide(width: 0.5,color: PdfColors.orange),
                // left: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                // right: pw.BorderSide(width: 0.5,color: PdfColors.grey),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Text(
                  title1,
                  style: pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 2),
                  child: pw.Text(
                    formattedRoundedNetSalary, // Display rounded net salary
                    style: pw.TextStyle(
                      fontSize: 9,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

// Function to display the salary in words in the PDF
  pw.Widget _amountInWord(String title1, double netSalary) {
    // Parse and round the net salary as an integer

    final int roundedNetSalary = parseAndRoundNetSalary(netSalary);

    return pw.Padding(
      padding: const pw.EdgeInsets.only(left: 2),
      child: pw.Row(
        children: [
          pw.Flexible(
            flex: 6,
            child: pw.Container(
              child: pw.Row(
                children: [
                  pw.Text(
                    title1,
                    style: pw.TextStyle(
                      fontSize: 9,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 2),
                    child: pw.Text(
                      "(Rupee(s) ${convertNumberToWords(roundedNetSalary.toDouble())} only)",
                      // Convert to double here
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.black,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPdfRowWithFourColumns(
      String title,
      String title1,
      String value1,
      String title2,
      String value2,
      String title3,
      String value3,
      String title4,
      String value4,
      ) {
    return pw.Row(
      children: [
        pw.Expanded(
          flex: 7,
          child: pw.Container(
            padding: const pw.EdgeInsets.only(left: 2),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                  right: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                  top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                  bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                  left: pw.BorderSide(width: 0.5,color: PdfColors.grey)),
            ),
            child: pw.Text(
              title,
              style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ),
        pw.Expanded(
          flex: 8,
          child: pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                right: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  "$title1: ",
                  style:
                  pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(value1, style: const pw.TextStyle(fontSize: 9)),
              ],
            ),
          ),
        ),
        pw.Expanded(
          flex: 6,
          child: pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                right: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  "$title2: ",
                  style:
                  pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(value2, style: const pw.TextStyle(fontSize: 9)),
              ],
            ),
          ),
        ),
        pw.Expanded(
          flex: 4,
          child: pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                right: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  "$title3: ",
                  style:
                  pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(value3, style: const pw.TextStyle(fontSize: 9)),
              ],
            ),
          ),
        ),
        pw.Expanded(
            flex: 5,
            child: pw.Container(
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    right: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                    top: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                    bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey),
                  )),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    "$title4: ",
                    style: pw.TextStyle(
                        fontSize: 9, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(value4, style: const pw.TextStyle(fontSize: 9)),
                ],
              ),
            )),
      ],
    );
  }

  pw.Widget _buildRow(
      String title1,
      String value1,
      String title2,
      String value2,
      ) {
    return pw.Container(
        child: pw.Column(
          children: [
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.only(left: 2),
                        child: pw.Text(
                          title1,
                          style: pw.TextStyle(
                            fontSize: 9,
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      if (title1.isNotEmpty) ...[
                        pw.SizedBox(
                          child: pw.Text(
                            ":",
                            style: const pw.TextStyle(
                                fontSize: 9, color: PdfColors.black),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                pw.Container(width: 10),
                pw.Expanded(
                    flex: 8,
                    child: pw.Row(
                      children: [
                        pw.SizedBox(
                          child: pw.Text(
                            value1,
                            style: const pw.TextStyle(
                                fontSize: 9, color: PdfColors.black),
                          ),
                        ),
                      ],
                    )),
                pw.Container(width: 10),
                pw.Expanded(
                  flex: 4,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(
                        child: pw.Text(
                          title2,
                          style: pw.TextStyle(
                            fontSize: 9,
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      if (title2.isNotEmpty) ...[
                        pw.SizedBox(
                          child: pw.Text(
                            ":",
                            style: const pw.TextStyle(
                                fontSize: 9, color: PdfColors.black),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                pw.Container(width: 10),
                pw.Expanded(
                  flex: 3,
                  child: pw.SizedBox(
                    child: pw.Text(
                      value2,
                      style:
                      const pw.TextStyle(fontSize: 9, color: PdfColors.black),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }

  // String netSalaryInWords = NumberToWord().convert(int.parse(widget.netSalary.replaceAll(',', '')));

  Future<void> _generateAndDownloadPdf(BuildContext context) async {
    final pdf = pw.Document();


    final double netSalary = double.parse(widget.netSalary.toString());
    final int roundedNetSalary = parseAndRoundNetSalary(netSalary);

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(20), // Increase margin on all sides

        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                // color: PdfColors.blue,
                  child: pw.Column(children: [
                    pw.Text('SATYAM CONSTRUCTION',
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    pw.Text('BHANDARA',
                        style: const pw.TextStyle(
                            fontSize: 9, color: PdfColors.black)),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          const pw.TextSpan(
                              text: 'Pay Slip for the month of : ',
                              style: pw.TextStyle(
                                  color: PdfColors.black, fontSize: 9)),
                          pw.TextSpan(
                              text: widget.month,
                              style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 9,
                                  fontWeight: pw.FontWeight.bold)),
                          const pw.TextSpan(
                              text: ' - ',
                              style: pw.TextStyle(
                                  color: PdfColors.black, fontSize: 9)),
                          pw.TextSpan(
                              text: widget.year.toString(),
                              style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 9,
                                  fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                    ),
                  ])),
              // Header Section

              pw.SizedBox(height: 10),

              pw.Container(
                // decoration: pw.BoxDecoration(
                //     border: pw.Border.all(width:0.5,color: PdfColors.blue)
                //     ),
                // color: PdfColors.red,
                  child: pw.Column(children: [
                    pw.Container(
                        decoration: pw.BoxDecoration(
                            border:
                            pw.Border.all(width: 0.5, color: PdfColors.grey)),
                        child: pw.Column(children: [
                          _buildRow("Employee Code", widget.employeeCode,
                              "PF Account No.", widget.pfAccountNo),
                          _buildRow("Name", widget.name, "Date Of Birth",
                              widget.dateOfBirth),
                          _buildRow("Bank Name", widget.bankName, "Bank A/C No.",
                              widget.bankAccountNo),
                          _buildRow("Grade", widget.grade, "Universal Account No.",
                              widget.universalAccountNo),
                          _buildRow("ESI No", widget.esi, "", ""),
                        ])),
                    pw.SizedBox(height: 10),
                    _buildPdfRowWithFourColumns(
                        "Attendance Details:",
                        "Working Days",
                        widget.workingDays,
                        "Weekly Off",
                        widget.weeklyOff,
                        "Leave Days",
                        widget.leaveDay,
                        "PH",
                        widget.ph),
                    pw.SizedBox(height: 10),
                    _earningRow(
                      "Earning",
                      "Rate",
                      "Amount",
                      "Deduction",
                      "Amount",
                    ),
                    pw.Container(
                        decoration: pw.BoxDecoration(
                            border:
                            pw.Border.all(width: 0.5, color: PdfColors.grey)),
                        // alignment: pw.Alignment.topCenter,
                        child: pw.Column(children: [
                          pw.Container(
                            decoration: const pw.BoxDecoration(
                                border: pw.Border(bottom: pw.BorderSide(width: 0.5,color: PdfColors.grey,))),
                            child: pw.Row(
                              // mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Column(children: [
                                    _earningPaymentRow(
                                      "Basic wages",
                                      widget.basicWagesRate,
                                      widget.basicWagesAmount,
                                    ),
                                    _earningPaymentRow(
                                      "Arrear Basic wages",
                                      "",
                                      widget.arrearBasicWages,
                                    ),
                                    _earningPaymentRow(
                                      "HRA",
                                      widget.hraRate,
                                      widget.hraAmount,
                                    ),
                                    _earningPaymentRow(
                                      "Arrear HRA",
                                      "",
                                      widget.arrearHraAmount,
                                    ),
                                    _earningPaymentRow("Perf All",
                                        widget.prfRate, widget.prfAmount),
                                    _earningPaymentRow("Wash All",
                                        widget.washRate, widget.washAmount),
                                    _earningPaymentRow("SHE All",
                                        widget.sheRate, widget.sheAmount),
                                    _earningPaymentRow("Med All",
                                        widget.medRate, widget.medAmount),
                                    _earningPaymentRow("Special All",
                                        widget.specialRate, widget.specialAmount),
                                    _earningPaymentRow("Skill All",
                                        widget.skillRate, widget.skillAmount),
                                    _earningPaymentRow(
                                      "Tiffin Allowance",
                                      widget.tiffinAllowanceRate,
                                      widget.tiffinAllowanceAmount,
                                    ),
                                    _earningPaymentRow(
                                        "Tiffin Reim",
                                        widget.tiffinReimRate,
                                        widget.tiffinReimAmount),
                                    _earningPaymentRow(
                                      "Other All",
                                      widget.otherAllowanceRate,
                                      widget.otherAllowanceAmount,
                                    ),
                                    _earningPaymentRow(
                                      "Arear Other All",
                                      '',
                                      widget.arearOtherAmount,
                                    ),
                                    _earningPaymentRow(
                                      "Education All",
                                      "",
                                      widget.educationAmount,
                                    ),
                                    _earningPaymentRow(
                                      "Heavy Duty All",
                                      "",
                                      widget.heavyDutyAmount,
                                    ),
                                    _earningPaymentRow(
                                      "Att All",
                                      "",
                                      widget.attAmount,
                                    ),
                                    _earningPaymentRow(
                                      "MISCL Earning",
                                      "",
                                      widget.misclEarning,
                                    ),
                                    _earningPaymentRow(
                                      "Overtime",
                                      "",
                                      widget.overtimeAmount,
                                    ),
                                    _earningPaymentRow(
                                      "Leave Encashment",
                                      "",
                                      widget.leaveEncashment,
                                    ),
                                    _earningPaymentRow(
                                      "PMGKY Benifit",
                                      "",
                                      widget.pmgkyBenifit,
                                    ),
                                    _earningPaymentRow(
                                      "Overtime",
                                      "",
                                      widget.otDaysAmounts,
                                    ),
                                  ]),
                                  pw.Column(
                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                      children: [
                                        _deductionPaymentRow(
                                          "Provident Fund",
                                          widget.providentFund,
                                        ),
                                        _deductionPaymentRow(
                                          "Professional Tax",
                                          widget.professionalTax,
                                        ),
                                        _deductionPaymentRow(
                                          "GPA",
                                          widget.gpa,
                                        ),
                                        _deductionPaymentRow(
                                          "Union Fund",
                                          widget.unionFund,
                                        ),
                                        _deductionPaymentRow(
                                          "Contract Labour Children Welfare Fund ",
                                          widget.contractLabourChildrenwelfarefund,
                                        ),
                                        _deductionPaymentRow(
                                          "Canteen",
                                          widget.canteen,
                                        ),
                                        _deductionPaymentRow(
                                          "Wages Advance",
                                          widget.wagesAdvance,
                                        ),
                                        _deductionPaymentRow(
                                          "Arrear Professional Tax ",
                                          widget.arrearProfessionaltax,
                                        ),
                                        _deductionPaymentRow(
                                          "Cm Relief Fund",
                                          widget.cmRelifeFund,
                                        ),
                                        _deductionPaymentRow(
                                          "Medical Claim",
                                          widget.medicalClaim,
                                        ),
                                        _deductionPaymentRow(
                                          "Benevolent Fund ",
                                          widget.benvolentFund,
                                        ),
                                        _deductionPaymentRow(
                                          "Income Tax",
                                          widget.incomeTax,
                                        ),
                                        _deductionPaymentRow(
                                          "Loan Recovery",
                                          widget.loanRecovery,
                                        ),
                                        _deductionPaymentRow(
                                          "Pf Loan Interest",
                                          widget.pfLoanInterest,
                                        ),
                                        _deductionPaymentRow(
                                          "Miscl Dedn",
                                          widget.misclDedn,
                                        ),
                                        _deductionPaymentRow(
                                          "Labour Welfare fund",
                                          widget.labourWelfareFund,
                                        ),
                                        _deductionPaymentRow(
                                          "Employee State Insurance",
                                          widget.employeeStateInsurance,
                                        ),
                                      ]),
                                ]),
                          ),
                          _grossEarningRow("Gross Earning", widget.grossEarning,
                              "Gross Deduction", widget.grossDeduction),
                          _netSalaryRow("Net Salary :", roundedNetSalary.toDouble()),
                        ])),
                    _amountInWord(
                      "Amount in Words : ",
                      roundedNetSalary.toDouble(), // Convert to double if needed
                    ),
                  ])),
            ],
          );
        },
      ),
    );

    // Save PDF file or share
    final employeeName =
    widget.name.replaceAll(' ', '_'); // Replace spaces with underscores
    final now = DateTime.now();
    final formattedDateTime =
        '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}';
    final fileName = '${employeeName}_PaySlip_$formattedDateTime.pdf';

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

// New method to build PDF rows based on the structure in DetailsRow

  @override
  void initState() {
    super.initState();
    // loadPaymentSlipEmployeeData(); // Load data initially when the page is created
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // loadPaymentSlipEmployeeData(); // Load data again when coming back to the page
  }

  @override
  Widget build(BuildContext context) {
    final double netSalaryValue = double.tryParse(widget.netSalary) ?? 0;
    final int roundedNetSalary = netSalaryValue.ceil();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Download PDF'),
        backgroundColor: Colors.teal,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('SATYAM CONSTRUCTION',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        const Text("BHANDARA",
                            style:
                            TextStyle(fontSize: 12, color: Colors.black54)),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: 'Pay Slip for the month of: ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12)),
                              TextSpan(
                                  text: widget.month,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text: ' - ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12)),
                              TextSpan(
                                  text: widget.year.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(color: Colors.red)
                          ),
                          child: Column(
                            children: [
                              EmployeeDetailsRow(
                                employeeCode: widget.employeeCode,
                                name: widget.name,
                                bankName: widget.bankName,
                                bankAccountNo: widget.bankAccountNo,
                                dateOfBirth: widget.dateOfBirth,
                                grade: widget.grade,
                                pfAccountNo: widget.pfAccountNo,
                                universalAccountNo: widget.universalAccountNo,
                                esi: widget.esi,
                              ),
                              const SizedBox(height: 20),
                              DetailsRow2(
                                workingDays: widget.workingDays,
                                weeklyOff: widget.weeklyOff,
                                leaveDay: widget.leaveDay,
                                ph: widget.ph,
                              ),
                              const SizedBox(height: 20),
                              const DetailsRow4(),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.blue.shade100
                                    border: Border.all(color: Colors.grey)),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            EarningPaymentRow(
                                              title1: 'Basic Wages',
                                              title2: widget.basicWagesRate,
                                              title3: widget.basicWagesAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Arrear Basic Wages",
                                              title2: "",
                                              title3: widget.arrearBasicWages,
                                            ),
                                            EarningPaymentRow(
                                              title1: 'HRA',
                                              title2: widget.hraRate,
                                              title3: widget.hraAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: 'Arrear HRA',
                                              title2: "",
                                              title3: widget.arrearHraAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: 'Perf All',
                                              title2: widget.prfRate,
                                              title3: widget.prfAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Wash All",
                                              title2: widget.washRate,
                                              title3: widget.washAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "She All",
                                              title2: widget.sheRate,
                                              title3: widget.sheAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Med All",
                                              title2: widget.medRate,
                                              title3: widget.medAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Special Allowance",
                                              title2: widget.specialRate,
                                              title3: widget.specialAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Skill Allowance",
                                              title2: widget.skillRate,
                                              title3: widget.skillAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Tiffin Allowance",
                                              title2:
                                              widget.tiffinAllowanceAmount,
                                              title3:
                                              widget.tiffinAllowanceAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Tiffin Reim ",
                                              title2: widget.tiffinReimRate,
                                              title3: widget.tiffinReimAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Other Allowance",
                                              title2: widget.otherAllowanceRate,
                                              title3:
                                              widget.otherAllowanceAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Arear Other Allowance",
                                              title2: "",
                                              title3: widget.arearOtherAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Education Allowance",
                                              title2: "",
                                              title3: widget.educationAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Heavy Duty Allowance",
                                              title2: "",
                                              title3: widget.heavyDutyAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Att All",
                                              title2: "",
                                              title3: widget.attAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "MISCL Earning",
                                              title2: "",
                                              title3: widget.misclEarning,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Overtime",
                                              title2: "",
                                              title3: widget.overtimeAmount,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Leave Encashment",
                                              title2: "",
                                              title3: widget.leaveEncashment,
                                            ),
                                            EarningPaymentRow(
                                              title1: "PMGKY Benifit",
                                              title2: "",
                                              title3: widget.pmgkyBenifit,
                                            ),
                                            EarningPaymentRow(
                                              title1: "Overtime",
                                              title2: widget.otDays,
                                              title3: widget.otDaysAmounts,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            DeductionPaymentRow(
                                              title4: 'Provident Fund',
                                              title5: widget.providentFund,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "Professional Tax",
                                              title5: widget.professionalTax,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "GPA",
                                              title5: widget.gpa,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "Union Fund",
                                              title5: widget.unionFund,
                                            ),
                                            DeductionPaymentRow(
                                              title4:
                                              "Contract Labour Welfare Fund ",
                                              title5: widget
                                                  .contractLabourChildrenwelfarefund,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "Canteen",
                                              title5: widget.canteen,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "Wages Advance",
                                              title5: widget.wagesAdvance,
                                            ),
                                            DeductionPaymentRow(
                                              title4:
                                              "Arrear Professional Tax ",
                                              title5:
                                              widget.arrearProfessionaltax,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "Cm Relief Fund",
                                              title5: widget.cmRelifeFund,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "Medical Claim",
                                              title5: widget.medicalClaim,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "Benevolent Fund ",
                                              title5: widget.benvolentFund,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "Income Tax",
                                              title5: widget.incomeTax,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "Loan Recovery",
                                              title5: widget.loanRecovery,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "Pf Loan Interest",
                                              title5: widget.pfLoanInterest,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "MISCL DEDN",
                                              title5: widget.misclDedn,
                                            ),
                                            DeductionPaymentRow(
                                              title4: "Labour Welfare fund",
                                              title5: widget.labourWelfareFund,
                                            ),
                                            DeductionPaymentRow(
                                              title4:
                                              "Employee State Insurance",
                                              title5:
                                              widget.employeeStateInsurance,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    DetailsRow5(
                                      grossEarning: widget.grossEarning,
                                      grossDeduction: widget.grossDeduction,
                                    ),
                                    // Update DetailsRow6 and DetailsRow7 to use the rounded value
                                    DetailsRow6(
                                      netSalary: roundedNetSalary
                                          .toStringAsFixed(2), // Pass the rounded-off value
                                    ),
                                  ],
                                ),
                              ),
                              DetailsRow7(
                                netSalaryInWord: convertNumberToWords(
                                    roundedNetSalary
                                        .toDouble()), // Convert rounded value to words
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                  buildContainer(
                    context,
                    containerWidth,
                    containerHeight,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          child: ElevatedButton.icon(
                            onPressed: () => _generateAndDownloadPdf(context),
                            icon:
                            const Icon(Icons.download, color: Colors.white),
                            label: const Text('Download PDF',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 250,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                    (Route<dynamic> route) =>
                                false, // Removes all previous routes
                              );
                            },
                            icon: const Icon(Icons.home, color: Colors.white),
                            label: const Text('Home Page',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
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
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(2, 4))
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}
