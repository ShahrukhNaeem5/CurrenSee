import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class Converter extends StatefulWidget {
  const Converter({Key? key}) : super(key: key);

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  List<String> currencies = [
    'USD'
  ]; // List to hold currency options, initialize with a default currency
  String selectedCurrency1 = 'USD'; // Initially selected currency for first dropdown
  String selectedCurrency2 = 'USD'; // Initially selected currency for second dropdown
  double exchangeRate = 1.0;
  double amount = 0.0;
  final String appId = 'bccbefbec6c2496f81a608e5e120da79';

  @override
  void initState() {
    super.initState();
    fetchCurrencies();
  }

  Future<void> fetchCurrencies() async {
    try {
      final currencyResponse = await http.get(Uri.parse(
          'https://openexchangerates.org/api/currencies.json?app_id=$appId'));

      if (currencyResponse.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(currencyResponse.body);
        // Extract currencies from the API response
        List<String> fetchedCurrencies = data.keys.toList();
        setState(() {
          currencies = fetchedCurrencies;
          selectedCurrency1 = fetchedCurrencies.first;
          selectedCurrency2 = fetchedCurrencies.first;
        });
      } else {
        throw Exception('Failed to fetch currencies');
      }

      await fetchExchangeRate();
    } catch (error) {
      print('Error fetching currencies: $error');
    }
  }

  Future<void> fetchExchangeRate() async {
    try {
      final exchangeRateResponse = await http.get(Uri.parse(
          'https://openexchangerates.org/api/latest.json?app_id=$appId'));

      if (exchangeRateResponse.statusCode == 200) {
        final Map<String, dynamic> data =
            json.decode(exchangeRateResponse.body);
        // Extract exchange rates from the API response
        double rate = data['rates'][selectedCurrency2];
        setState(() {
          exchangeRate = rate;
        });
      } else {
        throw Exception('Failed to fetch exchange rates');
      }
    } catch (error) {
      print('Error fetching exchange rates: $error');
    }
  }

  void onCurrency1Changed(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedCurrency1 = newValue;
      });
      fetchExchangeRate(); // You need to fetch exchange rate when the first currency changes
    }
  }

  void onCurrency2Changed(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedCurrency2 = newValue;
      });
      fetchExchangeRate(); // You need to fetch exchange rate when the second currency changes
    }
  }

  void onAmountChanged(String value) {
    setState(() {
      amount = double.tryParse(value) ?? 0.0;
    });
  }

  double calculateConvertedAmount() {
    return amount * exchangeRate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("Currency Converter",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        offset: Offset(2, 2),
                        blurRadius: 3,
                      ),
                    ])),
            const Text(
              "We Are Here To Serve You",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              color: const Color.fromARGB(255, 243, 243, 243),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 0, 100.0, 0),
                          child: SizedBox(
                            width: 50,
                            child: DropdownButton<String>(
                              value: selectedCurrency1,
                              onChanged: onCurrency1Changed,
                              items: currencies.map((String currency) {
                                return DropdownMenuItem<String>(
                                  value: currency,
                                  child: Text(currency),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: onAmountChanged,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 226, 226, 226),
                              hintText: 'Enter Your Amount',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              color: const Color.fromARGB(255, 243, 243, 243),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 0, 100.0, 0),
                          child: SizedBox(
                            width: 50,
                            child: DropdownButton<String>(
                              value: selectedCurrency2,
                              onChanged: onCurrency2Changed,
                              items: currencies.map((String currency) {
                                return DropdownMenuItem<String>(
                                  value: currency,
                                  child: Text(currency),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            enabled: false,
                            controller: TextEditingController(text: calculateConvertedAmount().toStringAsFixed(2)),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 226, 226, 226),
                              hintText: 'Converted Amount',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Converter(),
  ));
}
