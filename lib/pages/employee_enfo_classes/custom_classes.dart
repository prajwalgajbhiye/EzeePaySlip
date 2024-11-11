// employee_info_column.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../payment_slip/payment_slip.dart';

class EmployeeInfoColumn extends StatelessWidget {
  final TextEditingController employeeCodeController;
  final TextEditingController nameController;
  final TextEditingController bankNameController;
  final TextEditingController gradeController;
  final TextEditingController esiNoController;
  final TextEditingController pfAccountNoController;
  final TextEditingController dobController;
  final TextEditingController bankAccountNoController;
  final TextEditingController universalAccountNoController;
  final TextEditingController workingDaysController;
  final TextEditingController weeklyOffController;

  const EmployeeInfoColumn({
    super.key,
    required this.employeeCodeController,
    required this.nameController,
    required this.bankNameController,
    required this.gradeController,
    required this.esiNoController,
    required this.pfAccountNoController,
    required this.dobController,
    required this.bankAccountNoController,
    required this.universalAccountNoController,
    required this.workingDaysController,
    required this.weeklyOffController,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: screenHeight > 200 ? 700 : double.infinity,
        width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SectionHeader(
              title: 'Employee Information',
            ),
            CustomTextField(
              label: 'Employee Code',
              controller: employeeCodeController,
            ),
            CustomTextField(
              label: 'Name',
              controller: nameController,
            ),
            CustomTextField(
              label: 'Bank Name',
              controller: bankNameController,
            ),
            CustomTextField(
              label: 'Grade',
              controller: gradeController,
            ),
            CustomTextField(
              label: 'ESI No',
              controller: esiNoController,
            ),
            CustomTextField(
              label: 'PF Account No',
              controller: pfAccountNoController,
            ),
            CustomTextField(
              label: 'Date of Birth (e.g., 1-Sep-2000)',
              controller: dobController,
            ),
            CustomTextField(
              label: 'Bank Account No',
              controller: bankAccountNoController,
            ),
            CustomTextField(
              label: 'Universal Account No',
              controller: universalAccountNoController,
            ),
            CustomTextField(
              label: 'Working Days',
              controller: workingDaysController,
            ),
            CustomTextField(
              label: 'Weekly Off',
              controller: weeklyOffController,
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomTextField(
      {super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class EarningRow extends StatelessWidget {
  final String label;
  final TextEditingController rateController;
  final TextEditingController amountController;

  const EarningRow(
      {super.key,
      required this.label,
      required this.rateController,
      required this.amountController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomTextField(
              label: '$label Rate',
              controller: rateController,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: CustomTextField(
              label: '$label Amount',
              controller: amountController,
            ),
          ),
        ],
      ),
    );
  }
}

class EarningColumn extends StatelessWidget {
  final TextEditingController basicWagesRateController;

  final TextEditingController hraRateController;
  final TextEditingController tiffinAllowanceRateController;
  final TextEditingController tiffinAllowanceAmountController;

  // Calculated amount fields
  final TextEditingController basicWagesAmountController;

  final TextEditingController hraAmountController;

  final TextEditingController prefRateController;

  final TextEditingController prefAmountController;

  final TextEditingController washRateController;

  final TextEditingController washAmountController;

  final TextEditingController sheRateController;

  final TextEditingController sheAmountController;

  final TextEditingController medRateController;

  final TextEditingController medAmountController;

  final TextEditingController tiffinReimRateController;

  final TextEditingController tiffinReimAmountController;

  final TextEditingController specialRateController;

  final TextEditingController specialAmountController;

  final TextEditingController skillRateController;

  final TextEditingController skillAmountController;

  const EarningColumn(
      {super.key,
      required this.basicWagesRateController,
      required this.hraRateController,
      required this.tiffinAllowanceRateController,
      required this.basicWagesAmountController,
      required this.hraAmountController,
      required this.tiffinAllowanceAmountController,
      required this.prefRateController,
      required this.prefAmountController,
      required this.washRateController,
      required this.washAmountController,
      required this.sheRateController,
      required this.sheAmountController,
      required this.medRateController,
      required this.medAmountController,
      required this.tiffinReimRateController,
      required this.tiffinReimAmountController,
      required this.specialRateController,
      required this.specialAmountController,
      required this.skillRateController,
      required this.skillAmountController});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: screenHeight > 200 ? 700 : double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const SectionHeader(
              title: 'Gross Earnings',
            ),
            EarningRow(
              label: 'Basic Wages',
              rateController: basicWagesRateController,
              amountController: basicWagesAmountController,
            ),
            EarningRow(
              label: 'HRA',
              rateController: hraRateController,
              amountController: hraAmountController,
            ),
            EarningRow(
              label: 'PRF Allowance',
              rateController: prefRateController,
              amountController: prefAmountController,
            ),
            EarningRow(
              label: 'Wash Allowance',
              rateController: washRateController,
              amountController: washAmountController,
            ),
            EarningRow(
              label: 'She Allowance',
              rateController: sheRateController,
              amountController: sheAmountController,
            ),
            EarningRow(
              label: 'Med Allowance',
              rateController: medRateController,
              amountController: medAmountController,
            ),
            EarningRow(
              label: 'Specail Allowance',
              rateController: specialRateController,
              amountController: specialAmountController,
            ),
            EarningRow(
              label: 'Skill Allowance',
              rateController: skillRateController,
              amountController: skillAmountController,
            ),
            EarningRow(
              label: 'Tiffin Allowance',
              rateController: tiffinAllowanceRateController,
              amountController: tiffinAllowanceAmountController,
            ),
            EarningRow(
              label: 'Tiffin REIM',
              rateController: tiffinReimRateController,
              amountController: tiffinReimAmountController,
            ),
          ],
        ),
      ),
    );
  }
}

