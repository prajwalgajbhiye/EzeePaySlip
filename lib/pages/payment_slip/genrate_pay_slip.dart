import 'package:flutter/material.dart';

import '../../main.dart';
import '../employee_enfo_classes/custom_classes.dart';

class GeneratePaySlip extends StatefulWidget {
  final String employeeCode;
  final String name;
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

  final String otherAllowance;

  final String hra;
  final String arrearHra;
  final String washAllowance;
  final String medAllowance;
  final String sheAllowance;
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
  final TextEditingController phController = TextEditingController();

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

    // Existing setup code for initial values
    employeeCodeController.text = widget.employeeCode;
    nameController.text = widget.name;
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

    // Add listeners to earnings-related controllers
    workingDaysController.addListener(_updateAmounts);
    weeklyOffController.addListener(_updateAmounts);
    basicWagesRateController.addListener(_updateAmounts);
    basicWagesAmountController.addListener(_updateAmounts);
    arrearBasicWagesAmountController.addListener(_updateAmounts);
    hraRateController.addListener(_updateAmounts);
    arrearHraController.addListener(_updateAmounts);
    hraAmountController.addListener(_updateAmounts);
    tiffinAllowanceRateController.addListener(_updateAmounts);
    otherAllowanceRateController.addListener(_updateAmounts);
    prfRateController.addListener(_updateAmounts);
    washRateController.addListener(_updateAmounts);
    sheRateController.addListener(_updateAmounts);
    medRateController.addListener(_updateAmounts);
    tiffinReimRateController.addListener(_updateAmounts);

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

