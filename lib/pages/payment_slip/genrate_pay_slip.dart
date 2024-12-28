import 'package:flutter/material.dart';

import '../../main.dart';
import '../employee_enfo_classes/custom_classes.dart';

class GeneratePaySlip extends StatefulWidget {
  final String employeeCode;
  final String name;
  final String contractorName;
  final String bankName;
  final String grade;
  final String esi;
  final String pfAccountNo;
  final String dateOfBirth;
  final String bankAccountNo;
  final String universalAccountNo;
  final String workingDays;
  final String weeklyOff;
  final String basicWagesRate;
  final String tiffinAllowance;
  final String arrearPerf;

  final String arrearMed;
  final String serviceAllowance;
  final String arrearTiffinReim;

  final String otherAllowance;

  final String hra;
  final String arrearHra;
  final String washAllowance;
  final String arrearWash;
  final String medAllowance;
  final String sheAllowance;
  final String arrearShe;

  final String prfAllowance;
  final String tiffinReimAllowance;
  final String specialAllowance;
  final String skillAllowance;
  final String arearOtherAllowance;
  final String educationAllowance;
  final String heavyDutyAllowance;
  final String attAllowance;
  final String misclEarning;
  final String overtimeRate;
  final String leaveEncasment;
  final String pmgkyBenifitRate;
  final String arrearBasicWages;

  final String miscl;
  final String labourWelfare;

  final String professionalTax;
  final String gpa;
  final String unionFund;
  final String contractLabourChildrenWelfare;
  final String canteen;
  final String wagesAdvance;
  final String arrearProfessionalTax;
  final String cmRelifeFund;
  final String medicalClaim;
  final String benvolentFund;
  final String incomeTax;
  final String loanRecovery;
  final String pfLoanInterest;
  final String otDays;
  final String leaveDays;
  final String phDays;

  const GeneratePaySlip({
    super.key,
    required this.employeeCode,
    required this.name,
    required this.bankName,
    required this.grade,
    required this.esi,
    required this.pfAccountNo,
    required this.dateOfBirth,
    required this.bankAccountNo,
    required this.universalAccountNo,
    required this.workingDays,
    required this.basicWagesRate,
    required this.tiffinAllowance,
    required this.hra,
    required this.washAllowance,
    required this.medAllowance,
    required this.sheAllowance,
    required this.tiffinReimAllowance,
    required this.prfAllowance,
    required this.specialAllowance,
    required this.skillAllowance,
    required this.arearOtherAllowance,
    required this.educationAllowance,
    required this.heavyDutyAllowance,
    required this.attAllowance,
    required this.misclEarning,
    required this.overtimeRate,
    required this.leaveEncasment,
    required this.pmgkyBenifitRate,
    required this.gpa,
    required this.unionFund,
    required this.contractLabourChildrenWelfare,
    required this.canteen,
    required this.wagesAdvance,
    required this.arrearProfessionalTax,
    required this.cmRelifeFund,
    required this.medicalClaim,
    required this.benvolentFund,
    required this.incomeTax,
    required this.loanRecovery,
    required this.pfLoanInterest,
    required this.otherAllowance,
    required this.otDays,
    required this.miscl,
    required this.labourWelfare,
    required this.professionalTax,
    required this.arrearBasicWages,
    required this.arrearHra,
    required this.weeklyOff,
    required this.contractorName,
    required this.arrearPerf,
    required this.arrearWash,
    required this.arrearShe,
    required this.arrearMed,
    required this.serviceAllowance,
    required this.arrearTiffinReim,
    required this.leaveDays,
    required this.phDays,
  });

  @override
  // ignore: library_private_types_in_public_api
  _GeneratePaySlipState createState() => _GeneratePaySlipState();
}

class _GeneratePaySlipState extends State<GeneratePaySlip> {
  String selectedMonth = DateTime.now().month.toString();
  int selectedYear = DateTime.now().year;

  void _updateSelectedMonthYear(String month, int year) {
    setState(() {
      selectedMonth = month;
      selectedYear = year;
    });
  }

  bool useCustomEsiAmount = false; // Set to true when custom amount is used
  // String netSalaryInWords = ''; // Declare this variable here
  // String? selectedYear;
  // String? selectedMonth;

  final TextEditingController employeeCodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  late TextEditingController contractorNameController;

  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController esiNoController = TextEditingController();
  final TextEditingController pfAccountNoController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController bankAccountNoController = TextEditingController();
  final TextEditingController universalAccountNoController =
      TextEditingController();

  final TextEditingController workingDaysController = TextEditingController();
  final TextEditingController weeklyOffController = TextEditingController();
  final TextEditingController leaveDaysController = TextEditingController();
  final TextEditingController phDaysController = TextEditingController();
  final TextEditingController payDaysController = TextEditingController();

  final TextEditingController arrearPerfAllowanceController =
      TextEditingController();
  final TextEditingController arrearWashController = TextEditingController();
  final TextEditingController arrearSheController = TextEditingController();

  // Manually entered rate fields

  final TextEditingController basicWagesRateController =
      TextEditingController();
  final TextEditingController hraRateController = TextEditingController();
  final TextEditingController arrearHraController = TextEditingController();
  final TextEditingController tiffinAllowanceRateController =
      TextEditingController();
  final TextEditingController otherAllowanceRateController =
      TextEditingController();