class EarningColumnTwo extends StatelessWidget {
  final TextEditingController arearAmountController;

  final TextEditingController educationAmountController;

  final TextEditingController heavyDutyAmountController;

  final TextEditingController attAmountController;

  final TextEditingController misclAmountController;

  final TextEditingController overtimeAmountController;

  final TextEditingController leaveEncashmentController;

  final TextEditingController pmgkyAmountController;
  final TextEditingController otherAllowanceRateController;
  final TextEditingController otherAllowanceAmountController;
  final TextEditingController otRateController;
  final TextEditingController otAmountController;

  const EarningColumnTwo(
      {super.key,
      required this.arearAmountController,
      required this.attAmountController,
      required this.misclAmountController,
      required this.leaveEncashmentController,
      required this.pmgkyAmountController,
      required this.otherAllowanceRateController,
      required this.otherAllowanceAmountController,
      required this.otRateController,
      required this.otAmountController,
      required this.educationAmountController,
      required this.heavyDutyAmountController,
      required this.overtimeAmountController});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: screenHeight > 200 ? 700 : double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            EarningRow(
              label: 'Other Allowance',
              rateController: otherAllowanceRateController,
              amountController: otherAllowanceAmountController,
            ),
            DeductionRow(
              label: 'Arear Other Allowance',
              controller: arearAmountController,
            ),
            DeductionRow(
              label: 'Education Allowance',
              controller: educationAmountController,
            ),
            DeductionRow(
              label: 'Heavy Duty Allowance',
              controller: heavyDutyAmountController,
            ),
            DeductionRow(
              label: 'Att Allowance',
              controller: attAmountController,
            ),
            DeductionRow(
              label: 'MISCL Earning',
              controller: misclAmountController,
            ),
            DeductionRow(
              label: 'Overtime',
              controller: overtimeAmountController,
            ),
            DeductionRow(
              label: 'LEAVE ENCASHMENT',
              controller: leaveEncashmentController,
            ),
            DeductionRow(
              label: 'PMGKY BENEFIT',
              controller: pmgkyAmountController,
            ),
            EarningRow(
              label: 'Ot Days',
              rateController: otRateController,
              amountController: otAmountController,
            ),
          ],
        ),
      ),
    );
  }
}

class DeductionRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const DeductionRow(
      {super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: label,
      controller: controller,
    );
  }
}

class DeductionColumn extends StatefulWidget {
  final TextEditingController pfAmountController;
  final TextEditingController taxAmountController; // Professional Tax fixed
  final TextEditingController esiAmountController;
  final TextEditingController gpaAmountController;
  final TextEditingController unionFundAmountController;
  final TextEditingController childrenWelfareFundAmountController;
  final TextEditingController canteenAmountController;
  final TextEditingController wagesAdvanceAmountController;
  final TextEditingController miscldednController;
  final TextEditingController arrearProfessionalTaxAmountController;
  final TextEditingController cmReliefFundAmountController;

  const DeductionColumn({
    super.key,
    required this.pfAmountController,
    required this.esiAmountController,
    required this.gpaAmountController,
    required this.unionFundAmountController,
    required this.childrenWelfareFundAmountController,
    required this.canteenAmountController,
    required this.wagesAdvanceAmountController,
    required this.arrearProfessionalTaxAmountController,
    required this.cmReliefFundAmountController,
    required this.miscldednController,
    required this.taxAmountController,
  });

  @override
  _DeductionColumnState createState() => _DeductionColumnState();
}

class _DeductionColumnState extends State<DeductionColumn> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: screenHeight > 200 ? 700 : double.infinity,
        width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const SectionHeader(
              title: 'Gross Deductions',
            ),
            DeductionRow(
              label: 'Provident Fund',
              controller: widget.pfAmountController,
            ),
            DeductionRow(
              label: 'Professional Tax',
              controller: widget.taxAmountController,
            ),
            // Switch for showing/hiding ESI deduction
            // Conditionally show the ESI row based on the switch state
            DeductionRow(
              label: 'ESI',
              controller: widget.esiAmountController,
            ),
            DeductionRow(
              label: 'GPA',
              controller: widget.gpaAmountController,
            ),
            DeductionRow(
              label: 'Union Fund',
              controller: widget.unionFundAmountController,
            ),
            DeductionRow(
              label: 'CONTRACT LABOUR CHILDREN WELFARE FUND',
              controller: widget.childrenWelfareFundAmountController,
            ),
            DeductionRow(
              label: 'Canteen',
              controller: widget.canteenAmountController,
            ),
            DeductionRow(
              label: 'WAGES ADVANCE',
              controller: widget.wagesAdvanceAmountController,
            ),
            DeductionRow(
              label: 'MISCL DEDN',
              controller: widget.miscldednController,
            ),
            DeductionRow(
              label: 'ARREAR PROFESSIONAL TAX',
              controller: widget.arrearProfessionalTaxAmountController,
            ),
            DeductionRow(
              label: 'CM RELIEF FUND',
              controller: widget.cmReliefFundAmountController,
            ),
          ],
        ),
      ),
    );
  }
}

class Summary extends StatelessWidget {
  final TextEditingController medicalClaimAmountController;
  final TextEditingController labourWelfareFundController;
  final TextEditingController benvolentFundAmountController;
  final TextEditingController incomeTaxAmountController;
  final TextEditingController loanRecoveryAmountController;
  final TextEditingController pfLoanInterestAmountController;
  final TextEditingController grossEarningsController;
  final TextEditingController grossDeductionsController;
  final TextEditingController netSalaryController;

