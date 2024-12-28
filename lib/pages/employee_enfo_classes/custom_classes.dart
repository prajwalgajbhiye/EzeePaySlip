// employee_info_column.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../test_component.dart';
import '../custom_invoice/generate_invoice.dart';
import '../payment_slip/payment_slip.dart';

class FirstContainer extends StatelessWidget {
  final TextEditingController employeeCodeController;
  final TextEditingController nameController;
  final TextEditingController bankNameController;
  final TextEditingController gradeController;
  final TextEditingController universalAccountNoController;

  final TextEditingController esiNoController;
  final TextEditingController pfAccountNoController;
  final TextEditingController bankAccountNoController;
  final TextEditingController dobController;

  const FirstContainer({
    super.key,
    required this.employeeCodeController,
    required this.nameController,
    required this.bankNameController,
    required this.gradeController,
    required this.esiNoController,
    required this.pfAccountNoController,
    required this.bankAccountNoController,
    required this.universalAccountNoController,
    required this.dobController,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.82,
        width: MediaQuery.of(context).size.width * 0.3,
        // width: MediaQuery.of(context).size.width * 0.9,
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
              label: 'Grade',
              controller: gradeController,
            ),
            CustomTextField(
              label: 'Universal Account No',
              controller: universalAccountNoController,
            ),
            CustomTextField(
              label: 'PF Account No',
              controller: pfAccountNoController,
            ),
            CustomTextField(
              label: 'ESI No',
              controller: esiNoController,
            ),
            CustomTextField(
              label: 'Bank Name',
              controller: bankNameController,
            ),
            CustomTextField(
              label: 'Bank Account No',
              controller: bankAccountNoController,
            ),
            CustomTextField(
              label: 'Date of Birth (e.g., 1-Sep-2000)',
              controller: dobController,
            ),
          ],
        ),
      ),
    );
  }
}

class SecondContainer extends StatelessWidget {
  final TextEditingController workingDaysController;

  final TextEditingController leaveDaysController;
  final TextEditingController phController;
  final TextEditingController weeklyOffController;

  // Calculated amount fields

  const SecondContainer({
    super.key,
    required this.workingDaysController,
    required this.leaveDaysController,
    required this.phController, required this.weeklyOffController,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        // width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.82,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            //

            CustomTextField(
              label: 'Working Days',
              controller: workingDaysController,
            ),
            CustomTextField(
              label: 'Leave Days',
              controller: leaveDaysController,
            ),
            CustomTextField(
              label: 'Ph',
              controller: phController,
            ),CustomTextField(
              label: 'Weekly Off',
              controller: weeklyOffController,
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdContainer extends StatelessWidget {
  final TextEditingController basicWagesRateController;
  final TextEditingController basicWagesAmountController;
  final TextEditingController arrearBasicWagesAmountController;
  final TextEditingController hraRateController;
  final TextEditingController hraAmountController;
  final TextEditingController arrearHraRateController;
  final TextEditingController arrearPerfController;
  final TextEditingController arrearWashController;
  final TextEditingController prefRateController;
  final TextEditingController prefAmountController;
  final TextEditingController washRateController;
  final TextEditingController washAmountController;
  final TextEditingController sheRateController;
  final TextEditingController sheAmountController;

  const ThirdContainer({
    super.key,
    required this.basicWagesRateController,
    required this.basicWagesAmountController,
    required this.arrearBasicWagesAmountController,
    required this.hraRateController,
    required this.hraAmountController,
    required this.arrearHraRateController,
    required this.prefRateController,
    required this.prefAmountController,
    required this.arrearPerfController,
    required this.arrearWashController,
    required this.washRateController,
    required this.washAmountController,
    required this.sheRateController,
    required this.sheAmountController,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        // width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.82,
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
            DeductionRow(
              label: 'Arrear Basic Wages',
              controller: arrearBasicWagesAmountController,
            ),
            EarningRow(
              label: 'HRA',
              rateController: hraRateController,
              amountController: hraAmountController,
            ),
            DeductionRow(
              label: 'Arrear Hra',
              controller: arrearHraRateController,
            ),
            EarningRow(
              label: 'PERF Allowance',
              rateController: prefRateController,
              amountController: prefAmountController,
            ),
            DeductionRow(
              label: 'Arrear PERF Allowance',
              controller: arrearPerfController,
            ),
            EarningRow(
              label: 'Wash Allowance',
              rateController: washRateController,
              amountController: washAmountController,
            ),
            DeductionRow(
              label: 'Arrear Wash Allowance',
              controller: arrearWashController,
            ),
            EarningRow(
              label: 'She Allowance',
              rateController: sheRateController,
              amountController: sheAmountController,
            ),
          ],
        ),
      ),
    );
  }
}

class FourthContainer extends StatefulWidget {
  final TextEditingController specialRateController;
  final TextEditingController specialAmountController;
  final TextEditingController skillRateController;
  final TextEditingController skillAmountController;
  final TextEditingController tiffinAllowanceRateController;
  final TextEditingController tiffinAllowanceAmountController;
  final TextEditingController tiffinReimRateController;
  final TextEditingController tiffinReimAmountController;

