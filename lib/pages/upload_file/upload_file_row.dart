// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:EzeePayslip/pages/payment_slip/employee_enfo.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class FileUploadSection extends StatefulWidget {
  final double containerHeightFactor;
  final String? fileName;

  const FileUploadSection({
    super.key,
    required this.containerHeightFactor,
    this.fileName,
  });

  @override
  State<FileUploadSection> createState() => _FileUploadSectionState();
}

class _FileUploadSectionState extends State<FileUploadSection> {
  TextEditingController employeeCodeController = TextEditingController();
  TextEditingController punchingNumberController = TextEditingController();
  String? filePath;
  String? fileName;

  Map<String, Map<String, String>> employeeData = {};

  // List<Map<String, String>> employees = employeeData.values.map((e) => e as Map<String, String>).toList();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSavedExcelFile();
    });
  }

  Future<void> _loadSavedExcelFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filePath = prefs.getString('excelFilePath');
    if (filePath != null) {
      fileName = filePath!.split('/').last;
      loadEmployeeData();
    }
  }

  Future<void> uploadExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
        filePath = result.files.single.path;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('excelFilePath', filePath!);
      loadEmployeeData();
    }
  }

  String getCellValue(Data? cell) {
    if (cell == null || cell.value == null) {
      if (kDebugMode) {
        print("Cell is empty or null, returning '0'");
      }
      return "0";
    }
    if (cell.value is String && cell.value.toString().startsWith('=')) {
      print("Cell is a formula, returning '0'");
      return "0";
    }
    return cell.value.toString();
  }

  void loadEmployeeData() async {
    if (filePath == null) return;

    var fileBytes = File(filePath!).readAsBytesSync();
    var excel = Excel.decodeBytes(fileBytes);

    employeeData.clear();

    for (var row in excel.tables['Sheet1']!.rows.skip(1)) {
      var empCode = row[3]?.value?.toString() ?? ''; // EMP CODE
      if (empCode.isNotEmpty) {
        employeeData[empCode] = {
          "PUNCHING NUMBER": getCellValue(row[2]),
          "EMPLOYEE CODE": getCellValue(row[3]),
          "EMPLOYEE NAME": getCellValue(row[4]),
          "GRADE": getCellValue(row[5]),
          "AADHAAR NO": getCellValue(row[6]),
          "UAN": getCellValue(row[7]),
          "ESI NO": getCellValue(row[9]),
          "BANK NAME": getCellValue(row[10]),
          "BANK A/C NO.": getCellValue(row[11]),
          "DOB": getCellValue(row[12]),
          "OT DAYS": getCellValue(row[15]),
          "WORKING DAYS": getCellValue(row[17]),
          "BASIC WAGES RATE": getCellValue(row[22]),
          "HRA": getCellValue(row[25]),
          "PERF ALLOWANCE": getCellValue(row[28]),
          "WASH ALLOWANCE": getCellValue(row[31]),
          "SHE ALLOWANCE": getCellValue(row[34]),
          "MED ALLOWANCE": getCellValue(row[37]),
          "TIFFIN ALLOWANCES": getCellValue(row[45]),
          "TIFFIN REIM ALLOWANCE": getCellValue(row[47]),
          "SPECIAL ALLOWANCE": getCellValue(row[41]),
          "SKILL ALLOWANCE": getCellValue(row[43]),
          "OTHER ALLOWANCE": getCellValue(row[50]),
          "ARREARS OTHER ALLOWANCE": getCellValue(row[52]),
          "EDUCATION ALLOWANCE": getCellValue(row[53]),
          "HEAVY DUTY ALLOWANCE": getCellValue(row[55]),
          "MISCL ALLOWANCE": getCellValue(row[57]),
          "ATT ALLOWANCE": getCellValue(row[56]),
          "OVERTIME": getCellValue(row[58]),
          "LEAVE ENCASHMENT": getCellValue(row[59]),
          "PMGKY": getCellValue(row[60]),
          "GPA": getCellValue(row[63]),
          "UNION FUND": getCellValue(row[64]),
          "CONTRACT LABOUR CHILDREN WELFARE FUND": getCellValue(row[65]),
          "CANTEEN": getCellValue(row[66]),
          "WAGES ADVANCE": getCellValue(row[67]),
          "MISCL DEDN": getCellValue(row[68]),
          "PROFESSIONAL TAX": getCellValue(row[69]),
          "ARREARS PROFESSIONAL": getCellValue(row[70]),
          "LABOUR WELFARE FUND": getCellValue(row[71]),
          "CM RELIEF FUND": getCellValue(row[72]),
          "MEDICAL CLAIM": getCellValue(row[74]),
          "BENEVOLENT FUND": getCellValue(row[75]),
          "INCOME TAX": getCellValue(row[76]),
          "LOAN RECOVERY": getCellValue(row[77]),
          "PF LOAN INTEREST": getCellValue(row[78]),
        };
      }
    }
    setState(() {});
  }

  void generateSlip() {
    final empCode = employeeCodeController.text.trim();
    final punchingNumber = punchingNumberController.text.trim();

    if (empCode.isNotEmpty && employeeData.containsKey(empCode)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EmployeeInfoDisplayPage(employeeData: employeeData[empCode]!),
        ),
      );
    } else if (punchingNumber.isNotEmpty) {
      final emp = employeeData.values.firstWhere(
        (data) => data['PUNCHING NUMBER'] == punchingNumber,
        orElse: () => {},
      );
      if (emp.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeInfoDisplayPage(employeeData: emp),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Punching number $punchingNumber not found')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter Employee Code or Punching Number')),
      );
    }
  }

  Future<void> generateAllPaymentSlips(BuildContext context) async {
    List<Map<String, dynamic>> employees = employeeData.values.toList();

    final pdf = pw.Document();

    for (int i = 0; i < employees.length; i += 2) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  // First Employee on the Page
                  if (i < employees.length) buildEmployeeSection(employees[i]),

                  pw.SizedBox(height: 20),

                  // Second Employee on the Page (if exists)
                  if (i + 1 < employees.length)
                    buildEmployeeSection(employees[i + 1]),
                ]);
          },
        ),
      );
    }

    final now = DateTime.now();
    final formattedDateTime =
        '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}';
    final fileName = 'EmployeePaySlip_$formattedDateTime.pdf';

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