  // Calculated amount fields
  final TextEditingController basicWagesAmountController =
      TextEditingController();

  final TextEditingController arrearBasicWagesAmountController =
      TextEditingController();
  final TextEditingController hraAmountController = TextEditingController();
  final TextEditingController tiffinAllowanceAmountController =
      TextEditingController();
  final TextEditingController otherAllowanceAmountController =
      TextEditingController();
  final TextEditingController prfRateController = TextEditingController();
  final TextEditingController prfAmountController = TextEditingController();
  final TextEditingController washRateController = TextEditingController();
  final TextEditingController washAmountController = TextEditingController();
  final TextEditingController sheRateController = TextEditingController();
  final TextEditingController sheAmountController = TextEditingController();
  final TextEditingController medRateController = TextEditingController();
  final TextEditingController medAmountController = TextEditingController();
  final TextEditingController arrearMedController = TextEditingController();
  final TextEditingController tiffinReimRateController =
      TextEditingController();
  final TextEditingController tiffinReimAmountController =
      TextEditingController();
  final TextEditingController arrearTiffinReimController =
      TextEditingController();
  final TextEditingController serviceAllowanceController =
      TextEditingController();
  final TextEditingController otAmountController = TextEditingController();
  final TextEditingController otRateController = TextEditingController();

  final TextEditingController specialRateController = TextEditingController();
  final TextEditingController specialAmountController = TextEditingController();
  final TextEditingController skillRateController = TextEditingController();
  final TextEditingController skillAmountController = TextEditingController();

  // final TextEditingController arearRateController = TextEditingController();
  final TextEditingController arrearOtherAmountController =
      TextEditingController();

  // final TextEditingController educationRateController = TextEditingController();
  final TextEditingController educationAmountController =
      TextEditingController();

  // final TextEditingController heavyDutyRateController = TextEditingController();
  final TextEditingController heavyDutyAmountController =
      TextEditingController();

  // final TextEditingController attRateController = TextEditingController();
  final TextEditingController attAmountController = TextEditingController();

  // final TextEditingController misclRateController = TextEditingController();
  final TextEditingController misclAmountController = TextEditingController();

  // final TextEditingController overtimeRateController = TextEditingController();
  final TextEditingController overtimeAmountController =
      TextEditingController();

  // final TextEditingController leaveRateController = TextEditingController();
  final TextEditingController leaveEncashmentController =
      TextEditingController();

  // final TextEditingController pmgkyRateController = TextEditingController();
  final TextEditingController pmgkyAmountController = TextEditingController();

  final TextEditingController pfAmountController = TextEditingController();
  final TextEditingController professionalTaxAmountController =
      TextEditingController(); // Professional Tax fixed
  final TextEditingController esiAmountController = TextEditingController();

  final TextEditingController gpaAmountController = TextEditingController();
  final TextEditingController unionFundAmountController =
      TextEditingController();
  final TextEditingController contractLabourChildrenwelfarefundController =
      TextEditingController();
  final TextEditingController canteenAmountController = TextEditingController();
  final TextEditingController wagesAdvanceAmountController =
      TextEditingController();
  final TextEditingController arrearProfessionalTaxAmountController =
      TextEditingController();
  final TextEditingController cmReliefFundAmountController =
      TextEditingController();
  final TextEditingController miscldednController = TextEditingController();

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
  final TextEditingController labourWelfareFundController =
      TextEditingController();

  TextEditingController customEsiAmountController = TextEditingController();

  bool includeEsiInDeductions =
      true; // Add this flag at the class level to control ESI inclusion