  final TextEditingController arrearSheController;

  final TextEditingController medRateController;
  final TextEditingController medAmountController;
  final TextEditingController serviceAllowanceController;
  final TextEditingController arrearMedController;
  final TextEditingController arrearTiffinReimController;
  final TextEditingController otherAllowanceRateController;
  final TextEditingController otherAllowanceAmountController;

  const FourthContainer({
    super.key,
    required this.specialRateController,
    required this.specialAmountController,
    required this.skillRateController,
    required this.skillAmountController,
    required this.tiffinAllowanceRateController,
    required this.tiffinAllowanceAmountController,
    required this.tiffinReimRateController,
    required this.tiffinReimAmountController,
    required this.arrearSheController,
    required this.medRateController,
    required this.medAmountController,
    required this.arrearMedController,
    required this.otherAllowanceRateController,
    required this.otherAllowanceAmountController,
    required this.arrearTiffinReimController,
    required this.serviceAllowanceController,
  });

  @override
  State<FourthContainer> createState() => _FourthContainerState();
}

class _FourthContainerState extends State<FourthContainer> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.82,
        width: MediaQuery.of(context).size.width * 0.3,
        // width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            DeductionRow(
              label: 'Arrear She Allowance',
              controller: widget.arrearSheController,
            ),
            EarningRow(
              label: 'Med Allowance',
              rateController: widget.medRateController,
              amountController: widget.medAmountController,
            ),
            DeductionRow(
              label: 'Arrear Med Allowance',
              controller: widget.arrearMedController,
            ),
            DeductionRow(
              label: 'Service Allowance',
              controller: widget.serviceAllowanceController,
            ),
            EarningRow(
              label: 'Specail Allowance',
              rateController: widget.specialRateController,
              amountController: widget.specialAmountController,
            ),
            EarningRow(
              label: 'Skill Allowance',
              rateController: widget.skillRateController,
              amountController: widget.skillAmountController,
            ),
            EarningRow(
              label: 'Tiffin Allowance',
              rateController: widget.tiffinAllowanceRateController,
              amountController: widget.tiffinAllowanceAmountController,
            ),
            EarningRow(
              label: 'Tiffin REIM',
              rateController: widget.tiffinReimRateController,
              amountController: widget.tiffinReimAmountController,
            ),
            DeductionRow(
              label: 'Arrear Tiffin REIM Allowance',
              controller: widget.arrearTiffinReimController,
            ),
            EarningRow(
              label: 'Other Allowance',
              rateController: widget.otherAllowanceRateController,
              amountController: widget.otherAllowanceAmountController,
            ),
          ],
        ),
      ),
    );
  }
}

class FifthContainer extends StatelessWidget {
  final TextEditingController attAmountController;

  final TextEditingController misclAmountController;
  final TextEditingController overtimeAmountController;
  final TextEditingController leaveEncashmentController;
  final TextEditingController pmgkyAmountController;
  final TextEditingController otRateController;
  final TextEditingController otAmountController;
  final TextEditingController arearAmountController;

  final TextEditingController educationAmountController;
  final TextEditingController heavyDutyAmountController;