  const Summary({
    super.key,
    required this.medicalClaimAmountController,
    required this.benvolentFundAmountController,
    required this.incomeTaxAmountController,
    required this.loanRecoveryAmountController,
    required this.pfLoanInterestAmountController,
    required this.grossEarningsController,
    required this.grossDeductionsController,
    required this.netSalaryController,
    required this.labourWelfareFundController,
  });

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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: screenHeight > 200 ? 700 : double.infinity,
        width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            DeductionRow(
              label: 'LABOUR WELFARE FUND',
              controller: labourWelfareFundController,
            ),
            DeductionRow(
              label: 'MEDICAL CLAIM',
              controller: medicalClaimAmountController,
            ),
            DeductionRow(
              label: 'BENEVOLENT FUND',
              controller: benvolentFundAmountController,
            ),
            DeductionRow(
              label: 'INCOME TAX',
              controller: incomeTaxAmountController,
            ),
            DeductionRow(
              label: 'LOAN RECOVERY',
              controller: loanRecoveryAmountController,
            ),
            DeductionRow(
              label: 'PF LOAN INTEREST',
              controller: pfLoanInterestAmountController,
            ),
            const SizedBox(height: 20),
            const SectionHeader(
              title: 'Summary',
            ),
            DeductionRow(
              label: 'Gross Earnings',
              controller: grossEarningsController,
            ),
            DeductionRow(
              label: 'Gross Deductions',
              controller: grossDeductionsController,
            ),
            const SectionHeader(
              title: 'Salary',
            ),
            DeductionRow(
              label: 'Net Salary',
              controller: netSalaryController,
            ),
            Text(
              maxLines: 3,
              netSalaryController.text.isNotEmpty &&
                      double.tryParse(netSalaryController.text) != null
                  ? 'Rupees ${convertNumberToWords(double.parse(netSalaryController.text))} Only'
                  : 'Net salary',
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              // Optional: Center the text if needed
              overflow:
                  TextOverflow.ellipsis, // Optional: Truncate if still too long
              // softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const SummaryRow({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CustomTextField(
        label: label,
        controller: controller,
      ),
    );
  }
}

class MonthContainer extends StatefulWidget {
  const MonthContainer({super.key});

  @override
  State<MonthContainer> createState() => _MonthContainerState();
}

