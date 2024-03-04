import 'package:currency_converter/currency.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/currency_converter.dart';

// ignore: must_be_immutable
class ProductPricing extends StatefulWidget {
  const ProductPricing({super.key});

  @override
  State<ProductPricing> createState() => _MyFieldState();
}

class _MyFieldState extends State<ProductPricing> {
  //Section for Product Pricing
  double result = 0.00;
  TextEditingController productpriceController = TextEditingController();
  TextEditingController sellingmarginController = TextEditingController();
  double productPrice = 0.00;
  double sellingMargin = 0.00;
  void productPricing() {
    productPrice = double.tryParse(productpriceController.text) ?? 0.0;
    sellingMargin = double.tryParse(sellingmarginController.text) ?? 0.0;

    setState(() {
      result = productPrice + sellingMargin;
    });
  }

  //Section For Marketing Cost
  var finalConvert = 0.00;
  TextEditingController dollarpriceController = TextEditingController();
  TextEditingController marketingcostController = TextEditingController();
  TextEditingController marketingCostRuppesController = TextEditingController();
  double marketingCostRupees = 0.00;
  marketing() async {
    marketingCostRupees =
        double.tryParse(marketingCostRuppesController.text) ?? 0.0;
    Currency myCurrency = Currency.pkr;
    var usdConvert = await CurrencyConverter.convert(
      from: Currency.usd,
      to: myCurrency,
      amount: double.tryParse(marketingcostController.text) ?? 1.0,
    );
    setState(() {
      finalConvert = usdConvert!.toDouble();
      marketingCostRupees = finalConvert;
    });
  }

  //Section For order
  var ordersFinal;
  TextEditingController ordersPerDayController = TextEditingController();
  TextEditingController ordersPerMonthController = TextEditingController();
  TextEditingController shippingCostController = TextEditingController();
  var ordersPerDay = 0.00;
  orders() {
    ordersPerDay = double.tryParse(ordersPerDayController.text) ?? 1;
    ordersFinal = double.tryParse(ordersPerDayController.text) ?? 1;
    setState(() {
      ordersFinal = ordersFinal * 30;
    });
  }

  //

  double deliveredOrders = 0.00;
  TextEditingController confirmedOrdersController = TextEditingController();
  TextEditingController possibleReturnsController = TextEditingController();
  double confirmedOrders = 0.00;
  double returnedOrders = 0.00;
  confirmorders() {
    confirmedOrders = double.tryParse(confirmedOrdersController.text) ?? 1;
    returnedOrders = double.tryParse(possibleReturnsController.text) ?? 1;
    setState(() {
      deliveredOrders = confirmedOrders - returnedOrders;
    });
  }

  double totalShippingCost = 1.00;
  calculations() {
    double shippingCost = double.tryParse(shippingCostController.text) ?? 1.0;
    setState(() {
      totalShippingCost = shippingCost;
    });
  }

  @override
  void initState() {
    super.initState();
    productpriceController.addListener(productPricing);
    sellingmarginController.addListener(productPricing);
    marketing();
    marketingCostRuppesController.addListener(marketing);
    dollarpriceController.addListener(marketing);
    marketingcostController.addListener(marketing);
    ordersPerDayController.addListener(orders);
    confirmedOrdersController.addListener(confirmorders);
    possibleReturnsController.addListener(confirmorders);
    confirmedOrdersController.addListener(calculations);
    shippingCostController.addListener(calculations);
  }