// Helper function to build an employee section

  pw.Widget buildEmployeeSection(Map<String, dynamic> employee) {
    String formatDate(String? date) {
      if (date == null || date.isEmpty) {
        return 'N/A';
      }

      try {
        // Define a list of possible input formats
        final inputFormats = [
          DateFormat('yyyy-MM-dd'),
          DateFormat('MM/dd/yyyy'),
          DateFormat('dd/MM/yyyy'),
        ];

        DateTime parsedDate;
        for (final format in inputFormats) {
          try {
            parsedDate = format.parse(date);
            return DateFormat('d-MMM-yyyy').format(parsedDate);
          } catch (e) {
            // Continue to the next format if parsing fails
          }
        }

        // If no format matched, return 'N/A'
        return 'N/A';
      } catch (e) {
        print("Invalid date format: $date");
        return 'N/A';
      }
    }

    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value; // If already a double, return as is
      if (value is String) {
        return double.tryParse(value) ?? 0.0; // Parse if string
      }
      return 0.0;
    }

    double workingDays = parseDouble(employee['WORKING DAYS']);
    double basicWageRate = parseDouble(employee['BASIC WAGES RATE']);
    double hraRate = parseDouble(employee['HRA']);

    double otDays = parseDouble(employee['OT DAYS']);

    double prfAllowanceRate = parseDouble(employee['PERF ALLOWANCE']);
    double washAllowanceRate = parseDouble(employee['WASH ALLOWANCE']);
    double sheAllowanceRate = parseDouble(employee['SHE ALLOWANCE']);
    double medAllowanceRate = parseDouble(employee['MED ALLOWANCE']);
    double specialAllowanceRate = parseDouble(employee['SPECIAL ALLOWANCE']);
    double skillAllowanceRate = parseDouble(employee['SKILL ALLOWANCE']);
    double tiffinAllowanceRate = parseDouble(employee['TIFFIN ALLOWANCES']);
    double tiffinReimAllowanceRate =
        parseDouble(employee['TIFFIN REIM ALLOWANCE']);
    double otherAllowanceRate = parseDouble(employee['OTHER ALLOWANCE']);
    double arrearOtherAllowanceAmount =
        parseDouble(employee['ARREARS OTHER ALLOWANCE']);
    double educationAllowanceAmount =
        parseDouble(employee['EDUCATION ALLOWANCE']);
    double heavyDutyAllowanceAmount =
        parseDouble(employee['HEAVY DUTY ALLOWANCE']);
    double attAllowanceAmount = parseDouble(employee['ATT ALLOWANCE']);
    double misclEarningAmount = parseDouble(employee['MISCL ALLOWANCE']);
    double overtimeAmount = parseDouble(employee['OVERTIME']);
    double leaveEncashmentAmount = parseDouble(employee['LEAVE ENCASHMENT']);
    double pmgkyBenifitAmount = parseDouble(employee['PMGKY'] ?? "00");

    // Calculate earnings and deductions for this employee
    double basicWageAmount = basicWageRate * workingDays;
    double hraAmount = hraRate * workingDays;

    double prfAmount = prfAllowanceRate * workingDays;
    double washAllowanceAmount = washAllowanceRate * workingDays;
    double sheAllowanceAmount = sheAllowanceRate * workingDays;
    double medAllowanceAmount = medAllowanceRate * workingDays;
    double specialAllowanceAmount = specialAllowanceRate * workingDays;
    double skillAllowanceAmount = skillAllowanceRate * workingDays;
    double tiffinAllowanceAmount = tiffinAllowanceRate * workingDays;
    double tiffinReimAllowanceAmount = tiffinReimAllowanceRate * workingDays;
    double otherAllowanceAmount = otherAllowanceRate * workingDays;

    double ot = (basicWageRate / 8) * otDays * 2;

    // Calculate gross earnings
    double grossEarnings = basicWageAmount +
        hraAmount +
        prfAmount +
        washAllowanceAmount +
        sheAllowanceAmount +
        medAllowanceAmount +
        specialAllowanceAmount +
        skillAllowanceAmount +
        tiffinAllowanceAmount +
        tiffinReimAllowanceAmount +
        otherAllowanceAmount +
        arrearOtherAllowanceAmount +
        educationAllowanceAmount +
        heavyDutyAllowanceAmount +
        attAllowanceAmount +
        misclEarningAmount +
        overtimeAmount +
        leaveEncashmentAmount +
        pmgkyBenifitAmount +
        ot; // Include OT in gross earnings