  const FifthContainer({
    super.key,
    required this.misclAmountController,
    required this.overtimeAmountController,
    required this.leaveEncashmentController,
    required this.pmgkyAmountController,
    required this.otRateController,
    required this.otAmountController,
    required this.attAmountController,
    required this.arearAmountController,
    required this.educationAmountController,
    required this.heavyDutyAmountController,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.82,
        width: MediaQuery.of(context).size.width * 0.3,
        // width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SixthContainer extends StatelessWidget {
  final TextEditingController pfAmountController;
  final TextEditingController taxAmountController; // Professional Tax fixed

  final TextEditingController gpaAmountController;
  final TextEditingController unionFundAmountController;
  final TextEditingController childrenWelfareFundAmountController;
  final TextEditingController canteenAmountController;
  final TextEditingController wagesAdvanceAmountController;
  final TextEditingController arrearProfessionalTaxAmountController;
  final TextEditingController miscldednController;

  const SixthContainer({
    super.key,
    required this.pfAmountController,
    required this.taxAmountController,
    required this.gpaAmountController,
    required this.unionFundAmountController,
    required this.childrenWelfareFundAmountController,
    required this.canteenAmountController,
    required this.wagesAdvanceAmountController,
    required this.arrearProfessionalTaxAmountController,
    required this.miscldednController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.9,
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.82,
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SectionHeader(
              title: 'Gross Deductions',
            ),
            DeductionRow(
              label: 'Provident Fund',
              controller: pfAmountController,
            ),
            DeductionRow(
              label: 'GPA',
              controller: gpaAmountController,
            ),
            DeductionRow(
              label: 'Union Fund',
              controller: unionFundAmountController,
            ),
            DeductionRow(
              label: 'Contract Labour Children Welfare Fund',
              controller: childrenWelfareFundAmountController,
            ),
            DeductionRow(
              label: 'Canteen',
              controller: canteenAmountController,
            ),
            DeductionRow(
              label: 'WAGES ADVANCE',
              controller: wagesAdvanceAmountController,
            ),
            DeductionRow(
              label: 'MISCL DEDN',
              controller: miscldednController,
            ),
            DeductionRow(
              label: 'Professional Tax',
              controller: taxAmountController,
            ),
            DeductionRow(
              label: 'ARREAR PROFESSIONAL TAX',
              controller: arrearProfessionalTaxAmountController,
            ),
          ],
        ),
      ),
    );
  }
}

class SeventhContainer extends StatefulWidget {
  final TextEditingController pfLoanInterest;
  final TextEditingController labourWelfareFundController;

  final TextEditingController esiAmountController;
  final TextEditingController medicalClaimController;
  final TextEditingController benevolentFundController;
  final TextEditingController incomeTaxController;
  final TextEditingController medicalClaimAmountController;
  final TextEditingController benvolentFundAmountController;
  final TextEditingController incomeTaxAmountController;
  final TextEditingController loanRecoveryAmountController;
  final TextEditingController cmReliefFundAmountController;

  const SeventhContainer({
    super.key,
    required this.pfLoanInterest,
    required this.labourWelfareFundController,
    required this.esiAmountController,
    required this.medicalClaimController,
    required this.benevolentFundController,
    required this.incomeTaxController,
    required this.medicalClaimAmountController,
    required this.benvolentFundAmountController,
    required this.incomeTaxAmountController,
    required this.loanRecoveryAmountController,
    required this.cmReliefFundAmountController,
  });

  @override
  State<SeventhContainer> createState() => _SeventhContainerState();
}

