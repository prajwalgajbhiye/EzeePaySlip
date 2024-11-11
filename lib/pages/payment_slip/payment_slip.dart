import 'package:EzeePayslip/pages/home_page.dart';
import 'package:flutter/material.dart';
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
  final String hraRate;

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
  final String contractLabourwelfarefund;
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
  final String year;

  const PaymentSlip(
      {super.key,
      required this.employeeCode,
      required this.name,
      required this.bankName,
      required this.bankAccountNo,
      required this.dateOfBirth,
      required this.grade,
      required this.pfAccountNo,
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
      required this.month,
      required this.year,
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
      required this.contractLabourwelfarefund,
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
      required this.otDaysAmounts});

  @override
  State<PaymentSlip> createState() => _PaymentSlipState();
}

class _PaymentSlipState extends State<PaymentSlip> {
  final TextEditingController employeeCodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController bankAccountNoController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController pfAccountNoController = TextEditingController();
  final TextEditingController universalAccountNoController =
      TextEditingController();
  final TextEditingController esiNoController = TextEditingController();
  final TextEditingController workingDaysController = TextEditingController();
  final TextEditingController BasicWagesController = TextEditingController();

  final TextEditingController weeklyOffController = TextEditingController();
  final TextEditingController leaveDaysController = TextEditingController();
  final TextEditingController phController = TextEditingController();

  // Manually entered rate fields

  final TextEditingController basicWagesRateController =
      TextEditingController();
  final TextEditingController hraRateController = TextEditingController();
  final TextEditingController tiffinAllowanceRateController =
      TextEditingController();
  final TextEditingController otherAllowanceRateController =
      TextEditingController();

  // Calculated amount fields
  final TextEditingController basicWagesAmountController =
      TextEditingController();
  final TextEditingController hraAmountController = TextEditingController();
  final TextEditingController tiffinAllowanceAmountController =
      TextEditingController();
  final TextEditingController otherAllowanceAmountController =
      TextEditingController();
  final TextEditingController prefRateController = TextEditingController();
  final TextEditingController prefAmountController = TextEditingController();
  final TextEditingController washRateController = TextEditingController();
  final TextEditingController washAmountController = TextEditingController();
  final TextEditingController sheRateController = TextEditingController();
  final TextEditingController sheAmountController = TextEditingController();
  final TextEditingController medRateController = TextEditingController();
  final TextEditingController medAmountController = TextEditingController();
  final TextEditingController tiffinReimRateController =
      TextEditingController();
  final TextEditingController tiffinReimAmountController =
      TextEditingController();
  final TextEditingController otAmountController = TextEditingController();
  final TextEditingController otRateController = TextEditingController();

  final TextEditingController specialRateController = TextEditingController();
  final TextEditingController specialAmountController = TextEditingController();
  final TextEditingController skillRateController = TextEditingController();
  final TextEditingController skillAmountController = TextEditingController();
  final TextEditingController arearRateController = TextEditingController();
  final TextEditingController arearAmountController = TextEditingController();
  final TextEditingController educationRateController = TextEditingController();
  final TextEditingController educationAmountController =
      TextEditingController();
  final TextEditingController heavyDutyRateController = TextEditingController();
  final TextEditingController heavyDutyAmountController =
      TextEditingController();
  final TextEditingController attRateController = TextEditingController();
  final TextEditingController attAmountController = TextEditingController();
  final TextEditingController misclRateController = TextEditingController();
  final TextEditingController misclAmountController = TextEditingController();
  final TextEditingController overtimeRateController = TextEditingController();
  final TextEditingController overtimeAmountController =
      TextEditingController();
  final TextEditingController leaveRateController = TextEditingController();
  final TextEditingController leaveAmountController = TextEditingController();
  final TextEditingController pmgkyRateController = TextEditingController();
  final TextEditingController pmgkyAmountController = TextEditingController();

  final TextEditingController pfAmountController = TextEditingController();
  final TextEditingController taxAmountController =
      TextEditingController(text: "200.00"); // Professional Tax fixed
  final TextEditingController esiAmountController = TextEditingController();

