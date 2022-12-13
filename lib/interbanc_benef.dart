import 'package:flutter/cupertino.dart';

class Avances_benef_interbank extends StatefulWidget{
  const Avances_benef_interbank({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _Avances_benef_interbank_state();

}

class _Avances_benef_interbank_state extends State<Avances_benef_interbank> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Ben1ef 1', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        SizedBox(height: 5),
        Text('Benef 2', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ],
    );
  }
}