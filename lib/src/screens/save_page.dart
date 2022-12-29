import 'package:bookstore/src/db/operation.dart';
import 'package:bookstore/src/models/note.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

class SavePage extends StatelessWidget {

  static const String ROUTE = "/save";

  final String title = 'Save';

  const SavePage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guardar"),
      ),
        body: Container(
          child : FormSave(),
        ),
    );
  }
}

class FormSave extends StatefulWidget {
  @override
  _FormSave createState() => _FormSave();
}

class _FormSave extends State<FormSave>{

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime date = DateTime.now();
  double maxValue = 0;
  bool? brushedTeeth = false;
  bool enableFeature = false;


  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
          TextFormField(
            controller: titleController,
            validator: (value){
              if(value!.isEmpty){
                 return "El campo es obligatorio";
              }

              return null;
            },
            decoration: InputDecoration(
              labelText: "Numero Referencia",
                border: OutlineInputBorder()//border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)))
            ),
          ),
            SizedBox(height: 15,),
            _FormDatePicker(
              date: date,
              onChanged: (value) {
                setState(() {
                  date = value;
                });
              },
            ),
          SizedBox(height: 15,),
          TextFormField(
            controller: descriptionController,
            validator: (value){
              if(value!.isEmpty){
                return "El campo es obligatorio";
              }

              return null;
            },
            maxLines: 4,
            maxLength: 100,
            decoration: InputDecoration(
                labelText: "Monto",
                border: OutlineInputBorder()//border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)))
            ),
          ),

            ElevatedButton(child: Text("Guardar"), onPressed: (){
            if(_formKey.currentState!.validate()){
              print("Guardar");
              Operation.insert(Note(title: titleController.text, description: descriptionController.text));

            }
          },)
      ],
      ),
        ),
      ),
    );

  }

}

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.date,
    required this.onChanged,
  });

  @override
  State<_FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.date),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        TextButton(
          child: const Text('Edit'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}