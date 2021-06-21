import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
      }

      else if(buttonText == "⌫"){
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        try{
          Parser p = Parser();
          Expression exp = p.parse(equation);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: Container(
        child: TextButton(
            onPressed: () => buttonPressed(buttonText),
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white
              ),
            ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(
        child: Text(
          "Calculator",
          style: TextStyle(
            fontSize: 36.00,
          ),
        ),
      )),
      body: Column(
        children: <Widget>[


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(10),
            child: Text(
              equation,
              style: TextStyle(
                  fontSize: 48.0
              ),
            ),
          ),


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(10),
            child: Text(
              result,
              style: TextStyle(
                  fontSize: 48.0
              ),
            ),
          ),


          Expanded(
            child: Divider(),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("C", 1, Colors.redAccent),
                          buildButton("⌫", 1, Colors.blue),
                          buildButton("/", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.grey),
                          buildButton("8", 1, Colors.grey),
                          buildButton("9", 1, Colors.grey),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.grey),
                          buildButton("5", 1, Colors.grey),
                          buildButton("6", 1, Colors.grey),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.grey),
                          buildButton("2", 1, Colors.grey),
                          buildButton("3", 1, Colors.grey),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.grey),
                          buildButton("0", 1, Colors.grey),
                          buildButton("00", 1, Colors.grey),
                        ]
                    ),
                  ],
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("*", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.redAccent),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
