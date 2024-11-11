// file_upload_for_ot_section.dart
// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:EzeePayslip/pages/upload_file/preview_page.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileUploadForOtSection extends StatefulWidget {
  final double containerHeightFactor;
  const FileUploadForOtSection({super.key, required this.containerHeightFactor});

  @override
  // ignore: library_private_types_in_public_api
  _FileUploadForOtSectionState createState() => _FileUploadForOtSectionState();
}

class _FileUploadForOtSectionState extends State<FileUploadForOtSection> {
  String? otFileName;
  String? otFilePath;
  TextEditingController nameController = TextEditingController();
  Map<String, Map<String, String>> otEmployeeData = {};
  final ValueNotifier<bool> buttonVisible = ValueNotifier<bool>(true);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSavedOtExcelFile();
    });
  }




  Future<void> downloadPdf() async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.openSansRegular();
    final boldFont = await PdfGoogleFonts.openSansBold();

    int rowsPerPage = 20;
    List<Map<String, dynamic>> employeeDataList = [];

    // Gather data in a structured list for table creation
    for (var entry in otEmployeeData.entries) {
      final employeeName = entry.key;
      final data = entry.value;

      // Get "Sr No" from the Excel data, defaulting to 'N/A' if absent
      String srNo = data['Sr No'] ?? 'N/A';

      // Calculate total working days with half-day support
      double totalWorkingDays = data.entries
          .where((e) => e.key.startsWith("Day") && e.value.isNotEmpty)
          .map((e) {
        String dayValue = e.value.toLowerCase().trim();
        if (RegExp(r'^[a-z]$').hasMatch(dayValue)) {
          return 1.0; // Each valid single character counts as 1 day
        } else {
          return 0.0; // Not counted as a working day
        }
      }).fold(0.0, (a, b) => a + b);


// Initialize fold with 0.0 for double

      // Calculate total overtime hours
      int totalOvertime = data.entries
          .where((e) => e.key.startsWith("OT") && (e.value).isNotEmpty)
          .map((e) => int.tryParse(e.value) ?? 0)
          .fold(0, (a, b) => a + b);

      // Calculate overtime days by dividing overtime hours by 8
      double overtimeDays = totalOvertime / 8;

      employeeDataList.add({
        'srNo': srNo,
        'name': employeeName,
        'workingDays': totalWorkingDays.toStringAsFixed(0), // Ensure it’s formatted to 1 decimal
        'overtime': totalOvertime,
        'overtimeDays': overtimeDays.toStringAsFixed(3),
      });
    }

    // Page generation with table content
    for (int i = 0; i < employeeDataList.length; i += rowsPerPage) {
      final rows = employeeDataList.skip(i).take(rowsPerPage).toList();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(16),
          build: (context) {
            return pw.Column(
              children: [
                pw.Text(
                  'SATYAM CONSTRUCTION',
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, font: boldFont),
                ),
                pw.Text(
                  'Employee Overtime Report',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, font: boldFont),
                ),
                pw.SizedBox(height: 10),
                pw.Expanded(
                  child: pw.Table.fromTextArray(
                    headers: ['Sr No', 'Employee Name', 'Working Days', 'Overtime hours', 'Overtime days'],
                    headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: boldFont),
                    cellStyle: pw.TextStyle(font: font),
                    data: rows.map((row) => [
                      row['srNo'],
                      row['name'],
                      row['workingDays'],
                      row['overtime'].toString(),
                      row['overtimeDays']
                    ]).toList(),
                    columnWidths: {
                      0: const pw.FlexColumnWidth(1),
                      1: const pw.FlexColumnWidth(2),
                      2: const pw.FlexColumnWidth(1),
                      3: const pw.FlexColumnWidth(1),
                      4: const pw.FlexColumnWidth(1),
                    },
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    // Generate PDF filename with date and time
    final now = DateTime.now();
    final formattedDateTime = '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}';
    final fileName = 'EmployeeOvertimeReport_$formattedDateTime.pdf';

    // Save PDF to device file system
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      // Notify user of successful download
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to $filePath')),
      );

      // Optional: Use Printing package for sharing or printing the PDF
      await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
    } catch (e) {
      if (kDebugMode) {
        print("Error saving PDF: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save PDF: $e')),
      );
    }
  }

  Future<void> _loadSavedOtExcelFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    otFilePath = prefs.getString('otFilePath');
    if (otFilePath != null) {
      otFileName = otFilePath!.split('/').last;
      loadOtEmployeeData();
    }
  }

  Future<void> uploadOtExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result != null) {
      setState(() {
        otFileName = result.files.single.name;
        otFilePath = result.files.single.path;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('otFilePath', otFilePath!);
      loadOtEmployeeData();
    }
  }

  void loadOtEmployeeData() async {
    if (otFilePath == null) return;
    var fileBytes = File(otFilePath!).readAsBytesSync();
    var excel = Excel.decodeBytes(fileBytes);

    otEmployeeData.clear();

    // Start reading after skipping unnecessary rows (e.g., headers)
    for (var row in excel.tables['Sheet2']!.rows.skip(3)) {
      // Adjust the skip value as needed
      var name = row[3]?.value?.toString() ??
          ''; // Adjust column index for 'EMPLOYEE NAME'
      if (name.isNotEmpty) {
        otEmployeeData[name] = {
          "Sr No": getCellValue(row[0]), // Adjust column index for 'EMP CODE'
          // "Name": name,
          "Day 1": getCellValue(row[4]),
          "OT 1": getCellValue(row[5]),
          // Adjust column index for OT details
          "Day 2": getCellValue(row[6]),
          "OT 2": getCellValue(row[7]),
          // Adjust column index for OT details
          "Day 3": getCellValue(row[8]),
          "OT 3": getCellValue(row[9]),
          // Adjust column index for OT details
          "Day 4": getCellValue(row[10]),
          "OT 4": getCellValue(row[11]),
          // Adjust column index for OT details
          "Day 5": getCellValue(row[12]),
          "OT 5": getCellValue(row[13]),
          // Adjust column index for OT details
          "Day 6": getCellValue(row[14]),
          "OT 6": getCellValue(row[15]),
          // Adjust column index for OT details
          "Day 7": getCellValue(row[16]),
          "OT 7": getCellValue(row[17]),
          // Adjust column index for OT details
          "Day 8": getCellValue(row[18]),
          "OT 8": getCellValue(row[19]),
          // Adjust column index for OT details
          "Day 9": getCellValue(row[20]),
          "OT 9": getCellValue(row[21]),
          // Adjust column index for OT details
          "Day 10": getCellValue(row[22]),
          "OT 10": getCellValue(row[23]),
          // Adjust column index for OT details
          "Day 11": getCellValue(row[24]),
          "OT 11": getCellValue(row[25]),
          // Adjust column index for OT details
          "Day 12": getCellValue(row[26]),
          "OT 12": getCellValue(row[27]),
          // Adjust column index for OT details
          "Day 13": getCellValue(row[28]),
          "OT 13": getCellValue(row[29]),
          // Adjust column index for OT details
          "Day 14": getCellValue(row[30]),
          "OT 14": getCellValue(row[31]),
          // Adjust column index for OT details
          "Day 15": getCellValue(row[32]),
          "OT 15": getCellValue(row[33]),
          // Adjust column index for OT details
          "Day 16": getCellValue(row[34]),
          "OT 16": getCellValue(row[35]),
          // Adjust column index for OT details
          "Day 17": getCellValue(row[36]),
          "OT 17": getCellValue(row[37]),
          // Adjust column index for OT details
          "Day 18": getCellValue(row[38]),
          "OT 18": getCellValue(row[39]),
          // Adjust column index for OT details
          "Day 19": getCellValue(row[40]),
          "OT 19": getCellValue(row[41]),
          // Adjust column index for OT details
          "Day 20": getCellValue(row[42]),
          "OT 20": getCellValue(row[43]),
          // Adjust column index for OT details
          "Day 21": getCellValue(row[44]),
          "OT 21": getCellValue(row[45]),
          // Adjust column index for OT details
          "Day 22": getCellValue(row[46]),
          "OT 22": getCellValue(row[47]),
          // Adjust column index for OT details
          "Day 23": getCellValue(row[48]),
          "OT 23": getCellValue(row[49]),
          // Adjust column index for OT details
          "Day 24": getCellValue(row[50]),
          "OT 24": getCellValue(row[51]),
          // Adjust column index for OT details
          "Day 25": getCellValue(row[52]),
          "OT 25": getCellValue(row[53]),
          // Adjust column index for OT details
          "Day 26": getCellValue(row[54]),
          "OT 26": getCellValue(row[55]),
          // Adjust column index for OT details
          "Day 27": getCellValue(row[56]),
          "OT 27": getCellValue(row[57]),
          // Adjust column index for OT details
          "Day 28": getCellValue(row[58]),
          "OT 28": getCellValue(row[59]),
          // Adjust column index for OT details
          "Day 29": getCellValue(row[60]),
          "OT 29": getCellValue(row[61]),
          // Adjust column index for OT details
          "Day 30": getCellValue(row[62]),
          "OT 30": getCellValue(row[63]),
          // Adjust column index for OT details
          "Day 31": getCellValue(row[64]),
          "OT 31": getCellValue(row[65]),
          // Adjust column index for OT details
        };
      }
    }
    setState(() {});
  }

  String getCellValue(Data? cell) {
    if (cell == null || cell.value == null) {
      return "0";
    }
    return cell.value.toString();
  }

  void previewOtEmployeeData() {
    final name = nameController.text.trim();
    if (name.isNotEmpty && otEmployeeData.containsKey(name)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(
            employeeData: otEmployeeData[name]!,
            employeeName: name,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Employee name $name not found')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * widget.containerHeightFactor,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.47,
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
                    'Upload Excel File for OT',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: uploadOtExcelFile,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Choose File'),
                  ),
                  const SizedBox(height: 10),
                  Text(otFileName ?? 'No file selected',
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Employee Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child: ElevatedButton(
                          onPressed: previewOtEmployeeData,
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
                                "Preview",
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                              // SizedBox(width: 20,),
                              Icon(Icons.preview, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: downloadPdf,
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
                                "Genrate Pdf",
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                              // SizedBox(width: 20,),
                              Icon(Icons.download, color: Colors.white),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 20,),
                  Text("Please ensure the file name is always set to 'Sheet2'.",style: TextStyle(color: Colors.red.shade300),)

                ],
              ),
            ),

    );
  }
}