  final TextEditingController gpaAmountController = TextEditingController();
  final TextEditingController unionFundAmountController =
      TextEditingController();
  final TextEditingController childrenWelfareFundAmountController =
      TextEditingController();
  final TextEditingController canteenAmountController = TextEditingController();
  final TextEditingController wagesAdvanceAmountController =
      TextEditingController();
  final TextEditingController arrearProfessionalTaxAmountController =
      TextEditingController();
  final TextEditingController cmReliefFundAmountController =
      TextEditingController();

  final TextEditingController medicalClaimAmountController =
      TextEditingController();
  final TextEditingController benvolentFundAmountController =
      TextEditingController();
  final TextEditingController incomeTaxAmountController =
      TextEditingController();
  final TextEditingController loanRecoveryAmountController =
      TextEditingController();
  final TextEditingController pfLoanInterestAmountController =
      TextEditingController();

  final TextEditingController grossEarningsController = TextEditingController();
  final TextEditingController grossDeductionsController =
      TextEditingController();
  final TextEditingController netSalaryController = TextEditingController();

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
              flex: 4,
              child: pw.Container(
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey)),
                child: pw.Text(
                  title1,
                  style:
                      pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            pw.Expanded(
              flex: 2,
              child: pw.Container(
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey),
                        top: pw.BorderSide(color: PdfColors.grey),
                        right: pw.BorderSide(color: PdfColors.grey))),
                child: pw.Text(
                  title2,
                  style:
                      pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            pw.Expanded(
              flex: 2,
              child: pw.Container(
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey),
                        top: pw.BorderSide(color: PdfColors.grey),
                        // bottom: BorderSide(color: Colors.grey),
                        right: pw.BorderSide(color: PdfColors.grey))),
                child: pw.Text(
                  title3,
                  style:
                      pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            pw.Expanded(
              flex: 4,
              child: pw.Container(
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey),
                        top: pw.BorderSide(color: PdfColors.grey),
                        // bottom: BorderSide(color: Colors.grey),
                        right: pw.BorderSide(color: PdfColors.grey))),
                child: pw.Text(
                  title4,
                  style:
                      pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            pw.Expanded(
              flex: 2,
              child: pw.Container(
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey),
                        top: pw.BorderSide(color: PdfColors.grey),
                        // bottom: BorderSide(color: Colors.grey),
                        right: pw.BorderSide(color: PdfColors.grey))),
                child: pw.Text(
                  title5,
                  style:
                      pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
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
      // margin: pw.EdgeInsets.only(left: 2),
      // color: PdfColors.red,
      width: 275.3, // Ensures that the width is bounded
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 4,
            child: pw.Container(
              padding: const pw.EdgeInsets.only(left: 2),
              alignment: pw.Alignment.centerLeft,
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                left: pw.BorderSide(color: PdfColors.grey),
              )),
              child: pw.Text(
                title1,
                style: const pw.TextStyle(
                  fontSize: 8,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                title2,
                style: const pw.TextStyle(
                  fontSize: 8,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              decoration: const pw.BoxDecoration(
                  border:
                      pw.Border(right: pw.BorderSide(color: PdfColors.grey))),
              child: pw.Text(
                title3,
                style: const pw.TextStyle(
                  fontSize: 8,
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
      width: 205.5, // Ensures that the width is bounded
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 4,
            child: pw.Container(
              padding: const pw.EdgeInsets.only(left: 2),
              alignment: pw.Alignment.centerLeft,
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                left: pw.BorderSide(color: PdfColors.grey),
              )),
              child: pw.Text(
                title4,
                style: const pw.TextStyle(
                  fontSize: 8,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              // decoration: const pw.BoxDecoration(
              //     border:
              //         pw.Border(right: pw.BorderSide(color: PdfColors.grey))),
              child: pw.Text(
                title5,
                style: const pw.TextStyle(
                  fontSize: 8,
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
    return pw.Row(
      children: [
        pw.Expanded(
          flex: 6,
          child: pw.Container(
            // width: MediaQuery.of(context).size.width*0.2,
            padding: const pw.EdgeInsets.only(left: 2),

            decoration:
                pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey)),
            child: pw.Text(
              title1,
              style: pw.TextStyle(
                fontSize: 8,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ),
        // Container(width: 10),
        // Container(width: 10),
        pw.Expanded(
          flex: 2,
          child: pw.Container(
            alignment: pw.Alignment.center,
            decoration: const pw.BoxDecoration(
                border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.grey),
                    top: pw.BorderSide(color: PdfColors.grey),
                    right: pw.BorderSide(color: PdfColors.grey))),
            child: pw.SizedBox(
              // color: Colors.grey,
              child: pw.Text(
                title2,
                style: pw.TextStyle(
                  fontSize: 8,
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
            padding: const pw.EdgeInsets.only(left: 2),
            decoration: const pw.BoxDecoration(
                border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.grey),
                    top: pw.BorderSide(color: PdfColors.grey),
                    right: pw.BorderSide(color: PdfColors.grey))),
            child: pw.SizedBox(
              // color: Colors.blueAccent,
              child: pw.Text(
                title3,
                style: pw.TextStyle(
                  fontSize: 8,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // Container(width: 10),
        pw.Expanded(
          flex: 2,
          child: pw.Container(
            alignment: pw.Alignment.center,

            decoration: const pw.BoxDecoration(
                border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.grey),
                    top: pw.BorderSide(color: PdfColors.grey),
                    right: pw.BorderSide(color: PdfColors.grey))),
            // color: Colors.orange,
            child: pw.Text(
              title4,
              style: pw.TextStyle(
                fontSize: 8,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ),
        // Container(width: 10),
      ],
    );
  }

  pw.Widget _netSalaryRow(String title1, String value) {
    return pw.Row(
      children: [
        pw.Flexible(
          flex: 6,
          child: pw.Container(
            padding: const pw.EdgeInsets.only(left: 2),

            // width: MediaQuery.of(context).size.width*0.2,

            decoration: const pw.BoxDecoration(
                border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.grey),
                    left: pw.BorderSide(color: PdfColors.grey),
                    right: pw.BorderSide(color: PdfColors.grey))),
            child: pw.Row(
              children: [
                pw.Text(
                  title1,
                  style: pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 2),
                  child: pw.Text(
                    value,
                    style: pw.TextStyle(
                      fontSize: 8,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container(width: 10),
        // Container(width: 10),

        // Container(width: 10),
      ],
    );
  }

  pw.Widget _amountInWord(String title1, String value) {
    return pw.Row(
      children: [
        pw.Flexible(
          flex: 6,
          child: pw.Container(
            // width: MediaQuery.of(context).size.width*0.2,
            padding: const pw.EdgeInsets.only(left: 2),

            decoration: const pw.BoxDecoration(),
            child: pw.Row(
              children: [
                pw.Text(
                  title1,
                  style: pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 2),
                  child: pw.Text(
                    "Rupees $value only",
                    style: pw.TextStyle(
                      fontSize: 8,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container(width: 10),
        // Container(width: 10),

        // Container(width: 10),
      ],
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
                  right: pw.BorderSide(color: PdfColors.grey),
                  top: pw.BorderSide(color: PdfColors.grey),
                  bottom: pw.BorderSide(color: PdfColors.grey),
                  left: pw.BorderSide(color: PdfColors.grey)),
            ),
            child: pw.Text(
              title,
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ),
        pw.Expanded(
          flex: 6,
          child: pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                right: pw.BorderSide(color: PdfColors.grey),
                top: pw.BorderSide(color: PdfColors.grey),
                bottom: pw.BorderSide(color: PdfColors.grey),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  "$title1: ",
                  style:
                      pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(value1, style: const pw.TextStyle(fontSize: 8)),
              ],
            ),
          ),
        ),
        pw.Expanded(
          flex: 6,
          child: pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                right: pw.BorderSide(color: PdfColors.grey),
                top: pw.BorderSide(color: PdfColors.grey),
                bottom: pw.BorderSide(color: PdfColors.grey),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  "$title2: ",
                  style:
                      pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(value2, style: const pw.TextStyle(fontSize: 8)),
              ],
            ),
          ),
        ),
        pw.Expanded(
          flex: 6,
          child: pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                right: pw.BorderSide(color: PdfColors.grey),
                top: pw.BorderSide(color: PdfColors.grey),
                bottom: pw.BorderSide(color: PdfColors.grey),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  "$title3: ",
                  style:
                      pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(value3, style: const pw.TextStyle(fontSize: 8)),
              ],
            ),
          ),
        ),
        pw.Expanded(
            flex: 6,
            child: pw.Container(
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                right: pw.BorderSide(color: PdfColors.grey),
                top: pw.BorderSide(color: PdfColors.grey),
                bottom: pw.BorderSide(color: PdfColors.grey),
              )),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    "$title4: ",
                    style: pw.TextStyle(
                        fontSize: 8, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(value4, style: const pw.TextStyle(fontSize: 8)),
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
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Flexible(
              flex: 4,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.only(left: 2),
                    child: pw.Text(
                      title1,
                      style: pw.TextStyle(
                        fontSize: 8,
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
                            fontSize: 8, color: PdfColors.black),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            pw.Container(width: 10),
            pw.Flexible(
                flex: 6,
                child: pw.Row(
                  children: [
                    pw.SizedBox(
                      child: pw.Text(
                        value1,
                        style: const pw.TextStyle(
                            fontSize: 8, color: PdfColors.black),
                      ),
                    ),
                  ],
                )),
            pw.Container(width: 10),
            pw.Flexible(
              flex: 4,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.SizedBox(
                    child: pw.Text(
                      title2,
                      style: pw.TextStyle(
                        fontSize: 8,
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
                            fontSize: 8, color: PdfColors.black),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            pw.Container(width: 10),
            pw.Flexible(
              flex: 4,
              child: pw.SizedBox(
                child: pw.Text(
                  value2,
                  style:
                      const pw.TextStyle(fontSize: 8, color: PdfColors.black),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  // String netSalaryInWords = NumberToWord().convert(int.parse(widget.netSalary.replaceAll(',', '')));

  Future<void> _generateAndDownloadPdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
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
                        fontSize: 8, fontWeight: pw.FontWeight.bold)),
                pw.Text('BHANDARA',
                    style: const pw.TextStyle(
                        fontSize: 8, color: PdfColors.black)),
                pw.RichText(
                  text: pw.TextSpan(
                    children: [
                      const pw.TextSpan(
                          text: 'Pay Slip for the month of : ',
                          style: pw.TextStyle(
                              color: PdfColors.black, fontSize: 8)),
                      pw.TextSpan(
                          text: widget.month,
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold)),
                      const pw.TextSpan(
                          text: ' - ',
                          style: pw.TextStyle(
                              color: PdfColors.black, fontSize: 8)),
                      pw.TextSpan(
                          text: widget.year,
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                ),
              ])),
              // Header Section

              pw.SizedBox(height: 10),

              pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey)),
                  // color: PdfColors.red,
                  child: pw.Column(children: [
                    _buildRow("Employee Code", widget.employeeCode,
                        "PF Account No.", "Not Available"),
                    _buildRow("Name", widget.name, "Date Of Birth",
                        widget.dateOfBirth),
                    _buildRow("Bank Name", widget.bankName, "Bank A/C No.",
                        widget.bankAccountNo),
                    _buildRow("Grade", widget.grade, "Universal Account No.",
                        widget.universalAccountNo),
                    _buildRow("ESI", widget.esi, "", ""),
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
                        // alignment: pw.Alignment.topCenter,
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
                              "HRA",
                              widget.hraRate,
                              widget.hraAmount,
                            ),
                            _earningPaymentRow("PRF Allowance", widget.prfRate,
                                widget.prfAmount),
                            _earningPaymentRow("Wash Allowance",
                                widget.washRate, widget.washAmount),
                            _earningPaymentRow("she Allowance", widget.sheRate,
                                widget.sheAmount),
                            _earningPaymentRow("Medical Allowance",
                                widget.medRate, widget.medAmount),
                            _earningPaymentRow("Special Allowance",
                                widget.specialRate, widget.specialAmount),
                            _earningPaymentRow("Skill Allowance",
                                widget.skillRate, widget.skillAmount),
                            _earningPaymentRow(
                              "Tiffin Allowance",
                              widget.tiffinAllowanceRate,
                              widget.tiffinAllowanceAmount,
                            ),
                            _earningPaymentRow("Tiffin Reim Allowance",
                                widget.tiffinReimRate, widget.tiffinReimAmount),
                            _earningPaymentRow(
                              "Other Allowance",
                              widget.otherAllowanceRate,
                              widget.otherAllowanceAmount,
                            ),
                            _earningPaymentRow(
                              "Arear Other Allowance",
                              '',
                              widget.arearOtherAmount,
                            ),
                            _earningPaymentRow(
                              "Education Allowance",
                              "",
                              widget.educationAmount,
                            ),
                            _earningPaymentRow(
                              "Heavy Duty Allowance",
                              "",
                              widget.heavyDutyAmount,
                            ),
                            _earningPaymentRow(
                              "att Allowance",
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
                              "Ot Days",
                              widget.otDays,
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
                                  "Contract Labour Welfare Fund ",
                                  widget.contractLabourwelfarefund,
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
                                  "MISCL DEDN",
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
                        ])),
                    _grossEarningRow("Gross Earning", widget.grossEarning,
                        "Gross Deduction", widget.grossDeduction),
                    _netSalaryRow("Net Salary :", widget.netSalary),
                    _amountInWord(
                        "Amount in Words : ",
                        convertNumberToWords(
                            double.parse(widget.netSalary.toString()))),
                  ])),
            ],
          );
        },
      ),
    );

    // Save PDF file or share
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
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
                                  text: widget.year,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      EarningPaymentRow(
                                        title1: 'Basic Wages',
                                        title2: widget.basicWagesRate,
                                        title3: widget.basicWagesAmount,
                                      ),
                                      EarningPaymentRow(
                                        title1: 'HRA',
                                        title2: widget.hraRate,
                                        title3: widget.hraAmount,
                                      ),
                                      EarningPaymentRow(
                                        title1: 'PRF Allowance',
                                        title2: widget.prfRate,
                                        title3: widget.prfAmount,
                                      ),
                                      EarningPaymentRow(
                                        title1: "Wash Allowance",
                                        title2: widget.washRate,
                                        title3: widget.washAmount,
                                      ),
                                      EarningPaymentRow(
                                        title1: "she Allowance",
                                        title2: widget.sheRate,
                                        title3: widget.sheAmount,
                                      ),
                                      EarningPaymentRow(
                                        title1: "Medical Allowance",
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
                                        title2: widget.tiffinAllowanceRate,
                                        title3: widget.tiffinAllowanceAmount,
                                      ),
                                      EarningPaymentRow(
                                        title1: "Tiffin Reim Allowance",
                                        title2: widget.tiffinReimRate,
                                        title3: widget.tiffinReimAmount,
                                      ),
                                      EarningPaymentRow(
                                        title1: "Other Allowance",
                                        title2: widget.otherAllowanceRate,
                                        title3: widget.otherAllowanceAmount,
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
                                        title1: "att Allowance",
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
                                        title1: "Ot Days",
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
                                        title5:
                                            widget.contractLabourwelfarefund,
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
                                        title4: "Arrear Professional Tax ",
                                        title5: widget.arrearProfessionaltax,
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
                                        title4: "Employee State Insurance",
                                        title5: widget.employeeStateInsurance,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              DetailsRow5(
                                grossEarning: widget.grossEarning,
                                grossDeduction: widget.grossDeduction,
                              ),
                              DetailsRow6(
                                netSalary: widget.netSalary,
                              ),
                              DetailsRow7(
                                netSalaryInWord: widget.netSalary.isNotEmpty
                                    ? convertNumberToWords(
                                        double.tryParse(widget.netSalary) ?? 0)
                                    : 'Zero',
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


                        ElevatedButton.icon(
                          onPressed: () => _generateAndDownloadPdf(context),
                          icon: const Icon(Icons.download, color: Colors.white),
                          label: const Text('Download PDF',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                                  (Route<dynamic> route) => false, // Removes all previous routes
                            );
                          },
                          icon: const Icon(Icons.home, color: Colors.white),
                          label: const Text('Home Page', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            textStyle: const TextStyle(fontSize: 18),
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
          color: Colors.grey[300],
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
