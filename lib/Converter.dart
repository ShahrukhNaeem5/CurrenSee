import 'package:flutter/material.dart';

class Converter extends StatefulWidget {
  const Converter({Key? key}) : super(key: key);

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  String selectedCurrency1 = 'USD'; // Initially selected currency for first dropdown
  String selectedCurrency2 = 'USD'; // Initially selected currency for second dropdown

  String getFlagImage(String currency) {
    switch (currency) {
      case 'USD':
        return 'images/UsaFlag.png';
      case 'EUR':
        return 'images/EuroFlag.png';
      case 'GBP':
        return 'images/GbpFlag.png';
      case 'JPY':
        return 'images/JpyFlag.png';
      case 'RS':
        return 'images/PakFlag.png'; // Change this to the path of your flag image
      default:
        return 'images/DefaultFlag.png'; // Change this to the path of your default flag image
    }
  }

  void swapCurrencies() {
    setState(() {
      String temp = selectedCurrency1;
      selectedCurrency1 = selectedCurrency2;
      selectedCurrency2 = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
/*         title: const Text("Converter"),
 */      ),
      body: Container(
        child: Column(
          children: [
            Text(
              "Currency Converter",
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
                ],
              ),
            ),
            const Text("We Are Here To Serve You",
            style: TextStyle(
              fontWeight: FontWeight.w400
            ),
            
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
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Image(
                          image: AssetImage(getFlagImage(selectedCurrency1)),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: DropdownExample(
                            selectedCurrency: selectedCurrency1,
                            onChanged: (String newValue) {
                              setState(() {
                                selectedCurrency1 = newValue; // Update selected currency for the first dropdown
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5, top: 5, right: 10, bottom: 5),
                          child: Container(
                            width: 700,
                            color: const Color.fromARGB(
                                255, 226, 226, 226),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: const [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(
                                          255, 226, 226, 226),
                                      hintText: 'Enter Your Amount',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
                    Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 4, 58, 235), // Background color
                      shape: BoxShape.circle, // Makes the container circular
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.compress_rounded),
                      iconSize: 35,
                      color: Colors.white, // Foreground color
                      onPressed: swapCurrencies,
                    ),
                  ),
            Container(
              color: const Color.fromARGB(255, 243, 243, 243),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Image(
                          image: AssetImage(getFlagImage(selectedCurrency2)),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: DropdownSecond(
                            selectedCurrency: selectedCurrency2,
                            onChanged: (String newValue) {
                              setState(() {
                                selectedCurrency2 = newValue; // Update selected currency for the second dropdown
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5, top: 5, right: 10, bottom: 5),
                          child: Container(
                            width: 700,
                            color: const Color.fromARGB(
                                255, 226, 226, 226),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: const [
                                Expanded(
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(
                                          255, 226, 226, 226),
                                      hintText: 'Converted Amount',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
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

class DropdownExample extends StatelessWidget {
  final String selectedCurrency;
  final ValueChanged<String> onChanged;

  const DropdownExample({
    Key? key,
    required this.selectedCurrency,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        DropdownButton<String>(
          value: selectedCurrency,
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue); // Call the onChanged callback
            }
          },
          items: <String>['USD', 'EUR', 'GBP', 'JPY', 'RS'] // List of currencies
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class DropdownSecond extends StatelessWidget {
  final String selectedCurrency;
  final ValueChanged<String> onChanged;

  const DropdownSecond({
    Key? key,
    required this.selectedCurrency,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        DropdownButton<String>(
          value: selectedCurrency,
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue); // Call the onChanged callback
            }
          },
          items: <String>['USD', 'EUR', 'GBP', 'JPY', 'RS'] // List of currencies
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Converter(),
  ));
}
