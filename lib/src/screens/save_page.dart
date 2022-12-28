import 'package:bookstore/src/db/operation.dart';
import 'package:bookstore/src/models/note.dart';
import 'package:flutter/material.dart';

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
          child : _FormSave(),
        ),
    );
  }
}

class _FormSave extends StatelessWidget{

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

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
              labelText: "Titulo",
                border: OutlineInputBorder()//border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)))
            ),
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
                labelText: "Descripcion",
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