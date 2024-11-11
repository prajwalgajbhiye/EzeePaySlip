import 'package:flutter/material.dart';

class EmployeeDetailsRow extends StatelessWidget {
  final String employeeCode;
  final String name;
  final String bankName;
  final String bankAccountNo;
  final String dateOfBirth;
  final String grade;
  final String pfAccountNo;
  final String universalAccountNo;
  final String esi;

  const EmployeeDetailsRow(
      {super.key,
      required this.employeeCode,
      required this.name,
      required this.bankName,
      required this.bankAccountNo,
      required this.dateOfBirth,
      required this.grade,
      required this.pfAccountNo,
      required this.universalAccountNo,
      required this.esi});

  Widget _buildRow(
    String title1,
    String value1,
    String title2,
    String value2,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 15,
                    child: Text(
                      title1,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (title1.isNotEmpty) ...[
                    const SizedBox(
                      height: 15,
                      child: Text(
                        ":",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(width: 10),
            Flexible(
                flex: 6,
                child: Row(
                  children: [
                    SizedBox(
                      height: 15,
                      child: Text(
                        value1,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ),
                  ],
                )),
            Container(width: 10),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 15,
                    child: Text(
                      title2,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (title2.isNotEmpty) ...[
                    const SizedBox(
                      height: 15,
                      child: Text(
                        ":",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(width: 10),
            Flexible(
              flex: 4,
              child: SizedBox(
                height: 15,
                child: Text(
                  value2,
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        children: [
          _buildRow(
              "Employee Code", employeeCode, "PF Account No.", pfAccountNo),
          _buildRow("Name", name, "Date Of Birth", dateOfBirth),
          _buildRow("Bank Name", bankName, "Bank A/C No.", bankAccountNo),
          _buildRow(
              "Grade", grade, "Universal Account No.", universalAccountNo),
          _buildRow("ESI", esi, "", ""),
        ],
      ),
    );
  }
}

class DetailsRow2 extends StatelessWidget {
  final String workingDays;
  final String weeklyOff;
  final String leaveDay;
  final String ph;

  const DetailsRow2(
      {super.key,
      required this.workingDays,
      required this.weeklyOff,
      required this.leaveDay,
      required this.ph});

  Widget _buildRow(
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
    return Row(
      children: [
        Flexible(
          flex: 7,
          child: Container(
            // width: MediaQuery.of(context).size.width*0.2,

            decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey))),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container(width: 10),
        Flexible(
            flex: 6,
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // color: Colors.blue,
                    height: 15,
                    child: Text(
                      title1,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    // color: Colors.purple,
                    height: 15,
                    child: Text(
                      value1,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        // Container(width: 10),
        Flexible(
          flex: 6,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // color: Colors.grey,
                  height: 15,
                  child: Text(
                    title2,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  // color: Colors.green,
                  height: 15,
                  child: Text(
                    value2,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container(width: 10),
        Flexible(
          flex: 6,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // color: Colors.blueAccent,
                  height: 15,
                  child: Text(
                    title3,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  // color: Colors.greyAccent,
                  height: 15,
                  child: Text(
                    value3,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container(width: 10),
        Flexible(
          flex: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // color: Colors.orange,
                height: 15,
                child: Text(
                  title4,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                // color: Colors.orangeAccent,
                height: 15,
                child: Text(
                  value4,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Container(width: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        children: [
          _buildRow("Attendence Details :", "Working Days :", workingDays,
              "Weekly Off :", weeklyOff, "Leave Days :", leaveDay, "PH :", ph),
        ],
      ),
    );
  }
}

class DetailsRow3 extends StatelessWidget {
  final String basicWagesRate;
  final String basicWagesAmount;
  final String hraRate;
  final String hraAmount;
  final String tiffinAllowanceRate;
  final String tiffinAllowanceAmount;
  final String otherAllowanceRate;
  final String otherAllowanceAmount;
  final String providentFund;
  final String professionalTax;
  final String employeeStateInsurance;

  const DetailsRow3(
      {super.key,
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
      required this.employeeStateInsurance});

  Widget _buildRow(
    String title1,
    String title2,
    String title3,
    String title4,
    String title5,
    // String title2,
    // String value2,
  ) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(color: Colors.grey),
                  // bottom: BorderSide(color: Colors.grey),
                  right: BorderSide(color: Colors.grey))),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        border: Border(
                            // bottom: BorderSide(color: Colors.grey),
                            //   right: BorderSide(color: Colors.grey)
                            )),
                    child: Text(
                      title1,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      border: Border(
                          // bottom: BorderSide(color: Colors.grey),
                          //   right: BorderSide(color: Colors.grey)
                          )),
                  child: Text(
                    title2,
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      border: Border(
                          // bottom: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey))),
                  child: Text(
                    title3,
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        border: Border(
                            // bottom: BorderSide(color: Colors.grey),
                            //   right: BorderSide(color: Colors.grey)
                            )),
                    child: Text(
                      title4,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      border: Border(
                          // bottom: BorderSide(color: Colors.grey),
                          //   right: BorderSide(color: Colors.black)
                          )),
                  child: Text(
                    title5,
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              // left: BorderSide(
              //   color: Colors.grey,
              // ),
              // right: BorderSide(color: Colors.grey),
              // bottom: BorderSide(color: Colors.grey),
              // top: BorderSide(color: Colors.grey)
              )),
      child: Column(
        children: [
          _buildRow(
            "Basic wages",
            basicWagesRate,
            basicWagesAmount,
            "Provident Fund",
            providentFund,
          ),
          _buildRow(
            "HRA",
            hraRate,
            hraAmount,
            "Professional Tax",
            professionalTax,
          ),
          _buildRow(
            "Tiffin Allowance",
            tiffinAllowanceRate,
            tiffinAllowanceAmount,
            "Employee State Insurance",
            employeeStateInsurance,
          ),
          _buildRow(
            "Other Allowance",
            otherAllowanceRate,
            otherAllowanceAmount,
            "",
            "",
          ),
        ],
      ),
    );
  }
}



class EarningPaymentRow extends StatelessWidget {
  final String title1;
  final String title2;
  final String title3;

  const EarningPaymentRow({
    super.key,
    required this.title1,
    required this.title2,
    required this.title3,
  });

  @override
  Widget build(BuildContext context) {
    final double value2 = double.tryParse(title2) ?? 0;
    final double value3 = double.tryParse(title3) ?? 0;

    // Skip rendering this row if both values are zero
    if (value2 == 0 && value3 == 0) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width*0.2415,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.only(left: 2),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey),
                ),
              ),
              child: Text(
                title1,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                title2,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey),
                ),
              ),
              child: Text(
                title3,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class DeductionPaymentRow extends StatelessWidget {
  final String title4;
  final String title5;

  const DeductionPaymentRow({
    super.key,
    required this.title4,
    required this.title5,
  });

  @override
  Widget build(BuildContext context) {
    final double value5 = double.tryParse(title5) ?? 0;

    // Skip rendering this row if the value is zero
    if (value5 == 0) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      // color: Colors.red,
      width: MediaQuery.of(context).size.width*0.180,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.only(left: 2),
              alignment: Alignment.centerLeft,
              // decoration: const BoxDecoration(
              //   border: Border(
              //     left: BorderSide(color: Colors.grey),
              //   ),
              // ),
              child: Text(
                title4,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                title5,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class DetailsRow4 extends StatelessWidget {
  const DetailsRow4({super.key});

  Widget _buildRow(
    String title1,
    String title2,
    String title3,
    String title4,
    String title5,
    // String title2,
    // String value2,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(
                        // bottom: BorderSide(color: Colors.grey),
                        right: BorderSide(color: Colors.grey))),
                child: Text(
                  title1,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(
                        // bottom: BorderSide(color: Colors.grey),
                        right: BorderSide(color: Colors.grey))),
                child: Text(
                  title2,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(
                        // bottom: BorderSide(color: Colors.grey),
                        right: BorderSide(color: Colors.grey))),
                child: Text(
                  title3,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(
                        // bottom: BorderSide(color: Colors.grey),
                        right: BorderSide(color: Colors.grey))),
                child: Text(
                  title4,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(
                        // bottom: BorderSide(color: Colors.grey),
                        //   right: BorderSide(color: Colors.grey)
                        )),
                child: Text(
                  title5,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              left: BorderSide(
                color: Colors.grey,
              ),
              right: BorderSide(color: Colors.grey),
              bottom: BorderSide(color: Colors.grey),
              top: BorderSide(color: Colors.grey))),
      child: Column(
        children: [
          _buildRow(
            "Earning",
            "Rate",
            "Amount",
            "Deduction",
            "Amount",
          ),
        ],
      ),
    );
  }
}

class DetailsRow5 extends StatelessWidget {
  final String grossEarning;
  final String grossDeduction;

  const DetailsRow5(
      {super.key, required this.grossEarning, required this.grossDeduction});

  Widget _buildRow(
    String title1,
    String title2,
    String title3,
    String title4,
  ) {
    return Row(
      children: [
        Flexible(
          flex: 6,
          child: Container(
            // width: MediaQuery.of(context).size.width*0.2,

            decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey))),
            child: Row(
              children: [
                Text(
                  title1,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container(width: 10),
        // Container(width: 10),
        Flexible(
          flex: 2,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // color: Colors.grey,
                  height: 15,
                  child: Text(
                    title2,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container(width: 10),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey))),
              child: SizedBox(
                // color: Colors.blueAccent,
                height: 15,
                child: Text(
                  title3,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Container(width: 10),
        Flexible(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // color: Colors.orange,
                height: 15,
                child: Text(
                  title4,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Container(width: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        children: [
          _buildRow(
              "Gross Earning", grossEarning, "Gross Deduction", grossDeduction),
        ],
      ),
    );
  }
}

class DetailsRow6 extends StatelessWidget {
  final String netSalary;

  const DetailsRow6({super.key, required this.netSalary});

  Widget _buildRow(String title1, String value) {
    return Row(
      children: [
        Flexible(
          flex: 6,
          child: Container(
            // width: MediaQuery.of(context).size.width*0.2,

            decoration: const BoxDecoration(),
            child: Row(
              children: [
                Text(
                  title1,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              left: BorderSide(color: Colors.grey),
              bottom: BorderSide(color: Colors.grey),
              right: BorderSide(color: Colors.grey))),
      child: Column(
        children: [
          _buildRow("Net Salary :", netSalary),
        ],
      ),
    );
  }
}

class DetailsRow7 extends StatelessWidget {
  final String netSalaryInWord;

  const DetailsRow7({super.key, required this.netSalaryInWord});


  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        const Text(
          "Amount in Words: ",
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
         "Rupees $netSalaryInWord only",  // Display netSalaryInWords here
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}