class _SeventhContainerState extends State<SeventhContainer> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        // width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.74,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // DeductionRow(
            //   label: 'Medical Claim',
            //   controller: widget.medicalClaimController,
            // ),
            // DeductionRow(
            //   label: 'Benevolent Fund',
            //   controller: widget.benevolentFundController,
            // ),
            // DeductionRow(
            //   label: 'Income Tax',
            //   controller: widget.incomeTaxController,
            // ),
            //
            // DeductionRow(
            //   label: 'Loan Recovery',
            //   controller: widget.loanRecoveryController,
            // ),

            DeductionRow(
              label: 'LABOUR WELFARE FUND',
              controller: widget.labourWelfareFundController,
            ),
            DeductionRow(
              label: 'CM Relief fund',
              controller: widget.cmReliefFundAmountController,
            ),
            DeductionRow(
              label: 'ESI',
              controller: widget.esiAmountController,
            ),
            DeductionRow(
              label: 'MEDICAL CLAIM',
              controller: widget.medicalClaimAmountController,
            ),
            DeductionRow(
              label: 'BENEVOLENT FUND',
              controller: widget.benvolentFundAmountController,
            ),
            DeductionRow(
              label: 'INCOME TAX',
              controller: widget.incomeTaxAmountController,
            ),
            DeductionRow(
              label: 'LOAN RECOVERY',
              controller: widget.loanRecoveryAmountController,
            ),
            DeductionRow(
                label: 'Pf Loan Interest', controller: widget.pfLoanInterest),

            // Switch for showing/hiding ESI deduction
            // Conditionally show the ESI row based on the switch state
          ],
        ),
      ),
    );
  }
}

class EightContainer extends StatefulWidget {
  const EightContainer({
    super.key,
  });

  @override
  State<EightContainer> createState() => _EightContainerState();
}

class _EightContainerState extends State<EightContainer> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.74,
        width: MediaQuery.of(context).size.width * 0.3,
        // width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          children: [],
        ),
      ),
    );
  }
}

class NinethContainer extends StatefulWidget {
  final TextEditingController grossEarningsController;
  final TextEditingController grossDeductionsController;
  final TextEditingController contractorNameController;
  final void Function(String, int) onMonthYearChanged;
  final TextEditingController netSalaryController;

  const NinethContainer(
      {super.key,
      required this.grossEarningsController,
      required this.grossDeductionsController,
      required this.contractorNameController,
      required this.onMonthYearChanged,
      required this.netSalaryController});

  @override
  State<NinethContainer> createState() => _NinethContainerState();
}

class _NinethContainerState extends State<NinethContainer> {
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

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

  final List<int> years =
      List<int>.generate(20, (index) => DateTime.now().year - 10 + index);

  String selectedMonth = 'January';
  int selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    selectedMonth = months[DateTime.now().month - 1]; // Default current month
    selectedYear = DateTime.now().year; // Default current year