// Calculate estimated monthly gross earnings excluding OT
    double monthlyGrossEarnings = (grossEarnings - ot) / workingDays * 26;

// Calculate ESI if monthly gross earnings is below 21,000
    double esi = 0.0;
    if (monthlyGrossEarnings < 21000) {
      esi =
          grossEarnings * 0.0075; // 0.75% of actual gross earnings if eligible
    }
    double providentFund = basicWageAmount * 0.12;

    double professionalTax = parseDouble(employee['PROFESSIONAL TAX'] ?? "");

    // double esi = grossEarnings * 0.0075;
    double gpa = parseDouble(employee['GPA'] ?? '0');
    double unionFund = parseDouble(employee['UNION FUND'] ?? '0');
    double contractLabourFund =
        parseDouble(employee['CONTRACT LABOUR CHILDREN WELFARE FUND'] ?? '0');
    double canteen = parseDouble(employee['CANTEEN'] ?? '0');
    double wagesAdvance = parseDouble(employee['WAGES ADVANCE'] ?? '0');
    double arrearProfessionalTax =
        parseDouble(employee['ARREARS PROFESSIONAL'] ?? '0');
    double cmReliefFund = parseDouble(employee['CM RELIEF FUND'] ?? '0');
    double medicalClaim = parseDouble(employee['MEDICAL CLAIM'] ?? '0');
    double benvolentFund = parseDouble(employee['BENEVOLENT FUND'] ?? '0');
    double incomeTax = parseDouble(employee['INCOME TAX'] ?? '0');
    double loanRecovery = parseDouble(employee['LOAN RECOVERY'] ?? '0');
    double pfLoanInterest = parseDouble(employee['PF LOAN INTEREST'] ?? '0');
    double miscldedn = parseDouble(employee['MISCL DEDN'] ?? '0');
    double labourWelfareFund =
        parseDouble(employee['LABOUR WELFARE FUND'] ?? '0');

    // Calculate gross deductions
    double grossDeductions = providentFund +
        professionalTax +
        esi +
        gpa +
        unionFund +
        contractLabourFund +
        canteen +
        wagesAdvance +
        arrearProfessionalTax +
        cmReliefFund +
        medicalClaim +
        benvolentFund +
        incomeTax +
        loanRecovery +
        miscldedn +
        labourWelfareFund +
        pfLoanInterest;

    // Calculate net salary
    double netSalary = grossEarnings - grossDeductions;

    return pw.Container(
      child: pw.Column(
        children: [
          pw.Text(
            'SATYAM CONSTRUCTION',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            'BHANDARA',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.black),
          ),
          pw.RichText(
            text: pw.TextSpan(
              children: [
                const pw.TextSpan(
                    text: 'Pay Slip for the month of: ',
                    style: pw.TextStyle(color: PdfColors.black, fontSize: 8)),
                pw.TextSpan(
                    text: DateFormat('MMMM').format(DateTime.now()),
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 8)),
                const pw.TextSpan(
                    text: ' - ',
                    style: pw.TextStyle(color: PdfColors.black, fontSize: 8)),
                pw.TextSpan(
                    text: "${DateTime.now().year}",
                    style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Container(
            // padding: const pw.EdgeInsets.only(left: 2),
            decoration:
                pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey)),
            child: pw.Column(
              children: [
                _buildRow(
                  "Employee Code",
                  employee['EMPLOYEE CODE'] ?? "Not Available",
                  "PF Account No.",
                  "Not Available",
                ),
                _buildRow(
                    "Name",
                    employee['EMPLOYEE NAME'] ?? "Not Available",
                    "Date Of Birth",
                    formatDate(employee['DOB'] ?? "Not Available")
                    // employee['DOB'] ?? "Not Available",
                    ),
                _buildRow(
                  "Bank Name",
                  employee['BANK NAME'] ?? "Not Available",
                  "Bank A/C No.",
                  employee['BANK A/C NO.'] ?? "Not Available",
                ),
                _buildRow(
                  "Grade",
                  employee['GRADE'] ?? "Not Available",
                  "Universal Account No.",
                  employee['UAN'] ?? "Not Available",
                ),
                _buildRow(
                  "ESI",
                  employee['ESI NO'] ?? "Not Available",
                  "",
                  "",
                ),
                pw.SizedBox(height: 10),
                _buildPdfRowWithFourColumns(
                    "Attendance Details:",
                    "Working Days",
                    employee['WORKING DAYS'] ?? "0",
                    "Weekly Off",
                    "",
                    "Leave Days",
                    "",
                    "PH",
                    ""),
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
                          employee['BASIC WAGES RATE'] ?? "",
                          (basicWageAmount).toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "HRA",
                          hraRate.toStringAsFixed(2),
                          hraAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "PRF Allowance",
                          prfAllowanceRate.toStringAsFixed(2),
                          prfAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Wash Allowance",
                          washAllowanceRate.toStringAsFixed(2),
                          washAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "she Allowance",
                          sheAllowanceRate.toStringAsFixed(2),
                          sheAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Medical Allowance",
                          medAllowanceRate.toStringAsFixed(2),
                          medAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Special Allowance",
                          specialAllowanceRate.toStringAsFixed(2),
                          specialAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Skill Allowance",
                          skillAllowanceRate.toStringAsFixed(2),
                          skillAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Tiffin Allowance",
                          tiffinAllowanceRate.toStringAsFixed(2),
                          tiffinAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Tiffin Reim Allowance",
                          tiffinReimAllowanceRate.toStringAsFixed(2),
                          tiffinReimAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Other Allowance",
                          otherAllowanceRate.toStringAsFixed(2),
                          otherAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Arear Other Allowance",
                          "",
                          arrearOtherAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Education Allowance",
                          "",
                          educationAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Heavy Duty Allowance",
                          "",
                          heavyDutyAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "att Allowance",
                          "",
                          attAllowanceAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "MISCL Earning",
                          "",
                          misclEarningAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Overtime",
                          "",
                          overtimeAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Leave Encashment",
                          "",
                          leaveEncashmentAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "PMGKY Benifit",
                          "",
                          pmgkyBenifitAmount.toStringAsFixed(2),
                        ),
                        _earningPaymentRow(
                          "Ot Days",
                          otDays.toStringAsFixed(2),
                          ot.toStringAsFixed(2),
                        ),
                      ]),
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            _deductionPaymentRow(
                              "Provident Fund",
                              providentFund.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "Professional Tax",
                              professionalTax.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "GPA",
                              gpa.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "Union Fund",
                              unionFund.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "Contract Labour Welfare Fund ",
                              contractLabourFund.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "Canteen",
                              canteen.toString(),
                            ),
                            _deductionPaymentRow(
                              "Wages Advance",
                              wagesAdvance.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "Arrear Professional Tax ",
                              arrearProfessionalTax.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow("Cm Relief Fund",
                                cmReliefFund.toStringAsFixed(2)),
                            _deductionPaymentRow(
                              "Medical Claim",
                              medicalClaim.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "Benevolent Fund ",
                              benvolentFund.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "Income Tax",
                              incomeTax.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "Loan Recovery",
                              loanRecovery.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "Pf Loan Interest",
                              pfLoanInterest.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "MISCL DEDN",
                              miscldedn.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "Labour Welfare fund",
                              labourWelfareFund.toStringAsFixed(2),
                            ),
                            _deductionPaymentRow(
                              "Employee State Insurance",
                              esi.toStringAsFixed(2),
                            ),
                          ]),
                    ])),
                _grossEarningRow(
                    "Gross Earning",
                    grossEarnings.toStringAsFixed(2),
                    "Gross Deduction",
                    grossDeductions.toStringAsFixed(2)),
                _netSalaryRow("Net Salary :", netSalary),
                _amountInWord(
                  "Amount in Words : ",
                  netSalary,
                )
              ],
            ),
          ),
          pw.SizedBox(height: 10),
        ],
      ),
    );
    // Deductions calculations
  }

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
  ) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              flex: 4,
              child: pw.Container(
                padding: const pw.EdgeInsets.only(left: 2),
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
                // margin: pw.EdgeInsets.only(right: 2),

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

// Define the net salary rounding logic outside of the widget constructors
  int parseAndRoundNetSalary(double value) {
    // Round up to the next integer and return as int
    return value.ceil();
  }

// Function to generate the net salary row in the PDF
  pw.Widget _netSalaryRow(String title1, double netSalary) {
    final int roundedNetSalary = parseAndRoundNetSalary(netSalary);

    return pw.Row(
      children: [
        pw.Flexible(
          flex: 6,
          child: pw.Container(
            padding: const pw.EdgeInsets.only(left: 2),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(color: PdfColors.grey),
                left: pw.BorderSide(color: PdfColors.grey),
                right: pw.BorderSide(color: PdfColors.grey),
              ),
            ),
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
                    roundedNetSalary.toString(), // Display rounded net salary
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
                      fontSize: 8,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 2),
                    child: pw.Text(
                      "Rupees ${convertNumberToWords(roundedNetSalary.toDouble())} only",
                      // Convert to double here
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
        pw.Padding(
            padding: const pw.EdgeInsets.only(left: 2),
            child: pw.Row(
              children: [
                pw.Flexible(
                  flex: 4,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(
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
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.black),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height *
                widget.containerHeightFactor,
            width: MediaQuery.of(context).size.width * 0.47,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Upload Excel File To Generate Payment Slip',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: uploadExcelFile,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Choose File'),
                ),
                const SizedBox(height: 10),
                Text(fileName ?? 'No file selected',
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),

                Text("Please ensure the file name is always set to 'Sheet1'.",style: TextStyle(color: Colors.red.shade300),)
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height *
                widget.containerHeightFactor,
            width: MediaQuery.of(context).size.width * 0.47,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Generate Payment Slip',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: employeeCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Employee Code',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: punchingNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Punching Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: generateSlip,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Enter",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            // SizedBox(width: 20,),
                            Icon(Icons.touch_app, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          generateAllPaymentSlips(
                              context); // Pass `context` from the widget tree here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Generate All Employees Payment Slip",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            // SizedBox(width: 20,),
                            Icon(Icons.payment, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