    customEsiAmountController.addListener(_updateAmounts);
    // Set default month and year
  }

  void _updateAmounts() {
    final workingDays = int.tryParse(workingDaysController.text) ?? 0;
    const fullWorkingDays = 26; // Standard days in a month

    setState(() {
      double parseDouble(String value) {
        return double.tryParse(value) ?? 0.0;
      }

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
      final attAllowanceRate = parseDouble(attAmountController.text);
      final misclAllowanceRate = parseDouble(misclAmountController.text);
      final overtimeAllowanceRate = parseDouble(overtimeAmountController.text);
      final leaveEncashmentAllowanceRate =
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

      // Calculate actual earnings for present working days
      basicWagesAmountController.text =
          (basicWagesRate * workingDays).toStringAsFixed(2);
      hraAmountController.text = (hraRate * workingDays).toStringAsFixed(2);
      unionFundAmountController.text = unionFund.toStringAsFixed(2);
      tiffinAllowanceAmountController.text =
          (tiffinAllowanceRate * workingDays).toStringAsFixed(2);
      otherAllowanceAmountController.text =
          (otherAllowanceRate * workingDays).toStringAsFixed(2);
      prfAmountController.text =
          (prfAllowanceRate * workingDays).toStringAsFixed(2);
      washAmountController.text =
          (washAllowanceRate * workingDays).toStringAsFixed(2);
      sheAmountController.text =
          (sheAllowanceRate * workingDays).toStringAsFixed(2);
      medAmountController.text =
          (medAllowanceRate * workingDays).toStringAsFixed(2);
      tiffinReimAmountController.text =
          (tiffinReimAllowanceRate * workingDays).toStringAsFixed(2);

      otAmountController.text =
          (basicWagesRate / 8 * otrate * 2).toStringAsFixed(2);

      specialAmountController.text =
          (specialAllowanceRate * workingDays).toStringAsFixed(2);
      skillAmountController.text =
          (skillAllowanceRate * workingDays).toStringAsFixed(2);

      professionalTaxAmountController.text = profesinoalTax.toStringAsFixed(2);

      arrearBasicWagesAmountController.text =
          arrearBasicWages.toStringAsFixed(2);
      arrearHraController.text = arrearHra.toStringAsFixed(2);
      arrearOtherAmountController.text =
          arrearOtherAllowance.toStringAsFixed(2);
      educationAmountController.text = educationAllowance.toStringAsFixed(2);
      heavyDutyAmountController.text =
          heavyDutyAllowanceRate.toStringAsFixed(2);
      attAmountController.text = attAllowanceRate.toStringAsFixed(2);
      misclAmountController.text = misclAllowanceRate.toStringAsFixed(2);
      overtimeAmountController.text = overtimeAllowanceRate.toStringAsFixed(2);
      leaveEncashmentController.text =
          leaveEncashmentAllowanceRate.toStringAsFixed(2);
      pmgkyAmountController.text = pmgkyAllowanceRate.toStringAsFixed(2);
      prfRateController.text = prfAllowanceRate.toStringAsFixed(2);
      specialRateController.text = specialAllowanceRate.toStringAsFixed(2);
      skillRateController.text = skillAllowanceRate.toStringAsFixed(2);
      prfRateController.text = prfAllowanceRate.toStringAsFixed(2);
      tiffinReimRateController.text =
          tiffinReimAllowanceRate.toStringAsFixed(2);
      otherAllowanceRateController.text = otherAllowanceRate.toStringAsFixed(2);

      gpaAmountController.text = gpa.toStringAsFixed(2);
      contractLabourChildrenwelfarefundController.text =
          contractLabourChildrenWelfareFund.toStringAsFixed(2);
      canteenAmountController.text = canteen.toStringAsFixed(2);
      wagesAdvanceAmountController.text = wagesAdvance.toStringAsFixed(2);
      arrearProfessionalTaxAmountController.text =
          arrearProfessinalTax.toStringAsFixed(2);
      cmReliefFundAmountController.text = cmReliefFund.toStringAsFixed(2);
      medicalClaimAmountController.text = medicalClaim.toStringAsFixed(2);
      benvolentFundAmountController.text = benvolentFund.toStringAsFixed(2);
      incomeTaxAmountController.text = incomeTax.toStringAsFixed(2);
      loanRecoveryAmountController.text = loanrecovery.toStringAsFixed(2);
      pfLoanInterestAmountController.text = pfLoanInterest.toStringAsFixed(2);
      miscldednController.text = misclDedn.toStringAsFixed(2);
      labourWelfareFundController.text = labourWelfareFund.toStringAsFixed(2);

      // Calculate Gross Earnings based on actual working days
      final grossEarnings = parseDouble(basicWagesAmountController.text) +
          parseDouble(arrearBasicWagesAmountController.text) +
          parseDouble(hraAmountController.text) +
          parseDouble(arrearHraController.text) +
          parseDouble(tiffinAllowanceAmountController.text) +
          parseDouble(otherAllowanceAmountController.text) +
          parseDouble(prfAmountController.text) +
          parseDouble(washAmountController.text) +
          parseDouble(sheAmountController.text) +
          parseDouble(medAmountController.text) +
          parseDouble(tiffinReimAmountController.text) +
          parseDouble(otAmountController.text) +
          parseDouble(specialAmountController.text) +
          parseDouble(skillAmountController.text) +
          parseDouble(arrearOtherAmountController.text) +
          parseDouble(heavyDutyAmountController.text) +
          parseDouble(educationAmountController.text) +
          parseDouble(attAmountController.text) +
          parseDouble(leaveEncashmentController.text) +
          parseDouble(overtimeAmountController.text) +
          parseDouble(pmgkyAmountController.text) +
          parseDouble(misclAmountController.text);

      grossEarningsController.text = grossEarnings.toStringAsFixed(2);

      // Calculate full monthly earnings based on a 26-day period (excluding OT)
      final fullMonthlyEarnings = (basicWagesRate +
              arrearBasicWages +
              hraRate +
              arrearHra +
              tiffinAllowanceRate +
              otherAllowanceRate +
              prfAllowanceRate +
              washAllowanceRate +
              sheAllowanceRate +
              medAllowanceRate +
              tiffinReimAllowanceRate +
              specialAllowanceRate +
              skillAllowanceRate +
              arrearOtherAllowance +
              heavyDutyAllowanceRate +
              educationAllowance +
              attAllowanceRate +
              misclAllowanceRate +
              leaveEncashmentAllowanceRate +
              pmgkyAllowanceRate +
              overtimeAllowanceRate) *
          fullWorkingDays;

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
    // Remove listeners from earnings-related controllers
    workingDaysController.removeListener(_updateAmounts);
    basicWagesRateController.removeListener(_updateAmounts);
    arrearBasicWagesAmountController.removeListener(_updateAmounts);
    hraRateController.removeListener(_updateAmounts);
    tiffinAllowanceRateController.removeListener(_updateAmounts);
    otherAllowanceRateController.removeListener(_updateAmounts);
    prfRateController.removeListener(_updateAmounts);
    washRateController.removeListener(_updateAmounts);
    sheRateController.removeListener(_updateAmounts);
    medRateController.removeListener(_updateAmounts);
    tiffinReimRateController.removeListener(_updateAmounts);

    esiNoController.removeListener(_updateAmounts);

    specialRateController.removeListener(_updateAmounts);
    specialAmountController.removeListener(_updateAmounts);
    skillRateController.removeListener(_updateAmounts);
    skillAmountController.removeListener(_updateAmounts);
    // educationRateController.removeListener(_updateAmounts);
    educationAmountController.removeListener(_updateAmounts);
    heavyDutyAmountController.removeListener(_updateAmounts);
    misclAmountController.removeListener(_updateAmounts);
    attAmountController.removeListener(_updateAmounts);
    overtimeAmountController.removeListener(_updateAmounts);
    leaveEncashmentController.removeListener(_updateAmounts);
    pmgkyAmountController.removeListener(_updateAmounts);

    otRateController.removeListener(_updateAmounts);
    otAmountController.removeListener(_updateAmounts);

    // Remove listeners from deduction-related controllers
    professionalTaxAmountController.removeListener(_updateAmounts);
    gpaAmountController.removeListener(_updateAmounts);
    unionFundAmountController.removeListener(_updateAmounts);
    contractLabourChildrenwelfarefundController.removeListener(_updateAmounts);
    canteenAmountController.removeListener(_updateAmounts);
    wagesAdvanceAmountController.removeListener(_updateAmounts);
    arrearProfessionalTaxAmountController.removeListener(_updateAmounts);
    cmReliefFundAmountController.removeListener(_updateAmounts);
    medicalClaimAmountController.removeListener(_updateAmounts);
    benvolentFundAmountController.removeListener(_updateAmounts);
    incomeTaxAmountController.removeListener(_updateAmounts);
    loanRecoveryAmountController.removeListener(_updateAmounts);
    pfLoanInterestAmountController.removeListener(_updateAmounts);

    customEsiAmountController.removeListener(_updateAmounts);

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    EmployeeInfoColumn(
                      employeeCodeController: employeeCodeController,
                      nameController: nameController,
                      bankNameController: bankNameController,
                      gradeController: gradeController,
                      esiNoController: esiNoController,
                      pfAccountNoController: pfAccountNoController,
                      dobController: dobController,
                      bankAccountNoController: bankAccountNoController,
                      universalAccountNoController:
                          universalAccountNoController,
                      workingDaysController: workingDaysController,
                      weeklyOffController: weeklyOffController,
                    ),
                    EarningColumn(
                      basicWagesRateController: basicWagesRateController,
                      basicWagesAmountController: basicWagesAmountController,
                      hraRateController: hraRateController,
                      hraAmountController: hraAmountController,
                      prefRateController: prfRateController,
                      prefAmountController: prfAmountController,
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
                      arrearBasicWagesAmountController:
                          arrearBasicWagesAmountController,
                      arrearHraRateController: arrearHraController,
                    ),
                    EarningColumnTwo(
                      tiffinAllowanceAmountController:
                          tiffinAllowanceAmountController,
                      tiffinAllowanceRateController:
                          tiffinAllowanceRateController,
                      otRateController: otRateController,
                      otAmountController: otAmountController,
                      otherAllowanceAmountController:
                          otherAllowanceAmountController,
                      otherAllowanceRateController:
                          otherAllowanceRateController,
                      attAmountController: attAmountController,
                      misclAmountController: misclAmountController,
                      leaveEncashmentController: leaveEncashmentController,
                      pmgkyAmountController: pmgkyAmountController,
                      educationAmountController: educationAmountController,
                      heavyDutyAmountController: heavyDutyAmountController,
                      overtimeAmountController: overtimeAmountController,
                      tiffinReimRateController: tiffinReimRateController,
                      tiffinReimAmountController: tiffinReimAmountController,
                      arearAmountController: arrearOtherAmountController,
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeductionColumn(
                    pfAmountController: pfAmountController,
                    esiAmountController: esiAmountController,
                    gpaAmountController: gpaAmountController,
                    unionFundAmountController: unionFundAmountController,
                    childrenWelfareFundAmountController:
                        contractLabourChildrenwelfarefundController,
                    canteenAmountController: canteenAmountController,
                    wagesAdvanceAmountController: wagesAdvanceAmountController,
                    arrearProfessionalTaxAmountController:
                        arrearProfessionalTaxAmountController,
                    cmReliefFundAmountController: cmReliefFundAmountController,
                    miscldednController: miscldednController,
                    taxAmountController: professionalTaxAmountController,
                    medicalClaimController: medicalClaimAmountController,
                    benevolentFundController: benvolentFundAmountController,
                  ),
                  Summary(
                    medicalClaimAmountController: medicalClaimAmountController,
                    benvolentFundAmountController:
                        benvolentFundAmountController,
                    incomeTaxAmountController: incomeTaxAmountController,
                    loanRecoveryAmountController: loanRecoveryAmountController,
                    labourWelfareFundController: labourWelfareFundController,
                    incomeTaxController: incomeTaxAmountController,
                    loanRecoveryController: loanRecoveryAmountController,
                    pfLoanInterest: pfLoanInterestAmountController,
                    miscldednController: miscldednController,
                    esiAmountController: esiAmountController,
                  ),
                  // SizedBox(width: 12,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MonthYearSelectorScreen(
                        pfLoanInterestAmountController:
                            pfLoanInterestAmountController,
                        grossEarningsController: grossEarningsController,
                        grossDeductionsController: grossDeductionsController,
                        netSalaryController: netSalaryController,
                        onMonthYearChanged: _updateSelectedMonthYear,
                      ),
                    ],
                  )
                ],
              ),
            ],
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
          phController: phController,
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
        ),
      ),
    );
  }
}