  @override
  void initState() {
    super.initState();
    // contractorNameController.text = '';
    contractorNameController = TextEditingController(
        text: widget.contractorName); // Make sure this is initialized properly.

    // Existing setup code for initial values
    employeeCodeController.text = widget.employeeCode;
    nameController.text = widget.name;
    contractorNameController.text = widget.contractorName;
    bankNameController.text = widget.bankName;
    gradeController.text = widget.grade;
    esiNoController.text = widget.esi;
    pfAccountNoController.text = widget.pfAccountNo;
    dobController.text = widget.dateOfBirth;
    bankAccountNoController.text = widget.bankAccountNo;
    universalAccountNoController.text = widget.universalAccountNo;
    workingDaysController.text = widget.workingDays;
    weeklyOffController.text = widget.weeklyOff;
    basicWagesRateController.text = widget.basicWagesRate;
    tiffinAllowanceRateController.text = widget.tiffinAllowance;
    otherAllowanceRateController.text = widget.otherAllowance;

    arrearMedController.text = widget.arrearMed;
    serviceAllowanceController.text = widget.serviceAllowance;
    arrearTiffinReimController.text = widget.arrearTiffinReim;

    leaveDaysController.text = widget.leaveDays;
    phDaysController.text = widget.phDays;

    labourWelfareFundController.text = widget.labourWelfare;

    specialRateController.text = widget.specialAllowance;
    skillRateController.text = widget.skillAllowance;
    arrearOtherAmountController.text = widget.arearOtherAllowance;
    educationAmountController.text = widget.educationAllowance;
    heavyDutyAmountController.text = widget.heavyDutyAllowance;
    attAmountController.text = widget.attAllowance;
    misclAmountController.text = widget.misclEarning;
    overtimeAmountController.text = widget.overtimeRate;
    leaveEncashmentController.text = widget.leaveEncasment;
    pmgkyAmountController.text = widget.pmgkyBenifitRate;

    arrearBasicWagesAmountController.text = widget.arrearBasicWages;

    professionalTaxAmountController.text = widget.professionalTax;
    gpaAmountController.text = widget.gpa;
    unionFundAmountController.text = widget.unionFund;
    contractLabourChildrenwelfarefundController.text =
        widget.contractLabourChildrenWelfare;
    canteenAmountController.text = widget.canteen;
    wagesAdvanceAmountController.text = widget.wagesAdvance;
    arrearProfessionalTaxAmountController.text = widget.arrearProfessionalTax;
    cmReliefFundAmountController.text = widget.cmRelifeFund;
    medicalClaimAmountController.text = widget.medicalClaim;
    benvolentFundAmountController.text = widget.benvolentFund;
    incomeTaxAmountController.text = widget.incomeTax;
    loanRecoveryAmountController.text = widget.loanRecovery;
    pfLoanInterestAmountController.text = widget.pfLoanInterest;
    miscldednController.text = widget.miscl;
    otRateController.text = widget.otDays;
    hraRateController.text = widget.hra;

    arrearHraController.text = widget.arrearHra;
    prfRateController.text = widget.prfAllowance;
    washRateController.text = widget.washAllowance;
    sheRateController.text = widget.sheAllowance;
    tiffinReimRateController.text = widget.tiffinReimAllowance;
    medRateController.text = widget.medAllowance;

    arrearPerfAllowanceController.text = widget.arrearPerf;
    arrearWashController.text = widget.arrearWash;
    arrearSheController.text = widget.arrearShe;

    // Add listeners to earnings-related controllers
    workingDaysController.addListener(_updateAmounts);
    phDaysController.addListener(_updateAmounts);
    basicWagesRateController.addListener(_updateAmounts);
    basicWagesAmountController.addListener(_updateAmounts);
    arrearBasicWagesAmountController.addListener(_updateAmounts);
    hraRateController.addListener(_updateAmounts);
    arrearHraController.addListener(_updateAmounts);
    hraAmountController.addListener(_updateAmounts);
    tiffinAllowanceRateController.addListener(_updateAmounts);
    otherAllowanceAmountController.addListener(_updateAmounts);
    prfRateController.addListener(_updateAmounts);
    washRateController.addListener(_updateAmounts);
    prfAmountController.addListener(_updateAmounts);
    sheRateController.addListener(_updateAmounts);
    medRateController.addListener(_updateAmounts);
    tiffinReimAmountController.addListener(_updateAmounts);

    esiNoController.addListener(_updateAmounts);

    otRateController.addListener(_updateAmounts);
    otAmountController.addListener(_updateAmounts);

    specialRateController.addListener(_updateAmounts);
    specialAmountController.addListener(_updateAmounts);
    skillRateController.addListener(_updateAmounts);
    skillAmountController.addListener(_updateAmounts);
    arrearOtherAmountController.addListener(_updateAmounts);
    educationAmountController.addListener(_updateAmounts);
    heavyDutyAmountController.addListener(_updateAmounts);
    misclAmountController.addListener(_updateAmounts);
    attAmountController.addListener(_updateAmounts);
    overtimeAmountController.addListener(_updateAmounts);
    leaveEncashmentController.addListener(_updateAmounts);
    pmgkyAmountController.addListener(_updateAmounts);

    // Add listeners to deduction-related controllers
    professionalTaxAmountController.addListener(_updateAmounts);
    gpaAmountController.addListener(_updateAmounts);
    unionFundAmountController.addListener(_updateAmounts);
    contractLabourChildrenwelfarefundController.addListener(_updateAmounts);
    canteenAmountController.addListener(_updateAmounts);
    wagesAdvanceAmountController.addListener(_updateAmounts);
    arrearProfessionalTaxAmountController.addListener(_updateAmounts);
    cmReliefFundAmountController.addListener(_updateAmounts);
    medicalClaimAmountController.addListener(_updateAmounts);
    benvolentFundAmountController.addListener(_updateAmounts);
    incomeTaxAmountController.addListener(_updateAmounts);
    loanRecoveryAmountController.addListener(_updateAmounts);
    pfLoanInterestAmountController.addListener(_updateAmounts);
    phDaysController.addListener(_updateAmounts);
    netSalaryController.addListener(_updateAmounts);
    customEsiAmountController.addListener(_updateAmounts);
    pfAmountController.addListener(_updateAmounts);
    esiAmountController.addListener(_updateAmounts);
    arrearMedController.addListener(_updateAmounts);
    arrearPerfAllowanceController.addListener(_updateAmounts);
    arrearWashController.addListener(_updateAmounts);
    arrearSheController.addListener(_updateAmounts);
    serviceAllowanceController.addListener(_updateAmounts);
    tiffinAllowanceAmountController.addListener(_updateAmounts);
    tiffinReimRateController.addListener(_updateAmounts);
    arrearTiffinReimController.addListener(_updateAmounts);
    otherAllowanceRateController.addListener(_updateAmounts);
    otherAllowanceAmountController.addListener(_updateAmounts);
    arrearOtherAmountController.addListener(_updateAmounts);
    miscldednController.addListener(_updateAmounts);
    labourWelfareFundController.addListener(_updateAmounts);
    // Set default month and year
  }

