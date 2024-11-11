import 'package:EzeePayslip/pages/payment_slip/genrate_pay_slip.dart';
import 'package:EzeePayslip/pages/upload_file/overtime_file.dart';
import 'package:EzeePayslip/pages/upload_file/upload_file_row.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'employee_enfo_classes/custom_classes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      TextEditingController(); // Professional Tax fixed
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

  String? fileName;
  String? filePath;
  TextEditingController employeeCodeController = TextEditingController();
  TextEditingController punchingNumberController = TextEditingController();
  Map<String, Map<String, String>> employeeData = {};
  final ValueNotifier<bool> buttonVisible = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  @override
  void dispose() {
    showFloatingButton.value =
        false; // Hide the button when leaving the home screen
    super.dispose();
  }


  Future<void> loadPaymentSlipEmployeeData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load all necessary fields here
      employeeCodeController.text = prefs.getString('employeeCode') ?? '';
      nameController.text = prefs.getString('name') ?? '';
      bankNameController.text = prefs.getString('bankName') ?? '';
      bankAccountNoController.text = prefs.getString('bankAccountNo') ?? '';
      dobController.text = prefs.getString('dateOfBirth') ?? '';
      gradeController.text = prefs.getString('grade') ?? '';
      pfAccountNoController.text = prefs.getString('pfAccountNo') ?? '';
      universalAccountNoController.text =
          prefs.getString('universalAccountNo') ?? '';
      esiNoController.text = prefs.getString('esi') ?? '';
      esiNoController.text = prefs.getString('esi') ?? '';
      // Repeat for other fields
    });
  }



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double scaleFactor = (constraints.maxWidth > 800)
            ? 1.0
            : (constraints.maxWidth / 800).clamp(0.3, 1.0);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text(''),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Transform.scale(
              scale: scaleFactor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ValueListenableBuilder<bool>(
                    valueListenable: showFloatingButton,
                    builder: (context, isButtonVisible, child) {
                      double containerHeightFactor =
                          isButtonVisible ? 0.38 : 0.42;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FileUploadSection(
                            containerHeightFactor: containerHeightFactor,
                            // uploadExcelFile: uploadExcelFile,
                          ),
                          // _buildFileUploadSection(containerHeightFactor),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FileUploadForOtSection(
                                containerHeightFactor: containerHeightFactor,
                              ),
                              const SizedBox(width: 30),
                              CustomSlipSection(
                                containerHeightFactor: containerHeightFactor,
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
                                                contractLabourChildrenWelfare:
                                                    '',
                                                canteen: '',
                                                wagesAdvance: '',
                                                cmRelifeFund: '',
                                                medicalClaim: '',
                                                benvolentFund: '',
                                                incomeTax: '',
                                                loanRecovery: '',
                                                pfLoanInterest: '',
                                                otherAllowance: '',
                                                otDays: '', miscl: '', labourWelfare: '', professionalTax: '',
                                              )));
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
          bottomNavigationBar: ValueListenableBuilder<bool>(
            valueListenable: showFloatingButton,
            builder: (context, isButtonVisible, child) {
              if (isButtonVisible) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/PaymentSlip')
                            .then((_) {
                          // Use a post-frame callback to ensure the setState is called correctly after returning
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              loadPaymentSlipEmployeeData(); // Reload data when returning to the page
                            });
                            showFloatingButton.value =
                                false; // Hide button on return
                          });
                        });
                        // Go back to the existing instance
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
                            "Back To Payment Slip Page",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.payment, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox(
                  height: 1,
                );
              }
            },
          ),
        );
      },
    );
  }



}
