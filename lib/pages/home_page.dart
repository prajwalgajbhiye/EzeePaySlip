import 'package:EzeePayslip/pages/employee_enfo_classes/custom_classes.dart';
import 'package:EzeePayslip/pages/popup_page/popup.dart';
import 'package:EzeePayslip/pages/upload_file/upload_file_row.dart';
import 'package:flutter/material.dart';
import 'package:EzeePayslip/pages/payment_slip/genrate_pay_slip.dart';
import 'package:EzeePayslip/pages/upload_file/overtime_file.dart';
import 'package:EzeePayslip/pages/custom_invoice/generate_invoice.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    PopupManager().initialize();
    // PopupManager().addDesiredTime(30);
    // PopupManager().addDesiredTime(20);
    // PopupManager().addDesiredTime(20);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    PopupManager().dispose();

    super.dispose();
  }
  void _showEmployeeTablePopup(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "EmployeeTable",
      transitionDuration: const Duration(milliseconds: 700),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: Curves.easeInOutBack.transform(animation.value),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          child: EmployeeTablePopup(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,

        actions: [  IconButton(
            onPressed: () {
              _showEmployeeTablePopup(context);
            },
            icon: const Icon(Icons.lightbulb, color: Colors.white,)), const SizedBox(width:10)],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FileUploadSection(
              containerHeightFactor: 0.42,
              containerWidthFactor: 0.47,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const FileUploadForOtSection(
                  containerHeightFactor: 0.42,
                  containerWidthFactor: 0.47,
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Container(

                    height: MediaQuery.of(context).size.height *0.42,
                    width: MediaQuery.of(context).size.width *0.47,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomSlipSection(
                          containerHeightFactor: 0.42,
                          containerWidthFactor: 0.2,
                          navigateToGenerateSlip: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GeneratePaySlip(
                                  employeeCode: '',
                                  name: '',
                                  bankName: '',
                                  grade: '',
                                  esi: '',
                                  pfAccountNo: '',
                                  dateOfBirth: '',
                                  bankAccountNo: '',
                                  universalAccountNo: '',
                                  workingDays: '',
                                  basicWagesRate: '',
                                  tiffinAllowance: '',
                                  hra: '',
                                  washAllowance: '',
                                  medAllowance: '',
                                  sheAllowance: '',
                                  tiffinReimAllowance: '',
                                  prfAllowance: '',
                                  specialAllowance: '',
                                  skillAllowance: '',
                                  arearOtherAllowance: '',
                                  educationAllowance: '',
                                  heavyDutyAllowance: '',
                                  attAllowance: '',
                                  misclEarning: '',
                                  overtimeRate: '',
                                  leaveEncasment: '',
                                  pmgkyBenifitRate: '',
                                  gpa: '',
                                  arrearProfessionalTax: '',
                                  unionFund: '',
                                  contractLabourChildrenWelfare: '',
                                  canteen: '',
                                  wagesAdvance: '',
                                  cmRelifeFund: '',
                                  medicalClaim: '',
                                  benvolentFund: '',
                                  incomeTax: '',
                                  loanRecovery: '',
                                  pfLoanInterest: '',
                                  otherAllowance: '',
                                  otDays: '',
                                  miscl: '',
                                  labourWelfare: '',
                                  professionalTax: '',
                                  arrearBasicWages: '',
                                  arrearHra: '',
                                  weeklyOff: '',
                                  contractorName: '',
                                  arrearPerf: '',
                                  arrearWash: '',
                                  arrearShe: '',
                                  arrearMed: '',
                                  arrearTiffinReim: '',
                                  serviceAllowance: '',
                                  leaveDays: '',
                                  phDays: '',
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 10,),
                        const CustomInvoice(
                          containerHeightFactor: 0.42,
                          containerWidthFactor: 0.2,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
