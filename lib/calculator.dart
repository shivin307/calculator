import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'info.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var input = '';
  var output = '';
  bool hideInput = false;
  var outputSize = 40.0;

  //TextStyle for Input Text
  TextStyle length() {
    if (input.length > 12) {
      TextStyle l = const TextStyle(
        color: Colors.white,
        fontSize: 40,
      );
      return l;
    }
    if (input.length > 8) {
      TextStyle l = const TextStyle(
        color: Colors.white,
        fontSize: 50,
      );
      return l;
    }

    TextStyle l = const TextStyle(
      color: Colors.white,
      fontSize: 60,
    );
    return l;
  }

  onButtonClick(value) {
    //'clear' Button
    if (value == 'C') {
      input = '';
      output = '';
    }

    //'DELETE' Button
    else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    }

    //'=' Button
    else if (value == '=') {
      if (input.isNotEmpty) {
        String s1 = input.replaceAll('%', '*(1/100)');
        String s = s1.replaceAll('x', '*');
        String userInput = s.replaceAll('÷', '/');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();

        //Return Double value
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);

        output = finalValue.toString().replaceAll('.0', '');
        // if (output.endsWith('.0')) {
        //   output = output.substring(0, output.length - 2);
        // }

        input = output;
        hideInput = true;
        outputSize = 55.0;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34.0;
    }
    setState(() {});
  }

  //Common Widget for create Button
  Widget button(String value, Color btnColor, Color txtColor) {
    return ElevatedButton(
      onPressed: () {
        onButtonClick(value);
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: btnColor,
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 35,
          color: txtColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sBlack,
      appBar: AppBar(
          title: const Text(
            'Calculator',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: sBlack,
          actions: [
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const infoCard();
                  }),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Container(
              color: sBlack,
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideInput ? '' : input,
                      style: length(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      output,
                      style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('C', sLightGrey, sBlack),
                button('<', sLightGrey, sBlack),
                button('%', sLightGrey, sBlack),
                button('÷', sOrange, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('7', sDarkLiver, Colors.white),
                button('8', sDarkLiver, Colors.white),
                button('9', sDarkLiver, Colors.white),
                button('x', sOrange, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('4', sDarkLiver, Colors.white),
                button('5', sDarkLiver, Colors.white),
                button('6', sDarkLiver, Colors.white),
                button('-', sOrange, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('1', sDarkLiver, Colors.white),
                button('2', sDarkLiver, Colors.white),
                button('3', sDarkLiver, Colors.white),
                button('+', sOrange, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(32, 15, 100, 15),
                    shape: const StadiumBorder(),
                    backgroundColor: sDarkLiver,
                  ),
                  onPressed: () {
                    onButtonClick('0');
                  },
                  child: const Text(
                    '0',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                button('.', sDarkLiver, Colors.white),
                button('=', sOrange, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