  void _updateAmounts() {
    final workingDays = int.tryParse(workingDaysController.text) ?? 0;
    const fullWorkingDays = 26; // Standard days in a month

    setState(() {
      double parseDouble(String value) {
        return double.tryParse(value) ?? 0.0;
      }

      final payDays = parseDouble(phDaysController.text) +
          parseDouble(workingDaysController.text);
      // Calculate earnings based on actual working days
      final basicWagesRate = parseDouble(basicWagesRateController.text);
      final arrearBasicWages =
          parseDouble(arrearBasicWagesAmountController.text);
      final hraRate = parseDouble(hraRateController.text);
      final unionFund = parseDouble(unionFundAmountController.text);
      final arrearHra = parseDouble(arrearHraController.text);
      final profesinoalTax = parseDouble(professionalTaxAmountController.text);
      final tiffinAllowanceRate =
          parseDouble(tiffinAllowanceRateController.text);
      final tiffinAllowanceAmount =
          parseDouble(tiffinAllowanceAmountController.text);

      final prfAllowanceRate = parseDouble(prfRateController.text);
      final prfAllowanceAmount = parseDouble(prfAmountController.text);

      final washAllowanceRate = parseDouble(washRateController.text);
      final washAllowanceAmount = parseDouble(washAmountController.text);

      final sheAllowanceRate = parseDouble(sheRateController.text);
      final sheAllowanceAmount = parseDouble(sheAmountController.text);

      final medAllowanceRate = parseDouble(medRateController.text);
      final medAllowanceAmount = parseDouble(medAmountController.text);

      final otrate = parseDouble(otRateController.text);

      final tiffinReimAllowanceRate =
          parseDouble(tiffinReimRateController.text);
      final tiffinReimAllowanceAmount =
          parseDouble(tiffinReimAmountController.text);

      final specialAllowanceRate = parseDouble(specialRateController.text);
      final specialAllowanceAmount = parseDouble(specialAmountController.text);

      final skillAllowanceRate = parseDouble(skillRateController.text);
      final skillAllowanceAmount = parseDouble(skillAmountController.text);

      final arrearOtherAllowance =
          parseDouble(arrearOtherAmountController.text);
      final heavyDutyAllowanceRate =
          parseDouble(heavyDutyAmountController.text);
      final educationAllowance = parseDouble(educationAmountController.text);
      final attAllowance = parseDouble(attAmountController.text);
      final misclAllowance = parseDouble(misclAmountController.text);
      final overtimeAllowanceRate = parseDouble(overtimeAmountController.text);
      final leaveEncashmentAllowance =
          parseDouble(leaveEncashmentController.text);
      final pmgkyAllowanceRate = parseDouble(pmgkyAmountController.text);

      final otherAllowanceAmount =
          parseDouble(otherAllowanceAmountController.text);
      final otherAllowanceRate = parseDouble(otherAllowanceRateController.text);

      final providentFund = parseDouble(pfAmountController.text);
      final gpa = parseDouble(gpaAmountController.text);

      final contractLabourChildrenWelfareFund =
          parseDouble(contractLabourChildrenwelfarefundController.text);
      final canteen = parseDouble(canteenAmountController.text);
      final wagesAdvance = parseDouble(wagesAdvanceAmountController.text);
      final arrearProfessinalTax =
          parseDouble(arrearProfessionalTaxAmountController.text);
      final cmReliefFund = parseDouble(cmReliefFundAmountController.text);
      final medicalClaim = parseDouble(medicalClaimAmountController.text);
      final benvolentFund = parseDouble(benvolentFundAmountController.text);
      final incomeTax = parseDouble(incomeTaxAmountController.text);
      final loanrecovery = parseDouble(loanRecoveryAmountController.text);
      final pfLoanInterest = parseDouble(pfLoanInterestAmountController.text);
      final misclDedn = parseDouble(miscldednController.text);
      final labourWelfareFund = parseDouble(labourWelfareFundController.text);
      final arrearPerfAllowance =
          parseDouble(arrearPerfAllowanceController.text);
      final arrearWashAllowance = parseDouble(arrearWashController.text);
      final arrearSheAllowance = parseDouble(arrearSheController.text);
      final arrearMedAllowance = parseDouble(arrearMedController.text);
      final serviceAllowance = parseDouble(serviceAllowanceController.text);
      final arrearTiffinReim = parseDouble(arrearTiffinReimController.text);
      final otAmount = parseDouble(otAmountController.text);

      // Calculate actual earnings for present working days
      // payDaysController.text = (payDays + workingDays).toStringAsFixed(2);
      // medRateController.text = (medAllowanceRate).toStringAsFixed(2);
      // basicWagesRateController.text = (basicWagesRate).toStringAsFixed(2);
      // hraRateController.text = (hraRate).toStringAsFixed(2);
      // arrearPerfAllowanceController.text =
      //     (arrearPerfAllowance).toStringAsFixed(2);
      // washRateController.text = (washAllowanceRate).toStringAsFixed(2);
      // arrearWashController.text = (arrearWashAllowance).toStringAsFixed(2);
      // arrearWashController.text = (arrearWashAllowance).toStringAsFixed(2);
      // sheRateController.text = (sheAllowanceRate).toStringAsFixed(2);
      // arrearSheController.text = (arrearSheAllowance).toStringAsFixed(2);
      // sheRateController.text = (sheAllowanceRate).toStringAsFixed(2);
      // arrearMedController.text = (arrearMedAllowance).toStringAsFixed(2);
      // tiffinAllowanceRateController.text =
      //     (tiffinAllowanceRate).toStringAsFixed(2);
      // serviceAllowanceController.text = (serviceAllowance).toStringAsFixed(2);
      // arrearTiffinReimController.text = (arrearTiffinReim).toStringAsFixed(2);
      // otRateController.text = (otrate).toStringAsFixed(2);

      basicWagesAmountController.text =
          (basicWagesRate * payDays).toStringAsFixed(2);
      hraAmountController.text = (hraRate * payDays).toStringAsFixed(2);
      // unionFundAmountController.text = unionFund.toStringAsFixed(2);
      tiffinAllowanceAmountController.text =
          (tiffinAllowanceRate * payDays).toStringAsFixed(2);
      otherAllowanceAmountController.text =
          (otherAllowanceRate * payDays).toStringAsFixed(2);
      prfAmountController.text =
          (prfAllowanceRate * payDays).toStringAsFixed(2);
      washAmountController.text =
          (washAllowanceRate * payDays).toStringAsFixed(2);
      sheAmountController.text =
          (sheAllowanceRate * payDays).toStringAsFixed(2);
      medAmountController.text =
          (medAllowanceRate * payDays).toStringAsFixed(2);
      tiffinReimAmountController.text =
          (tiffinReimAllowanceRate * payDays).toStringAsFixed(2);

      otAmountController.text = (basicWagesRate * otrate).toStringAsFixed(2);

      specialAmountController.text =
          (specialAllowanceRate * payDays).toStringAsFixed(2);
      skillAmountController.text =
          (skillAllowanceRate * payDays).toStringAsFixed(2);

      // professionalTaxAmountController.text = profesinoalTax.toStringAsFixed(2);

      // arrearBasicWagesAmountController.text =
      //     arrearBasicWages.toStringAsFixed(2);
      // arrearHraController.text = arrearHra.toStringAsFixed(2);
      // arrearOtherAmountController.text =
      //     arrearOtherAllowance.toStringAsFixed(2);
      // educationAmountController.text = educationAllowance.toStringAsFixed(2);
      // heavyDutyAmountController.text =
      //     heavyDutyAllowanceRate.toStringAsFixed(2);
      // attAmountController.text = attAllowance.toStringAsFixed(2);
      // misclAmountController.text = misclAllowance.toStringAsFixed(2);
      // overtimeAmountController.text = overtimeAllowanceRate.toStringAsFixed(2);
      // leaveEncashmentController.text =
      //     leaveEncashmentAllowance.toStringAsFixed(2);
      // pmgkyAmountController.text = pmgkyAllowanceRate.toStringAsFixed(2);
      // prfRateController.text = prfAllowanceRate.toStringAsFixed(2);
      // specialRateController.text = specialAllowanceRate.toStringAsFixed(2);
      // skillRateController.text = skillAllowanceRate.toStringAsFixed(2);
      // prfRateController.text = prfAllowanceRate.toStringAsFixed(2);
      // tiffinReimRateController.text =
      //     tiffinReimAllowanceRate.toStringAsFixed(2);
      // otherAllowanceRateController.text = otherAllowanceRate.toStringAsFixed(2);

      // gpaAmountController.text = gpa.toStringAsFixed(2);
      // contractLabourChildrenwelfarefundController.text =
      //     contractLabourChildrenWelfareFund.toStringAsFixed(2);
      // canteenAmountController.text = canteen.toStringAsFixed(2);
      // wagesAdvanceAmountController.text = wagesAdvance.toStringAsFixed(2);
      // arrearProfessionalTaxAmountController.text =
      //     arrearProfessinalTax.toStringAsFixed(2);
      // cmReliefFundAmountController.text = cmReliefFund.toStringAsFixed(2);
      // medicalClaimAmountController.text = medicalClaim.toStringAsFixed(2);
      // benvolentFundAmountController.text = benvolentFund.toStringAsFixed(2);
      // incomeTaxAmountController.text = incomeTax.toStringAsFixed(2);
      // loanRecoveryAmountController.text = loanrecovery.toStringAsFixed(2);
      // pfLoanInterestAmountController.text = pfLoanInterest.toStringAsFixed(2);
      // miscldednController.text = misclDedn.toStringAsFixed(2);
      // labourWelfareFundController.text = labourWelfareFund.toStringAsFixed(2);
      // otAmountController.text = otAmount.toStringAsFixed(2);

      // Calculate Gross Earnings based on actual working days
      final grossEarnings = parseDouble(basicWagesAmountController.text) +
          parseDouble(arrearBasicWagesAmountController.text) +
          parseDouble(hraAmountController.text) +
          parseDouble(arrearHraController.text) +
          parseDouble(prfAmountController.text) +
          parseDouble(arrearPerfAllowanceController.text) +
          parseDouble(washAmountController.text) +
          parseDouble(arrearWashController.text) +
          parseDouble(sheAmountController.text) +
          parseDouble(arrearSheController.text) +
          parseDouble(medAmountController.text) +
          parseDouble(arrearMedController.text) +
          parseDouble(serviceAllowanceController.text) +
          parseDouble(specialAmountController.text) +
          parseDouble(skillAmountController.text) +
          parseDouble(tiffinAllowanceAmountController.text) +
          parseDouble(tiffinReimAmountController.text) +
          parseDouble(arrearTiffinReimController.text) +
          parseDouble(otherAllowanceAmountController.text) +
          parseDouble(arrearOtherAmountController.text) +
          parseDouble(educationAmountController.text) +
          parseDouble(heavyDutyAmountController.text) +
          parseDouble(attAmountController.text) +
          parseDouble(overtimeAmountController.text) +
          parseDouble(leaveEncashmentController.text) +
          parseDouble(pmgkyAmountController.text) +
          parseDouble(otAmountController.text) +
          parseDouble(misclAmountController.text);

      grossEarningsController.text = grossEarnings.toStringAsFixed(2);

      // Calculate full monthly earnings based on a 26-day period (excluding OT)
      // final fullMonthlyEarnings = (basicWagesRate +
      //         arrearBasicWages +
      //         hraRate +
      //         arrearHra +
      //         prfAllowanceRate +
      //         arrearPerfAllowance +
      //         washAllowanceRate +
      //         arrearWashAllowance +
      //         sheAllowanceRate +
      //         arrearSheAllowance +
      //         medAllowanceAmount +
      //         arrearMedAllowance +
      //         serviceAllowance +
      //         specialAllowanceAmount +
      //         skillAllowanceAmount +
      //         tiffinAllowanceAmount +
      //         tiffinReimAllowanceAmount +
      //         arrearTiffinReim +
      //         otherAllowanceAmount +
      //         arrearOtherAllowance +
      //         educationAllowance +
      //         heavyDutyAllowanceRate +
      //         attAllowance +
      //         misclAllowance +
      //         overtimeAllowanceRate +
      //         leaveEncashmentAllowance +
      //         pmgkyAllowanceRate) *
      //     fullWorkingDays;

      final fullMonthlyEarnings = (grossEarnings - otAmount) / workingDays * 26;
      // Provident Fund (12% of Basic Wages)
      pfAmountController.text =
          ((parseDouble(basicWagesAmountController.text) * 12) / 100)
              .toStringAsFixed(2);

      // ESI Calculation
      double esiAmount = 0.0;
      if (fullMonthlyEarnings < 21000) {
        // ESI eligible if full month income is below 21000
        esiAmount = useCustomEsiAmount
            ? parseDouble(customEsiAmountController.text)
            : (grossEarnings * 0.0075); // 0.75% of gross earnings if eligible
        esiAmountController.text = esiAmount.toStringAsFixed(2);
      } else {
        esiAmountController.text =
            "0.00"; // No ESI if full month earnings >= 21,000
      }

      // Calculate Gross Deductions
      final grossDeductions = parseDouble(pfAmountController.text) +
          parseDouble(professionalTaxAmountController.text) +
          (includeEsiInDeductions
              ? parseDouble(esiAmountController.text)
              : 0.0) +
          parseDouble(gpaAmountController.text) +
          parseDouble(unionFundAmountController.text) +
          parseDouble(contractLabourChildrenwelfarefundController.text) +
          parseDouble(canteenAmountController.text) +
          parseDouble(wagesAdvanceAmountController.text) +
          parseDouble(arrearProfessionalTaxAmountController.text) +
          parseDouble(cmReliefFundAmountController.text) +
          parseDouble(medicalClaimAmountController.text) +
          parseDouble(benvolentFundAmountController.text) +
          parseDouble(incomeTaxAmountController.text) +
          parseDouble(loanRecoveryAmountController.text) +
          parseDouble(pfLoanInterestAmountController.text) +
          parseDouble(miscldednController.text) +
          parseDouble(labourWelfareFundController.text);

      grossDeductionsController.text = grossDeductions.toStringAsFixed(2);

      // Calculate Net Salary
      final netSalary = grossEarnings - grossDeductions;
      netSalaryController.text = netSalary.toStringAsFixed(2);

      // Convert net salary to words (if needed)
      // netSalaryWordsController.text = convertNumberToWords(netSalary);
    });
  }

