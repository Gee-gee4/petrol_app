import 'package:flutter/material.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class ReceiptPage extends StatelessWidget {
  final Map<String, dynamic> receiptData;

  const ReceiptPage({super.key, required this.receiptData});

  // Format each item line in receipt
  String formatReceiptLine(Map<String, dynamic> item) {
    final prod = (item['itemName'] ?? '').padRight(7).substring(0, 7);
    final priceNum = (item['price'] ?? 0).toDouble();
    final qtyNum = (item['quantity'] ?? 0).toDouble();
    final discountNum = (item['discountAmount'] ?? 0).toDouble();
    final taxType = ((item['taxType'] ?? '').toString().toUpperCase())
        .padLeft(3)
        .substring(0, 3);

    final totalAmt = (priceNum * qtyNum) - discountNum;

    final price = priceNum.toStringAsFixed(2).padLeft(7);
    final qty = qtyNum.toStringAsFixed(0).padLeft(4);
    final total = totalAmt.toStringAsFixed(2).padLeft(10);

    return "$prod$price$qty$total$taxType";
  }

  // Calculate grand total of all items
  double calculateGrandTotal(List<dynamic> items) {
    return items.fold(0.0, (sum, item) {
      final priceNum = (item['price'] ?? 0).toDouble();
      final qtyNum = (item['quantity'] ?? 0).toDouble();
      final discountNum = (item['discountAmount'] ?? 0).toDouble();
      final totalAmt = (priceNum * qtyNum) - discountNum;
      return sum + totalAmt;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle receiptStyle = const TextStyle(
      fontFamily: 'Courier',
      fontSize: 14,
    );

    final taxableAmount = Map<String, dynamic>.from(
      receiptData['taxableAmount'] ?? {},
    );

    return Scaffold(
      backgroundColor: hexToColor('d7eaee'),
      extendBody: true,
      appBar: AppBar(
        title: const Text('Sale Receipt'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 300, // Approximate thermal paper width
            padding: const EdgeInsets.all(12),
            color: Colors.white70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                Text(
                  receiptData["companyName"] ?? '',
                  style: receiptStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold,),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'TIN: ${receiptData["companyTIN"] ?? ''}',
                  style: receiptStyle,
                ),
                const SizedBox(height: 8),
                const Divider(),
                Text('TAX INVOICE', style: receiptStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold,)),
                const SizedBox(height: 8),

                // Buyer Info
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _row(
                        'Buyer\'s Name:',
                        '${receiptData["buyerName"] ?? ''}',
                        receiptStyle,
                      ),
                      _row(
                        'Buer\'s Tin:',
                        '${receiptData["buyerTIN"] ?? ''}',
                        receiptStyle,
                      ),
                      _row(
                        'Buyer\'s Phone:',
                        '${receiptData["buyerPhone"] ?? ''}',
                        receiptStyle,
                      ),
                    ],
                  ),
                ),
                const Divider(),

                // Items list & totals (conditionally included)
                if (receiptData['items'] != null) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prod    Price  Qty  Total  Type',
                        style: receiptStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '-------------------------------',
                        style: receiptStyle,
                      ),
                      const SizedBox(height: 4),

                      ...receiptData['items'].map<Widget>((item) {
                        return Text(
                          formatReceiptLine(item),
                          style: receiptStyle,
                        );
                      }).toList(),

                      Text(
                        '-------------------------------',
                        style: receiptStyle,
                      ),

                      _row(
                        'Bill Total',
                        calculateGrandTotal(
                          receiptData['items'],
                        ).toStringAsFixed(2),
                        receiptStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],

                const Divider(),

                // Taxable Amounts
                for (var key in taxableAmount.keys)
                  _row(
                    'Taxable (${key.toUpperCase()})',
                    '${(taxableAmount[key] ?? 0).toStringAsFixed(3)}',
                    receiptStyle,
                  ),

                const Divider(),

                // ======= Tax Details =======
                _row(
                  'Tax Receipt No:',
                  '${receiptData["taxRcptNo"] ?? ''}',
                  receiptStyle,
                ),
                _row(
                  'Tax SDC ID:',
                  '${receiptData["taxSdcId"] ?? ''}',
                  receiptStyle,
                ),

                _row(
                  'Receipt Sign:',
                  '${receiptData["taxRcptSign"] ?? ''}',
                  receiptStyle,
                ),
                _row(
                  'MRC No:',
                  '${receiptData["taxMrcNo"] ?? ''}',
                  receiptStyle,
                ),

                const Divider(),
                const Divider(),

                const SizedBox(height: 10),
                Text("Thank you for your purchase!", style: receiptStyle),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: hexToColor('005954'),
          child: const Icon(Icons.print, color: Colors.white),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _row(String label, String value, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Expanded(
            child: Text(
              value,
              style: style,
              textAlign: TextAlign.right,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