    // Notify parent widget after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onMonthYearChanged(selectedMonth, selectedYear);
    });
  }

  void _updateParentState() {
    widget.onMonthYearChanged(selectedMonth, selectedYear);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.74,
        width: MediaQuery.of(context).size.width * 0.3,
        // width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const SectionHeader(
              title: 'Summary',
            ),
            DeductionRow(
              label: 'Gross Earnings',
              controller: widget.grossEarningsController,
            ),
            DeductionRow(
              label: 'Gross Deductions',
              controller: widget.grossDeductionsController,
            ),
            const SectionHeader(
              title: 'Salary',
            ),
            DeductionRow(
              label: 'Net Salary',
              controller: widget.netSalaryController,
            ),
            Text(
              maxLines: 3,
              widget.netSalaryController.text.isNotEmpty &&
                      double.tryParse(widget.netSalaryController.text) != null
                  ? 'Rupees ${convertNumberToWords(double.parse(widget.netSalaryController.text))} Only'
                  : 'Net salary',
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              // Optional: Center the text if needed
              overflow:
                  TextOverflow.ellipsis, // Optional: Truncate if still too long
              // softWrap: true,
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              value: selectedMonth,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  )),
              items: months.map((month) {
                return DropdownMenuItem(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMonth = value!;
                  _updateParentState();
                });
              },
              hint: const Text('Select Month'),
              isExpanded: true,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: selectedYear,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  )),
              items: years.map((year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text(year.toString()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedYear = value!;
                  _updateParentState();
                });
              },
              hint: const Text('Select Year'),
              isExpanded: true,
            ),
            const SizedBox(
              height: 10,
            ),
            const SectionHeader(
              title: 'Construction Name',
            ),
            DeductionRow(
              label: 'Construction Name',
              controller: widget.contractorNameController,
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
  final TextEditingController contractorNameController;

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
  final TextEditingController arrearHraAmountController;

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
  final TextEditingController arrearBasicWagesAmountController;
  final TextEditingController heavyDutyAmountController;
  final TextEditingController attAmountController;
  final TextEditingController misclEarningController;
  final TextEditingController overtimeAmountController;
  final TextEditingController leaveEncashmentController;
  final TextEditingController pmgkyBenifitController;
  final TextEditingController otDaysController;
  final TextEditingController gpaController;
  final TextEditingController unionFundController;
  final TextEditingController contractLabourChildrenwelfarefundController;
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
  final TextEditingController pfAccountNo;
  final TextEditingController arrearWashAllowanceController;
  final TextEditingController arrearSheAllowanceController;
  final TextEditingController arrearMedAllowanceController;
  final TextEditingController serviceAllowanceController;
  final TextEditingController arrearTiffinReimAllowanceController;
  final TextEditingController arrearPerfAllowanceController;

  // final String selectedMonth;
  // final String selectedYear;

  final String selectedMonth;
  final int selectedYear;

  const GenerateButton({
    super.key,
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
    required this.netSalaryController,
    required this.prfRateController,
    required this.prfAmountController,
    required this.washRateController,
    required this.washAmountController,
    required this.sheRateController,
    required this.sheAmountController,
    required this.medRateController,
    required this.medAmountController,
    required this.specialRateController,
    required this.specialAmountController,
    required this.skillRateController,
    required this.skillAmountController,
    required this.tiffinReimRateController,
    required this.tiffinReimAmountController,
    required this.educationAmountController,
    required this.arearOtherAmountController,
    required this.heavyDutyAmountController,
    required this.attAmountController,
    required this.misclEarningController,
    required this.overtimeAmountController,
    required this.leaveEncashmentController,
    required this.pmgkyBenifitController,
    required this.otDaysController,
    required this.gpaController,
    required this.unionFundController,
    required this.contractLabourChildrenwelfarefundController,
    required this.canteenController,
    required this.wagesAdvanceController,
    required this.arrearProfessionaltaxController,
    required this.cmRelifeFundController,
    required this.medicalClaimController,
    required this.benvolentFundController,
    required this.incomeTaxController,
    required this.loanRecoveryController,
    required this.pfLoanInterestController,
    required this.misclDednController,
    required this.labourWelfareFundController,
    required this.otDaysAmountsController,
    required this.selectedMonth,
    required this.selectedYear,
    required this.arrearBasicWagesAmountController,
    required this.arrearHraAmountController,
    required this.pfAccountNo,
    required this.contractorNameController,
    required this.arrearWashAllowanceController,
    required this.arrearSheAllowanceController,
    required this.arrearMedAllowanceController,
    required this.serviceAllowanceController,
    required this.arrearTiffinReimAllowanceController,
    required this.arrearPerfAllowanceController,
  });

  @override
  State<GenerateButton> createState() => _GenerateButtonState();
}

class _GenerateButtonState extends State<GenerateButton> {
  String netSalaryInWords = ''; // Declare this variable here