  @override
  void dispose() {
    contractorNameController.dispose();

    // Remove listeners from earnings-related controllers
    // workingDaysController.removeListener(_updateAmounts);
    // basicWagesRateController.removeListener(_updateAmounts);
    // arrearBasicWagesAmountController.removeListener(_updateAmounts);
    // hraRateController.removeListener(_updateAmounts);
    // tiffinAllowanceRateController.removeListener(_updateAmounts);
    // otherAllowanceRateController.removeListener(_updateAmounts);
    // prfRateController.removeListener(_updateAmounts);
    // washRateController.removeListener(_updateAmounts);
    // sheRateController.removeListener(_updateAmounts);
    // medRateController.removeListener(_updateAmounts);
    // tiffinReimRateController.removeListener(_updateAmounts);
    //
    // esiNoController.removeListener(_updateAmounts);
    //
    // // phController.removeListener(_updateAmounts);
    //
    // // specialRateController.removeListener(_updateAmounts);
    // specialAmountController.removeListener(_updateAmounts);
    // skillRateController.removeListener(_updateAmounts);
    // skillAmountController.removeListener(_updateAmounts);
    // // educationRateController.removeListener(_updateAmounts);
    // educationAmountController.removeListener(_updateAmounts);
    // heavyDutyAmountController.removeListener(_updateAmounts);
    // misclAmountController.removeListener(_updateAmounts);
    // attAmountController.removeListener(_updateAmounts);
    // overtimeAmountController.removeListener(_updateAmounts);
    // leaveEncashmentController.removeListener(_updateAmounts);
    // pmgkyAmountController.removeListener(_updateAmounts);
    //
    // otRateController.removeListener(_updateAmounts);
    // otAmountController.removeListener(_updateAmounts);
    //
    // // Remove listeners from deduction-related controllers
    // professionalTaxAmountController.removeListener(_updateAmounts);
    // gpaAmountController.removeListener(_updateAmounts);
    // unionFundAmountController.removeListener(_updateAmounts);
    // contractLabourChildrenwelfarefundController.removeListener(_updateAmounts);
    // canteenAmountController.removeListener(_updateAmounts);
    // wagesAdvanceAmountController.removeListener(_updateAmounts);
    // arrearProfessionalTaxAmountController.removeListener(_updateAmounts);
    // cmReliefFundAmountController.removeListener(_updateAmounts);
    // medicalClaimAmountController.removeListener(_updateAmounts);
    // benvolentFundAmountController.removeListener(_updateAmounts);
    // incomeTaxAmountController.removeListener(_updateAmounts);
    // loanRecoveryAmountController.removeListener(_updateAmounts);
    // pfLoanInterestAmountController.removeListener(_updateAmounts);
    //
    // customEsiAmountController.removeListener(_updateAmounts);

    // Dispose of controllers
    workingDaysController.dispose();
    basicWagesRateController.dispose();
    hraRateController.dispose();
    tiffinAllowanceRateController.dispose();
    otherAllowanceRateController.dispose();
    prfRateController.dispose();
    washRateController.dispose();
    sheRateController.dispose();
    medRateController.dispose();
    tiffinReimRateController.dispose();
    professionalTaxAmountController.dispose();
    gpaAmountController.dispose();
    unionFundAmountController.dispose();
    contractLabourChildrenwelfarefundController.dispose();
    canteenAmountController.dispose();
    wagesAdvanceAmountController.dispose();
    arrearProfessionalTaxAmountController.dispose();
    cmReliefFundAmountController.dispose();
    medicalClaimAmountController.dispose();
    benvolentFundAmountController.dispose();
    incomeTaxAmountController.dispose();
    loanRecoveryAmountController.dispose();
    pfLoanInterestAmountController.dispose();
    customEsiAmountController.dispose();
    esiNoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Generate Payment Slip"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    //Row
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FirstContainer(
                        employeeCodeController: employeeCodeController,
                        nameController: nameController,
                        bankNameController: bankNameController,
                        gradeController: gradeController,
                        universalAccountNoController:
                            universalAccountNoController,
                        esiNoController: esiNoController,
                        pfAccountNoController: pfAccountNoController,
                        bankAccountNoController: bankAccountNoController,
                        dobController: dobController,
                      ),
                      SecondContainer(
                        workingDaysController: workingDaysController,
                        phController: phDaysController,
                        leaveDaysController: leaveDaysController,
                        weeklyOffController: weeklyOffController,
                      ),
                      ThirdContainer(
                        basicWagesRateController: basicWagesRateController,
                        basicWagesAmountController: basicWagesAmountController,
                        hraRateController: hraRateController,
                        hraAmountController: hraAmountController,
                        arrearBasicWagesAmountController:
                            arrearBasicWagesAmountController,
                        arrearHraRateController: arrearHraController,
                        prefRateController: prfRateController,
                        prefAmountController: prfAmountController,
                        washRateController: washRateController,
                        washAmountController: washAmountController,
                        arrearPerfController: arrearPerfAllowanceController,
                        arrearWashController: arrearWashController,
                        sheRateController: sheRateController,
                        sheAmountController: sheAmountController,
                      )
                    ],
                  ),
                ),
                Row(
                  //row
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FourthContainer(
                      arrearSheController: arrearSheController,
                      medRateController: medRateController,
                      medAmountController: medAmountController,
                      specialRateController: specialRateController,
                      specialAmountController: specialAmountController,
                      skillRateController: skillRateController,
                      skillAmountController: skillAmountController,
                      tiffinAllowanceAmountController:
                          tiffinAllowanceAmountController,
                      tiffinAllowanceRateController:
                          tiffinAllowanceRateController,
                      tiffinReimRateController: tiffinReimRateController,
                      tiffinReimAmountController: tiffinReimAmountController,
                      arrearMedController: arrearMedController,
                      otherAllowanceAmountController:
                          otherAllowanceAmountController,
                      otherAllowanceRateController:
                          otherAllowanceRateController,
                      arrearTiffinReimController: arrearTiffinReimController,
                      serviceAllowanceController: serviceAllowanceController,
                    ),
                    FifthContainer(
                      arearAmountController: arrearOtherAmountController,
                      educationAmountController: educationAmountController,
                      heavyDutyAmountController: heavyDutyAmountController,
                      attAmountController: attAmountController,
                      misclAmountController: misclAmountController,
                      leaveEncashmentController: leaveEncashmentController,
                      pmgkyAmountController: pmgkyAmountController,
                      overtimeAmountController: overtimeAmountController,
                      otRateController: otRateController,
                      otAmountController: otAmountController,
                    ),
                    // SizedBox(width: 12,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SixthContainer(
                          pfAmountController: pfAmountController,
                          gpaAmountController: gpaAmountController,
                          unionFundAmountController: unionFundAmountController,
                          childrenWelfareFundAmountController:
                              contractLabourChildrenwelfarefundController,
                          canteenAmountController: canteenAmountController,
                          wagesAdvanceAmountController:
                              wagesAdvanceAmountController,
                          arrearProfessionalTaxAmountController:
                              arrearProfessionalTaxAmountController,
                          taxAmountController: professionalTaxAmountController,
                          miscldednController: miscldednController,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SeventhContainer(
                      cmReliefFundAmountController:
                          cmReliefFundAmountController,
                      labourWelfareFundController: labourWelfareFundController,
                      pfLoanInterest: pfLoanInterestAmountController,
                      medicalClaimController: medicalClaimAmountController,
                      benevolentFundController: benvolentFundAmountController,
                      incomeTaxController: incomeTaxAmountController,
                      esiAmountController: esiAmountController,
                      medicalClaimAmountController:
                          medicalClaimAmountController,
                      benvolentFundAmountController:
                          benvolentFundAmountController,
                      incomeTaxAmountController: incomeTaxAmountController,
                      loanRecoveryAmountController:
                          loanRecoveryAmountController,
                    ),
                    NinethContainer(
                        grossEarningsController: grossEarningsController,
                        grossDeductionsController: grossDeductionsController,
                        contractorNameController: contractorNameController,
                        onMonthYearChanged: _updateSelectedMonthYear,
                        netSalaryController: netSalaryController),
                    // TextField(controller: contractorNameController,)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: GenerateButton(
          employeeCodeController: employeeCodeController,
          nameController: nameController,
          bankNameController: bankNameController,
          bankAccountNoController: bankAccountNoController,
          dobController: dobController,
          gradeController: gradeController,
          pfAccountNoController: pfAccountNoController,
          universalAccountNoController: universalAccountNoController,
          esiNoController: esiNoController,
          workingDaysController: workingDaysController,
          weeklyOffController: weeklyOffController,
          leaveDaysController: leaveDaysController,
          phController: phDaysController,
          basicWagesRateController: basicWagesRateController,
          basicWagesAmountController: basicWagesAmountController,
          hraRateController: hraRateController,
          hraAmountController: hraAmountController,
          tiffinAllowanceRateController: tiffinAllowanceRateController,
          tiffinAllowanceAmountController: tiffinAllowanceAmountController,
          otherAllowanceRateController: otherAllowanceRateController,
          otherAllowanceAmountController: otherAllowanceAmountController,
          pfAmountController: pfAmountController,
          taxAmountController: professionalTaxAmountController,
          esiAmountController: esiAmountController,
          grossEarningsController: grossEarningsController,
          grossDeductionsController: grossDeductionsController,
          netSalaryController: netSalaryController,
          prfRateController: prfRateController,
          prfAmountController: prfAmountController,
          washRateController: washRateController,
          washAmountController: washAmountController,
          sheRateController: sheRateController,
          sheAmountController: sheAmountController,
          medRateController: medRateController,
          medAmountController: medAmountController,
          specialRateController: specialRateController,
          specialAmountController: specialAmountController,
          skillRateController: skillRateController,
          skillAmountController: skillAmountController,
          tiffinReimRateController: tiffinReimRateController,
          tiffinReimAmountController: tiffinReimAmountController,
          educationAmountController: educationAmountController,
          arearOtherAmountController: arrearOtherAmountController,
          heavyDutyAmountController: heavyDutyAmountController,
          attAmountController: attAmountController,
          misclEarningController: misclAmountController,
          overtimeAmountController: overtimeAmountController,
          leaveEncashmentController: leaveEncashmentController,
          pmgkyBenifitController: pmgkyAmountController,
          otDaysController: otRateController,
          gpaController: gpaAmountController,
          unionFundController: unionFundAmountController,
          canteenController: canteenAmountController,
          wagesAdvanceController: wagesAdvanceAmountController,
          arrearProfessionaltaxController:
              arrearProfessionalTaxAmountController,
          cmRelifeFundController: cmReliefFundAmountController,
          medicalClaimController: medicalClaimAmountController,
          benvolentFundController: benvolentFundAmountController,
          incomeTaxController: incomeTaxAmountController,
          loanRecoveryController: loanRecoveryAmountController,
          pfLoanInterestController: pfLoanInterestAmountController,
          misclDednController: misclAmountController,
          labourWelfareFundController: labourWelfareFundController,
          otDaysAmountsController: otAmountController,
          selectedMonth: selectedMonth,
          selectedYear: selectedYear,
          arrearBasicWagesAmountController: arrearBasicWagesAmountController,
          arrearHraAmountController: arrearHraController,
          contractLabourChildrenwelfarefundController:
              contractLabourChildrenwelfarefundController,
          pfAccountNo: pfAccountNoController,
          contractorNameController: contractorNameController,
          arrearWashAllowanceController: arrearWashController,
          arrearSheAllowanceController: arrearSheController,
          arrearMedAllowanceController: arrearMedController,
          serviceAllowanceController: serviceAllowanceController,
          arrearTiffinReimAllowanceController: arrearTiffinReimController,
          arrearPerfAllowanceController: arrearPerfAllowanceController,
        ),
      ),
    );
  }
}