class _MonthContainerState extends State<MonthContainer> {
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectedMonth = months[now.month - 1];
    selectedYear = now.year.toString();
  }

  String? selectedMonth;
  String? selectedYear;

  final List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  final List<String> years = ["2023", "2024", "2025", "2026", "2027"];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: screenHeight > 200 ? 300 : double.infinity,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Select Month & Year",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedMonth,
              hint: const Text("Select Month"),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              items: months.map((String month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMonth = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedYear,
              hint: const Text("Select Year"),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              items: years.map((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedYear = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GenerateButton extends StatefulWidget {
  final TextEditingController employeeCodeController;

  final TextEditingController nameController;

  final TextEditingController bankNameController;

  final TextEditingController bankAccountNoController;

  final TextEditingController dobController;

  final TextEditingController gradeController;

  final TextEditingController pfAccountNoController;

  final TextEditingController universalAccountNoController;

  final TextEditingController esiNoController;

  final TextEditingController workingDaysController;

  final TextEditingController weeklyOffController;

  final TextEditingController leaveDaysController;

  final TextEditingController phController;

  final TextEditingController basicWagesRateController;

  final TextEditingController basicWagesAmountController;

  final TextEditingController hraRateController;

  final TextEditingController hraAmountController;

  final TextEditingController tiffinAllowanceRateController;

  final TextEditingController tiffinAllowanceAmountController;

  final TextEditingController otherAllowanceRateController;

  final TextEditingController otherAllowanceAmountController;

  final TextEditingController pfAmountController;

  final TextEditingController taxAmountController;

  final TextEditingController esiAmountController;

  final TextEditingController grossEarningsController;

  final TextEditingController grossDeductionsController;

  final TextEditingController netSalaryController;
  final TextEditingController prfRateController;
  final TextEditingController prfAmountController;
  final TextEditingController washRateController;
  final TextEditingController washAmountController;
  final TextEditingController sheRateController;
  final TextEditingController sheAmountController;
  final TextEditingController medRateController;
  final TextEditingController medAmountController;
  final TextEditingController specialRateController;
  final TextEditingController specialAmountController;
  final TextEditingController skillRateController;
  final TextEditingController skillAmountController;
  final TextEditingController tiffinReimRateController;
  final TextEditingController tiffinReimAmountController;
  final TextEditingController educationAmountController;
  final TextEditingController arearOtherAmountController;
  final TextEditingController heavyDutyAmountController;
  final TextEditingController attAmountController;
  final TextEditingController misclEarningController;
  final TextEditingController overtimeAmountController;
  final TextEditingController leaveEncashmentController;
  final TextEditingController pmgkyBenifitController;
  final TextEditingController otDaysController;
  final TextEditingController gpaController;
  final TextEditingController unionFundController;
  final TextEditingController contractLabourwelfarefundController;
  final TextEditingController canteenController;
  final TextEditingController wagesAdvanceController;
  final TextEditingController arrearProfessionaltaxController;
  final TextEditingController cmRelifeFundController;
  final TextEditingController medicalClaimController;
  final TextEditingController benvolentFundController;
  final TextEditingController incomeTaxController;
  final TextEditingController loanRecoveryController;
  final TextEditingController pfLoanInterestController;
  final TextEditingController misclDednController;
  final TextEditingController labourWelfareFundController;
  final TextEditingController otDaysAmountsController;




  const GenerateButton(
      {super.key,
      required this.employeeCodeController,
      required this.nameController,
      required this.bankNameController,
      required this.bankAccountNoController,
      required this.dobController,
      required this.gradeController,
      required this.pfAccountNoController,
      required this.universalAccountNoController,
      required this.esiNoController,
      required this.workingDaysController,
      required this.weeklyOffController,
      required this.leaveDaysController,
      required this.phController,
      required this.basicWagesRateController,
      required this.basicWagesAmountController,
      required this.hraRateController,
      required this.hraAmountController,
      required this.tiffinAllowanceRateController,
      required this.tiffinAllowanceAmountController,
      required this.otherAllowanceRateController,
      required this.otherAllowanceAmountController,
      required this.pfAmountController,
      required this.taxAmountController,
      required this.esiAmountController,
      required this.grossEarningsController,
      required this.grossDeductionsController,
      required this.netSalaryController, required this.prfRateController, required this.prfAmountController, required this.washRateController, required this.washAmountController, required this.sheRateController, required this.sheAmountController, required this.medRateController, required this.medAmountController, required this.specialRateController, required this.specialAmountController, required this.skillRateController, required this.skillAmountController, required this.tiffinReimRateController, required this.tiffinReimAmountController, required this.educationAmountController, required this.arearOtherAmountController, required this.heavyDutyAmountController, required this.attAmountController, required this.misclEarningController, required this.overtimeAmountController, required this.leaveEncashmentController, required this.pmgkyBenifitController, required this.otDaysController, required this.gpaController, required this.unionFundController, required this.contractLabourwelfarefundController, required this.canteenController, required this.wagesAdvanceController, required this.arrearProfessionaltaxController, required this.cmRelifeFundController, required this.medicalClaimController, required this.benvolentFundController, required this.incomeTaxController, required this.loanRecoveryController, required this.pfLoanInterestController, required this.misclDednController, required this.labourWelfareFundController, required this.otDaysAmountsController});

  @override
  State<GenerateButton> createState() => _GenerateButtonState();
}

class _GenerateButtonState extends State<GenerateButton> {
  String netSalaryInWords = ''; // Declare this variable here

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectedMonth = months[now.month - 1];
    selectedYear = now.year.toString();
  }

  String? selectedMonth;
  String? selectedYear;
  final List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  final List<String> years = ["2023", "2024", "2025", "2026", "2027"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Set the button's height
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4, // Slight elevation for a professional look
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentSlip(
                employeeCode: widget.employeeCodeController.text,
                name: widget.nameController.text,
                bankName: widget.bankNameController.text,
                bankAccountNo: widget.bankAccountNoController.text,
                dateOfBirth: widget.dobController.text,
                grade: widget.gradeController.text,
                pfAccountNo: widget.pfAccountNoController.text,
                universalAccountNo: widget.universalAccountNoController.text,
                esi: widget.esiNoController.text,
                workingDays: widget.workingDaysController.text,
                weeklyOff: widget.weeklyOffController.text,
                leaveDay: widget.leaveDaysController.text,
                ph: widget.phController.text,
                basicWagesRate: widget.basicWagesRateController.text,
                basicWagesAmount: widget.basicWagesAmountController.text,
                hraRate: widget.hraRateController.text,
                hraAmount: widget.hraAmountController.text,
                tiffinAllowanceRate: widget.tiffinAllowanceRateController.text,
                tiffinAllowanceAmount:
                    widget.tiffinAllowanceAmountController.text,
                otherAllowanceRate: widget.otherAllowanceRateController.text,
                otherAllowanceAmount:
                    widget.otherAllowanceAmountController.text,
                providentFund: widget.pfAmountController.text,
                professionalTax: widget.taxAmountController.text,
                employeeStateInsurance: widget.esiAmountController.text,
                grossEarning: widget.grossEarningsController.text,
                grossDeduction: widget.grossDeductionsController.text,
                netSalary: widget.netSalaryController.text,
                netSalaryInWord: netSalaryInWords,
                month: selectedMonth ?? '',
                year: selectedYear ?? '',
                prfRate:  widget.prfRateController.text,
                prfAmount:widget.prfAmountController.text,
                washAmount: widget.washAmountController.text,
                washRate: widget.washRateController.text,
                sheRate: widget.sheRateController.text,
                sheAmount: widget.sheAmountController.text,
                medRate: widget.medRateController.text,
                medAmount:widget.medAmountController.text,
                specialRate: widget.specialRateController.text,
                specialAmount: widget.specialAmountController.text,
                skillRate: widget.skillRateController.text,
                skillAmount:widget.skillAmountController.text,
                tiffinReimRate:widget.tiffinReimRateController.text,
                tiffinReimAmount: widget.tiffinReimAmountController.text,
                arearOtherAmount:widget.arearOtherAmountController.text,
                educationAmount: widget.educationAmountController.text,
                heavyDutyAmount:widget.heavyDutyAmountController.text,
                attAmount: widget.attAmountController.text,
                misclEarning:widget.misclEarningController.text,
                overtimeAmount: widget.overtimeAmountController.text,
                leaveEncashment: widget.leaveEncashmentController.text,
                pmgkyBenifit: widget.pmgkyBenifitController.text,
                otDays: widget.otDaysController.text,
                gpa: widget.gpaController.text,
                unionFund: widget.unionFundController.text,
                contractLabourwelfarefund: widget.contractLabourwelfarefundController.text,
                canteen: widget.canteenController.text,
                wagesAdvance: widget.wagesAdvanceController.text,
                arrearProfessionaltax: widget.arrearProfessionaltaxController.text,
                cmRelifeFund: widget.cmRelifeFundController.text,
                medicalClaim: widget.medicalClaimController.text,
                benvolentFund: widget.benvolentFundController.text,
                incomeTax: widget.incomeTaxController.text,
                loanRecovery: widget.loanRecoveryController.text,
                pfLoanInterest: widget.pfLoanInterestController.text,
                misclDedn: widget.misclDednController.text,
                labourWelfareFund: widget.labourWelfareFundController.text,
                otDaysAmounts: widget.otDaysAmountsController.text,
              ),
            ),
          );
        },
        child: const Text(
          'Generate Slip',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

class CustomSlipSection extends StatelessWidget {
  final double containerHeightFactor;
  final VoidCallback navigateToGenerateSlip;

  const CustomSlipSection({
    super.key,
    required this.containerHeightFactor,
    required this.navigateToGenerateSlip,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * containerHeightFactor,
        width: MediaQuery.of(context).size.width * 0.47,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Custom Payment Slip',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: navigateToGenerateSlip,
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
                      "Generate Slip",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    // SizedBox(width: 20,),
                    Icon(Icons.payment, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
