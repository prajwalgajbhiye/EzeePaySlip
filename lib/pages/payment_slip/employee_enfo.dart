import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'genrate_pay_slip.dart';

class EmployeeInfoDisplayPage extends StatelessWidget {
  final Map<String, String> employeeData;

  const EmployeeInfoDisplayPage({super.key, required this.employeeData});

  String formatDate(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      final DateFormat formatter = DateFormat('d-MMM-yyyy');
      return formatter.format(parsedDate);
    } catch (e) {
      return date; // Return original if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Employee Information'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 600,
          width: screenWidth > 600 ? 1200 : double.infinity,
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
              const Text(
                'Employee Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Divider(thickness: 1.5, height: 20),
              Flexible(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10, // Horizontal space between items
                    runSpacing: 15, // Vertical space between rows
                    children: _buildEmployeeInfoRows(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GeneratePaySlip(
                        employeeCode: employeeData['EMPLOYEE CODE'] ?? '',
                        name: employeeData['EMPLOYEE NAME'] ?? '',
                        bankName: employeeData['BANK NAME'] ?? '',
                        grade: employeeData['GRADE'] ?? '',
                        esi: employeeData['ESI NO'] ?? '',
                        pfAccountNo: employeeData['UAN'] ?? '',
                        dateOfBirth: formatDate(employeeData['DOB'] ?? ''),
                        bankAccountNo: employeeData['BANK A/C NO.'] ?? '',
                        universalAccountNo: employeeData['UAN'] ?? '',
                        workingDays: employeeData['WORKING DAYS'] ?? '',
                        basicWagesRate: employeeData['BASIC WAGES RATE'] ?? '',
                        tiffinAllowance: employeeData['TIFFIN ALLOWANCES'] ??
                            '',
                        hra: employeeData['HRA'] ?? '',
                        washAllowance: employeeData['WASH ALLOWANCE'] ?? '',
                        medAllowance: employeeData['MED ALLOWANCE'] ?? '',
                        sheAllowance: employeeData['SHE ALLOWANCE'] ?? '',
                        prfAllowance: employeeData['PERF ALLOWANCE'] ?? '',
                        tiffinReimAllowance:
                            employeeData['TIFFIN REIM ALLOWANCE'] ?? '',
                        specialAllowance: employeeData['SPECIAL ALLOWANCE'] ??
                            '',
                        skillAllowance: employeeData['SKILL ALLOWANCE'] ?? '',
                        arearOtherAllowance:
                            employeeData['ARREARS OTHER ALLOWANCE'] ?? '',
                        educationAllowance:
                            employeeData['EDUCATION ALLOWANCE'] ?? '',
                        heavyDutyAllowance:
                            employeeData['HEAVY DUTY ALLOWANCE'] ?? '',
                        attAllowance: employeeData['ATT ALLOWANCE'] ?? '',
                        misclEarning: employeeData['MISCL ALLOWANCE'] ?? '',
                        overtimeRate: employeeData['OVERTIME'] ?? '',
                        leaveEncasment: employeeData['LEAVE ENCASHMENT'] ?? '',
                        pmgkyBenifitRate: employeeData['PMGKY'] ?? '',
                        gpa: employeeData['GPA'] ?? '',
                        unionFund: employeeData['UNION FUND'] ?? '',
                        contractLabourChildrenWelfare: employeeData[
                                'CONTRACT LABOUR CHILDREN WELFARE FUND'] ??
                            '',
                        canteen: employeeData['CANTEEN'] ?? '',
                        wagesAdvance: employeeData['WAGES ADVANCE'] ?? '',
                        arrearProfessionalTax:
                            employeeData['ARREARS PROFESSIONAL'] ?? '',
                        cmRelifeFund: employeeData['CM RELIEF FUND'] ?? '',
                        medicalClaim: employeeData['MEDICAL CLAIM'] ?? '',
                        benvolentFund: employeeData['BENEVOLENT FUND'] ?? '',
                        incomeTax: employeeData['INCOME TAX'] ?? '',
                        loanRecovery: employeeData['LOAN RECOVERY'] ?? '',
                        pfLoanInterest: employeeData['PF LOAN INTEREST'] ?? '',
                        otherAllowance: employeeData['OTHER ALLOWANCE'] ?? '',
                        otDays: employeeData['OT DAYS'] ?? '',
                        miscl: employeeData['MISCL DEDN'] ?? '',
                        labourWelfare:
                            employeeData['LABOUR WELFARE FUND'] ?? '',
                        professionalTax:
                            employeeData['PROFESSIONAL TAX'] ?? ''),
                  ));
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
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.add_task, color: Colors.white),
              ],
            ),
          )),
    );
  }

  List<Widget> _buildEmployeeInfoRows() {
    List<Widget> rows = [];
    List<MapEntry<String, String>> entries = employeeData.entries.toList();

    for (int i = 0; i < entries.length; i += 3) {
      List<Widget> rowChildren = [];
      for (int j = i; j < i + 3 && j < entries.length; j++) {
        rowChildren.add(Expanded(
          child: buildDetailColumn(entries[j].key, entries[j].value),
        ));
      }
      rows.add(Row(children: rowChildren));
    }
    return rows;
  }

  Widget buildDetailColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
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
    );
  }
}