  @override
  void dispose() {
    productpriceController.dispose();
    sellingmarginController.dispose();
    dollarpriceController.dispose();
    marketingcostController.dispose();
    ordersPerDayController.dispose();
    confirmedOrdersController.dispose();
    possibleReturnsController.dispose();
    shippingCostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var totalDeliveredOrders = result * deliveredOrders;
    var totalShippingCostFinal = totalShippingCost * confirmedOrders;
    var productCostofDeliveredOrders = productPrice * deliveredOrders;
    var totalMarketingCostofOrders = marketingCostRupees * ordersPerDay;
    var productTotalCost = productPrice * confirmedOrders;
    var investemntRequired = productTotalCost + totalMarketingCostofOrders;
    var profitLoss = totalDeliveredOrders -
        totalShippingCostFinal -
        productCostofDeliveredOrders -
        totalMarketingCostofOrders;
    //15days Calculation.
    var days15productTotalCost = productTotalCost * 15;
    var days15totalMarketingCostofOrders = totalMarketingCostofOrders * 15;
    var days15investemntRequired = investemntRequired * 15;
    var days15profitLoss = profitLoss * 15;
    //30days Calculation.
    var days30productTotalCost = productTotalCost * 30;
    var days30totalMarketingCostofOrders = totalMarketingCostofOrders * 30;
    var days30investemntRequired = investemntRequired * 30;
    var days30profitLoss = profitLoss * 30;
    Color mY() {
      if (profitLoss < 0) {
        return Colors.red;
      } else {
        return Colors.green;
      }
    }

    //Code for product pricing section
    return Column(
      children: [
        Container(
          height: 450,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            color: Colors.lightBlue[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  "Product Pricing",
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              ListTile(
                title: const Text(
                  "Product Price",
                ),
                subtitle: TextFormField(
                  controller: productpriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "0.00",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
              ),
              ListTile(
                title: const Text(
                  "Selling Margin",
                ),
                subtitle: TextFormField(
                  controller: sellingmarginController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "0.00",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
              ),
              ListTile(
                title: const Text(
                  "Selling Price",
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    height: 70,
                    width: 500,
                    child: Text(
                      result.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //Code for marrketing section.
        Container(
          height: 550,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            color: const Color(0xfff08080),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  "Marketing Cost",
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              ListTile(
                title: const Text(
                  "Dollar Price",
                ),
                subtitle: TextFormField(
                  readOnly: true,
                  controller: dollarpriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Dollar Price updated",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
              ),
              ListTile(
                title: const Text(
                  "Marketing Cost in Dollars",
                ),
                subtitle: TextFormField(
                  controller: marketingcostController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      //  label: ,
                      hintText: "1",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
              ),
              ListTile(
                title: const Text(
                  "Marketing Cost USD to PKR",
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    height: 30,
                    width: 500,
                    child: Text(
                      "$finalConvert ${Currency.pkr.name.toUpperCase()}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  "Marketing Cost in Rupees",
                ),
                subtitle: TextFormField(
                  controller: marketingCostRuppesController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      //  label: ,
                      hintText: marketingCostRupees.toString(),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //Container For Orders Section.
        Container(
          height: 450,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            color: const Color(0xff90EE90),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  "Orders & Shipping",
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              ListTile(
                title: const Text(
                  "Orders/Day",
                ),
                subtitle: TextFormField(
                  controller: ordersPerDayController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "0.00",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
              ),
              ListTile(
                title: const Text(
                  "Orders/Month",
                ),
                subtitle: TextFormField(
                  readOnly: true,
                  controller: ordersPerMonthController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: ordersFinal.toString(),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
              ),
              ListTile(
                title: const Text(
                  "Shipping Cost",
                ),
                subtitle: TextFormField(
                  controller: shippingCostController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "0.00",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 450,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            color: const Color(0xffB0C4DE),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  "Confirmed Orders",
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              ListTile(
                title: const Text(
                  "Confirmed Orders",
                ),
                subtitle: TextFormField(
                  controller: confirmedOrdersController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "0",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
              ),
              ListTile(
                title: const Text(
                  "Possible Returns",
                ),
                subtitle: TextFormField(
                  controller: possibleReturnsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      //  label: ,
                      hintText: "1",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
              ),
              ListTile(
                title: const Text(
                  "Delivered Orders",
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    height: 70,
                    width: 500,
                    child: Text(
                      deliveredOrders.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(borderRadius: BorderRadius.circular(10)),
            columns: const [
              DataColumn(label: Text('Finance')),
              DataColumn(label: Text('Amount')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Delivered $deliveredOrders Orders Amount')),
                DataCell(Text(totalDeliveredOrders.toString())),
              ]),
              DataRow(cells: [
                DataCell(Text(
                    'Total Shipping Cost Of ${confirmedOrdersController.text} Orders')),
                DataCell(Text(totalShippingCostFinal.toString())),
              ]),
              DataRow(cells: [
                DataCell(Text('Product Cost Of $deliveredOrders Orders')),
                DataCell(Text(productCostofDeliveredOrders.toString())),
              ]),
              DataRow(cells: [
                DataCell(Text(
                    'marketing Cost of ${ordersPerDayController.text} Orders')),
                DataCell(Text(totalMarketingCostofOrders.toString())),
              ]),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          height: 80,
          width: 200,
          decoration: BoxDecoration(
            color: mY(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            profitLoss.toStringAsFixed(2),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        //table
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(borderRadius: BorderRadius.circular(10)),
            columns: const [
              DataColumn(label: Text('Content')),
              DataColumn(label: Text('1 Day')),
              DataColumn(label: Text('15 Days')),
              DataColumn(label: Text('30 Days')),
            ],
            rows: [
              DataRow(cells: [
                const DataCell(Text('Product Total Cost')),
                DataCell(Text(productTotalCost.toString())),
                DataCell(Text(days15productTotalCost.toString())),
                DataCell(Text(days30productTotalCost.toString())),
              ]),
              DataRow(cells: [
                const DataCell(Text('Marketing Total Cost')),
                DataCell(Text(totalMarketingCostofOrders.toString())),
                DataCell(Text(days15totalMarketingCostofOrders.toString())),
                DataCell(Text(days30totalMarketingCostofOrders.toString())),
              ]),
              DataRow(cells: [
                const DataCell(Text('Investment Required')),
                DataCell(Text(investemntRequired.toString())),
                DataCell(Text(days15investemntRequired.toString())),
                DataCell(Text(days30investemntRequired.toString())),
              ]),
              DataRow(cells: [
                const DataCell(Text('Profit/Loss')),
                DataCell(Text(profitLoss.toStringAsFixed(2))),
                DataCell(Text(days15profitLoss.toStringAsFixed(2))),
                DataCell(Text(days30profitLoss.toStringAsFixed(2))),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
