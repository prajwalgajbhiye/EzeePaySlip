import 'package:flutter/material.dart';

import '../home_page.dart';

class GenerateInvoice extends StatefulWidget {
  @override
  State<GenerateInvoice> createState() => _GenerateInvoiceState();
}

class _GenerateInvoiceState extends State<GenerateInvoice> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sacCodeController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  int?
      _editingDescriptionIndex; // Null means no editing, index refers to the item being edited
  String _description = ""; // Variable to store the description text

  double _totalAmount = 0;

  // List to store service details rows
  List<Map<String, String>> _serviceDetails = [];

  void _addServiceDetails() {
    setState(() {
      _serviceDetails.add({
        'sacCode': _sacCodeController.text,
        'qty': _qtyController.text,
        'rate': _rateController.text,
      });

      // Clear the input fields after adding
      _sacCodeController.clear();
      _qtyController.clear();
      _rateController.clear();
    });
  }

  void _addDescription() {
    setState(() {
      _description = _descriptionController
          .text; // Update description with the text field value
    });
    // Clear the text field after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.teal,
        title: const Text(style: TextStyle(fontSize: 20), 'Invoice'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              double containerWidth = MediaQuery.of(context).size.width * 0.45;
              double containerHeight = MediaQuery.of(context).size.height * 0.8;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildContainer(
                    context,
                    containerWidth,
                    containerHeight,
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // color: Colors.red,
                                child: const Text(
                                  style: TextStyle(fontSize: 10),
                                  'TAX INVOICE',
                                ),
                              ),
                              const Text(
                                style: TextStyle(fontSize: 10),
                                'ORIGINAL',
                              ),
                            ],
                          ),
                          _buildDetailsContainer(
                            serviceProviderDetails:
                                "Details Of Service Provider",
                            serviceReceiverDetails:
                                "Details Of Service Receiver",
                          ),
                          _buildServiceDetailsRow(
                            serviceProviderDetails: [
                              "NAME:         SATYAM CONSTRUCTION",
                              "ADDRESS:131, Plot NO.8, Gollapuram village, Gollapuram, Sri",
                              "Sathyasai, Andhra Pradesh 515211",
                              "STATE                               ANDHRAPRADESH",
                              "",
                              "STATE CODE                  37",
                              "GSTIN NO                        37CLBPD8503R1ZQ",
                              "INVOICE NO                   SC 38",
                              "INVOICE DATE              02/12/2024",
                              "GSTIN NO                        37CLBPD8503R1ZQ",
                            ],
                            serviceReceiverDetails: [
                              "NAME:                    SUNFLAG IRON & STEEL CO. LTD",
                              "ADDRESS: P.O B HANDARA RAOD WARTHI, PIN NO 441905 DIST.",
                              "BHANDARA (M.S)  INDIA.",
                              "STATE                   MAHARASHTRA",
                              "",
                              "STATE CODE       27",
                              "GSTIN NO              27AACCS3376C1ZH",
                              "",
                              "PAN NO   ",
                            ],
                          ),
                          _buildServiceHeaderRow(),
                          _buildEnterServiceDetailsRow(),
                          Row(
                            children: [
                              Flexible(
                                  flex: 10,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom:
                                                BorderSide(color: Colors.black),
                                            top: BorderSide(
                                                color: Colors.black))),
                                    child: const Text(
                                      "TAX PAYABLE ON REVERSE CHARGE BASIS: NO",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 9,
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom:
                                                BorderSide(color: Colors.black),
                                            right: BorderSide(
                                                color: Colors.black))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Total Tax Value (in words)",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "Rupees Eighty Thousand Five Hundred Ninty Three Rupees",
                                              style: TextStyle(fontSize: 10)),
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text("GST@18%",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 10)))),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                      child: const Text("₹ 80,592.66",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(fontSize: 10)))),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom:
                                                BorderSide(color: Colors.black),
                                            right: BorderSide(
                                                color: Colors.black))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Rupees",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "Five Lakh Twenty Eight Thousand Three Hundred Thirty",
                                              style: TextStyle(fontSize: 10)),
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text("GST@18%",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 10)))),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text("₹ 80,592.66",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(fontSize: 10)))),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Text(
                              "CERTIFIED THAT THE PARTICULARS GIVEN AROVE ARE TRUE AND CORRECT",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  child: const Text(
                                    "For SATYAM CONSTRUCTION",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: const Text(
                                    "AUTHORISED SIGNATURE",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  buildContainer(
                    context,
                    containerWidth,
                    containerHeight,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter Service Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Row for "Description of Work/Service"
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    height: 100,
                                    child: TextField(
                                      controller: _descriptionController,
                                      maxLines: null,
                                      // Allows the text field to grow with content
                                      expands: true,
                                      // Makes the TextField expand to fill its container
                                      decoration: InputDecoration(
                                        labelText:
                                            'Description of Work/Service',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              5), // Set radius to 5
                                        ),
                                      ),
                                      textAlignVertical: TextAlignVertical
                                          .top, // Start text at the top
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _addDescription,
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                label: const Text(
                                  'Add Description',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: Colors.teal,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Row for SAC Code, QTY, and Rate
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: TextField(
                                      controller: _sacCodeController,
                                      decoration: InputDecoration(
                                        labelText: 'SAC Code',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: _qtyController,
                                    decoration: InputDecoration(
                                      labelText: 'QTY',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: _rateController,
                                    decoration: InputDecoration(
                                      labelText: 'Rate',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _addServiceDetails,
                                // onPressed: _addServiceDetails,
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                label: const Text(
                                  'Add Service Details',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: Colors.teal,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Logic for downloading PDF
                },
                icon: const Icon(Icons.download, color: Colors.white),
                label: const Text(
                  'Download PDF',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }




  Widget _buildEnterServiceDetailsRow() {
    // Helper function to build table cells
    Widget buildColumnCell(
        List<String> texts, {
          int flex = 1,
          bool hasRightBorder = true,
          bool hasTopBorder = false, // New parameter for top border
          double height = 20,
        }) {
      return Expanded(
        flex: flex,
        child: Container(
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              top: hasTopBorder ? const BorderSide(color: Colors.black) : BorderSide.none,
              right: hasRightBorder ? const BorderSide(color: Colors.black) : BorderSide.none,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: texts
                .map((text) => Text(
              text,
              style: const TextStyle(fontSize: 10),
            ))
                .toList(),
          ),
        ),
      );
    }

    // Calculate total amount
    double totalAmount = _serviceDetails.fold(
      0.0,
          (sum, service) {
        double qty = double.tryParse(service['qty'] ?? '0') ?? 0.0;
        double rate = double.tryParse(service['rate'] ?? '0') ?? 0.0;
        return sum + (qty * rate);
      },
    );

    return Container(
      height: 200, // Fixed height for the container
      child: Row(
        children: [
          // Fixed Description Column
          Expanded(
            flex: 7, // Adjust flex value to control width
            child: Container(
              height: double.infinity,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: double.infinity,
                  width: 200,
                  child: Text(
                    _description,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),

          // Dynamic Rows for Service Details
          Expanded(
            flex: 7,
            child: Column(
              children: [
                // Rows for service details
                Expanded(
                  child: Column(
                    children: List.generate(9, (index) {
                      if (index < _serviceDetails.length) {
                        // Use existing service details
                        final service = _serviceDetails[index];
                        double qty = double.tryParse(service['qty'] ?? '0') ?? 0.0;
                        double rate = double.tryParse(service['rate'] ?? '0') ?? 0.0;
                        double amount = qty * rate;

                        return Row(
                          children: [
                            buildColumnCell([service['sacCode'] ?? ''], flex: 2),
                            buildColumnCell([service['qty'] ?? ''], flex: 2),
                            buildColumnCell([service['rate'] ?? ''], flex: 1),
                            buildColumnCell(
                              ['₹ ${amount.toStringAsFixed(2)}'],
                              flex: 2,
                              hasRightBorder: true,
                            ),
                          ],
                        );
                      } else {
                        // Empty row
                        return Row(
                          children: [
                            buildColumnCell([''], flex: 2),
                            buildColumnCell([''], flex: 2),
                            buildColumnCell([''], flex: 1),
                            buildColumnCell([''], flex: 2, hasRightBorder: true),
                          ],
                        );
                      }
                    }),
                  ),
                ),
                // Total Amount Row with Top Border only on the final column
                Row(
                  children: [
                    buildColumnCell([''], flex: 2),
                    buildColumnCell([''], flex: 2),
                    buildColumnCell([''], flex: 1),
                    buildColumnCell(
                      ['₹ ${totalAmount.toStringAsFixed(2)}'],
                      flex: 2,
                      hasRightBorder: true,
                      hasTopBorder: true, // Add top border only here
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget buildColumnDescriptionCell(
    String text, {
    bool hasRightBorder = true,
    double height = 200,
  }) {
    return Expanded(
      flex: 7,
      child: Container(
          alignment: Alignment.topCenter,
          height: height,
          decoration: BoxDecoration(
            // color: Colors.blue,
            border: Border(
              right: hasRightBorder
                  ? const BorderSide(color: Colors.black)
                  : BorderSide.none,
            ),
          ),
          child: Container(
            height: 200,
            width: 200,
            // color: Colors.green,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Widget buildColumnAmountCell(
    String text, {
    bool hasRightBorder = true,
    double height = 200,
  }) {
    return Expanded(
      flex: 7,
      child: Container(
          alignment: Alignment.topCenter,
          height: height,
          decoration: BoxDecoration(
            // color: Colors.blue,
            border: Border(
              right: hasRightBorder
                  ? const BorderSide(color: Colors.black)
                  : BorderSide.none,
            ),
          ),
          child: Container(
            height: 200,
            width: 200,
            // color: Colors.green,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Widget _buildDetailsContainer({
    required String serviceProviderDetails,
    required String serviceReceiverDetails,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black),
                ),
              ),
              child: Text(
                serviceProviderDetails,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              serviceReceiverDetails,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetailsRow({
    required List<String> serviceProviderDetails,
    required List<String> serviceReceiverDetails,
  }) {
    Widget buildDetailsColumn(List<String> details) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: details.map((detail) {
          return Text(
            detail,
            style: const TextStyle(fontSize: 10),
          );
        }).toList(),
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.black),
              ),
            ),
            child: buildDetailsColumn(serviceProviderDetails),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            child: buildDetailsColumn(serviceReceiverDetails),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceHeaderRow() {
    Widget buildHeaderCell(String text,
        {bool hasRightBorder = true, int flex = 1}) {
      return Expanded(
        flex: flex,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              right: hasRightBorder
                  ? const BorderSide(color: Colors.black)
                  : BorderSide.none,
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          buildHeaderCell("DESCRIPTION OF WORK/SERVICE", flex: 7),
          buildHeaderCell("SAC CODE", flex: 2),
          buildHeaderCell("QTY", flex: 2),
          buildHeaderCell("RATE", flex: 1),
          buildHeaderCell("AMOUNT", flex: 2, hasRightBorder: false),
        ],
      ),
    );
  }
}

Widget buildContainer(
    BuildContext context, double width, double height, Widget child) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(2, 4))
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    ),
  );
}