  @override
  void initState() {
    super.initState();
  }

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
                  basicWagesRate:
                      widget.basicWagesRateController.text.isNotEmpty
                          ? double.parse(widget.basicWagesRateController.text)
                              .toStringAsFixed(2)
                          : '0.00',
                  basicWagesAmount: widget.basicWagesAmountController.text,
                  hraRate: widget.hraRateController.text.isNotEmpty
                      ? double.parse(widget.hraRateController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  hraAmount: widget.hraAmountController.text,
                  tiffinAllowanceRate:
                      widget.tiffinAllowanceRateController.text.isNotEmpty
                          ? double.parse(widget.tiffinAllowanceRateController.text)
                          .toStringAsFixed(2)
                          : '0.00',
                  tiffinAllowanceAmount:
                      widget.tiffinAllowanceAmountController.text,
                  otherAllowanceRate: widget.otherAllowanceRateController.text.isNotEmpty
                      ? double.parse(widget.otherAllowanceRateController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  otherAllowanceAmount:
                      widget.otherAllowanceAmountController.text,
                  providentFund: widget.pfAmountController.text,
                  professionalTax: widget.taxAmountController.text.isNotEmpty
                      ? double.parse(widget.taxAmountController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  employeeStateInsurance: widget.esiAmountController.text,
                  grossEarning: widget.grossEarningsController.text,
                  grossDeduction: widget.grossDeductionsController.text,
                  netSalary: widget.netSalaryController.text,
                  netSalaryInWord: netSalaryInWords,
                  prfRate: widget.prfRateController.text.isNotEmpty
                      ? double.parse(widget.prfRateController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  prfAmount: widget.prfAmountController.text,
                  washAmount: widget.washAmountController.text,
                  washRate: widget.washRateController.text.isNotEmpty
                      ? double.parse(widget.washRateController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  sheRate: widget.sheRateController.text.isNotEmpty
                      ? double.parse(widget.sheRateController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  sheAmount: widget.sheAmountController.text,
                  medRate: widget.medRateController.text.isNotEmpty
                      ? double.parse(widget.medRateController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  medAmount: widget.medAmountController.text,
                  specialRate: widget.specialRateController.text.isNotEmpty
                      ? double.parse(widget.specialRateController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  specialAmount: widget.specialAmountController.text,
                  skillRate: widget.skillRateController.text.isNotEmpty
                      ? double.parse(widget.skillRateController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  skillAmount: widget.skillAmountController.text,
                  tiffinReimRate: widget.tiffinReimRateController.text.isNotEmpty
                      ? double.parse(widget.tiffinReimRateController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  tiffinReimAmount: widget.tiffinReimAmountController.text,
                  arearOtherAmount: widget.arearOtherAmountController.text.isNotEmpty
                      ? double.parse(widget.arearOtherAmountController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  educationAmount: widget.educationAmountController.text.isNotEmpty
                      ? double.parse(widget.educationAmountController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  heavyDutyAmount: widget.heavyDutyAmountController.text.isNotEmpty
                      ? double.parse(widget.heavyDutyAmountController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  attAmount: widget.attAmountController.text.isNotEmpty
                      ? double.parse(widget.attAmountController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  misclEarning: widget.misclEarningController.text.isNotEmpty
                      ? double.parse(widget.misclEarningController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  overtimeAmount: widget.overtimeAmountController.text.isNotEmpty
                      ? double.parse(widget.overtimeAmountController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  leaveEncashment: widget.leaveEncashmentController.text.isNotEmpty
                      ? double.parse(widget.leaveEncashmentController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  pmgkyBenifit: widget.pmgkyBenifitController.text.isNotEmpty
                      ? double.parse(widget.pmgkyBenifitController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  otDays: widget.otDaysController.text.isNotEmpty
                      ? double.parse(widget.otDaysController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  gpa: widget.gpaController.text.isNotEmpty
                      ? double.parse(widget.gpaController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  unionFund: widget.unionFundController.text.isNotEmpty
                      ? double.parse(widget.unionFundController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  canteen: widget.canteenController.text.isNotEmpty
                      ? double.parse(widget.canteenController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  wagesAdvance: widget.wagesAdvanceController.text.isNotEmpty
                      ? double.parse(widget.wagesAdvanceController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  arrearProfessionaltax:
                      widget.arrearProfessionaltaxController.text.isNotEmpty
                          ? double.parse(widget.arrearProfessionaltaxController.text)
                          .toStringAsFixed(2)
                          : '0.00',
                  cmRelifeFund: widget.cmRelifeFundController.text.isNotEmpty
                      ? double.parse(widget.cmRelifeFundController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  medicalClaim: widget.medicalClaimController.text.isNotEmpty
                      ? double.parse(widget.medicalClaimController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  benvolentFund: widget.benvolentFundController.text.isNotEmpty
                      ? double.parse(widget.benvolentFundController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  incomeTax: widget.incomeTaxController.text.isNotEmpty
                      ? double.parse(widget.incomeTaxController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  loanRecovery: widget.loanRecoveryController.text.isNotEmpty
                      ? double.parse(widget.loanRecoveryController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  pfLoanInterest: widget.pfLoanInterestController.text.isNotEmpty
                      ? double.parse(widget.pfLoanInterestController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  misclDedn: widget.misclDednController.text.isNotEmpty
                      ? double.parse(widget.misclDednController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  labourWelfareFund: widget.labourWelfareFundController.text.isNotEmpty
                      ? double.parse(widget.labourWelfareFundController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  otDaysAmounts: widget.otDaysAmountsController.text,
                  month: widget.selectedMonth,
                  year: widget.selectedYear,
                  arrearBasicWages:
                      widget.arrearBasicWagesAmountController.text.isNotEmpty
                          ? double.parse(widget.arrearBasicWagesAmountController.text)
                          .toStringAsFixed(2)
                          : '0.00',
                  arrearHraAmount: widget.arrearHraAmountController.text.isNotEmpty
                      ? double.parse(widget.arrearHraAmountController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  contractLabourChildrenwelfarefund:
                      widget.contractLabourChildrenwelfarefundController.text.isNotEmpty
                          ? double.parse(widget.contractLabourChildrenwelfarefundController.text)
                          .toStringAsFixed(2)
                          : '0.00',
                  contractorName: widget.contractorNameController.text,
                  arrearWashAll: widget.arrearWashAllowanceController.text.isNotEmpty
                      ? double.parse(widget.arrearWashAllowanceController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  arrearSheAll: widget.arrearSheAllowanceController.text.isNotEmpty
                      ? double.parse(widget.arrearSheAllowanceController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  arrearMedAll: widget.arrearMedAllowanceController.text.isNotEmpty
                      ? double.parse(widget.arrearMedAllowanceController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  serviceAll: widget.serviceAllowanceController.text.isNotEmpty
                      ? double.parse(widget.serviceAllowanceController.text)
                      .toStringAsFixed(2)
                      : '0.00',
                  arrearTiffinReimAll:
                      widget.arrearTiffinReimAllowanceController.text.isNotEmpty
                          ? double.parse(widget.arrearTiffinReimAllowanceController.text)
                          .toStringAsFixed(2)
                          : '0.00',
                  arrearPerfAll: widget.arrearPerfAllowanceController.text.isNotEmpty
                      ? double.parse(widget.arrearPerfAllowanceController.text)
                      .toStringAsFixed(2)
                      : '0.00'

                  // Pass selected year
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

class InvoiceTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;

  const InvoiceTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.top,
      expands: true,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        // labelText: "Punching Number",
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
        floatingLabelStyle: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.bold,
        ),
        hintText: hintText,

        hintStyle: TextStyle(color: Colors.grey[400]),
        // prefixIcon: Icon(Icons.edit_note_sharp, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade800, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[500]!),
        ),
        filled: true,
        fillColor: Colors.white70,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
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
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        child: TextField(
          // expands: true,
          // maxLines: null,
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.teal.shade300,
              fontWeight: FontWeight.bold,
            ),
            hintText: 'Enter $label',
            hintStyle: TextStyle(color: Colors.grey[400]),
            // prefixIcon: Icon(Icons.edit_note_sharp, color: Colors.teal),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.teal, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[500]!),
            ),
            filled: true,
            fillColor: Colors.white70,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
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

class CustomSlipSection extends StatelessWidget {
  final double containerHeightFactor;
  final double containerWidthFactor;
  final VoidCallback navigateToGenerateSlip;

  const CustomSlipSection({
    super.key,
    required this.containerHeightFactor,
    required this.navigateToGenerateSlip,
    required this.containerWidthFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * containerHeightFactor,
        width: MediaQuery.of(context).size.width * containerWidthFactor,
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Custom Payment Slip',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Icon(
              Icons.dashboard_customize,
              size: 100,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}

class CustomInvoice extends StatelessWidget {
  final double containerHeightFactor;
  final double containerWidthFactor;

  const CustomInvoice(
      {super.key,
      required this.containerHeightFactor,
      required this.containerWidthFactor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(

          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          height: MediaQuery.of(context).size.height * containerHeightFactor,
          width: MediaQuery.of(context).size.width * containerWidthFactor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create Custom Invoice ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Icon(
                Icons.add_box,
                size: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GenerateInvoice()));
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
                        "Create Invoice",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      // SizedBox(width: 20,),
                      Icon(Icons.payment, color: Colors.white),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
