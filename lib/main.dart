import 'package:EzeePayslip/splash_screen.dart';

import 'package:flutter/material.dart';

// Global ValueNotifier to control the visibility of the floating action button
final ValueNotifier<bool> showFloatingButton = ValueNotifier(false);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // routes: {
      //   '/PaymentSlip': (context) => const PaymentSlip(
      //     employeeCode: '',
      //     name: '',
      //     bankName: '',
      //     bankAccountNo: '',
      //     dateOfBirth: '',
      //     grade: '',
      //     pfAccountNo: '',
      //     universalAccountNo: '',
      //     esi: '',
      //     workingDays: '',
      //     weeklyOff: '',
      //     leaveDay: '',
      //     ph: '',
      //     basicWagesRate: '',
      //     basicWagesAmount: '',
      //     hraRate: '',
      //     hraAmount: '',
      //     tiffinAllowanceRate: '',
      //     tiffinAllowanceAmount: '',
      //     otherAllowanceRate: '',
      //     otherAllowanceAmount: '',
      //     providentFund: '',
      //     professionalTax: '',
      //     employeeStateInsurance: '',
      //     grossEarning: '',
      //     grossDeduction: '',
      //     netSalary: '',
      //     netSalaryInWord: '',
      //     month: '',
      //     year: '', prfRate: '', prfAmount: '', washRate: '',
      //   ),
      // },
    );
  }
}