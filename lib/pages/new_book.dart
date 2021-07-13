import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/fields/GenrePickerField.dart';
import 'edit_book.dart';

class NewBook extends StatefulWidget {
    @override
  _NewBookState createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {

   void addToFirebase() {
     var collection = FirebaseFirestore.instance.collection('books');
     collection.add(
        {
          'title': titleController.text,
          'description': descriptionController.text,
          'language': languageController.text,
          'copyright': copyrightController.text,
          'genre': genresController.value,
          'pages': numberOfPagesController.text,
        }
    );
     Navigator.pop(context);
     Navigator.push(context,
         MaterialPageRoute(builder: (context) => EditBook())
     );
  }

  bool _editando = false;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final genresController = GenrePickerFieldController(initialGenres: []);
  final copyrightController = TextEditingController();
  final languageController = TextEditingController();
  final numberOfPagesController = TextEditingController();
  //final firebaseAuth = fba.FirebaseAuth.instance;

  List<String> favouriteGenres = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Novo Livro'),
            backgroundColor: Colors.black
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Titulo da História", border: OutlineInputBorder(),labelStyle: TextStyle(color: Colors.white)),
                onChanged: (text){
                  _editando = true;
                },
              ),
              Divider(),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Descrição da História", border: OutlineInputBorder(),labelStyle: TextStyle(color: Colors.white)),
                onChanged: (text){
                  _editando = true;
                },
              ),
              Divider(),
              TextField(
                controller: copyrightController,
                decoration: InputDecoration(labelText: "Direitos autorais", border: OutlineInputBorder(),labelStyle: TextStyle(color: Colors.white)),
                onChanged: (text){
                  _editando = true;
                //  direitos autorais = text;
                },
              ),
              Divider(),
              TextField(
                controller: languageController,
                decoration: InputDecoration(labelText: "Idioma", border: OutlineInputBorder(),labelStyle: TextStyle(color: Colors.white)),
                onChanged: (text){
                  _editando = true;
                },
              ),
              Divider(),
              TextField(
                keyboardType: TextInputType.number,
                controller: numberOfPagesController,
                decoration: InputDecoration(labelText: "Quantidade de Páginas", border: OutlineInputBorder(),labelStyle: TextStyle(color: Colors.white)),
                onChanged: (text){
                  _editando = true;
                },
              ),
              Divider(),
              GenrePickerField(controller:genresController),
              Divider(),
              Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Criar livro'),
                    onPressed: addToFirebase,
                    color: Colors.black87,
                  )
                ]
              )
            ],
          )
        )
      )
    );
  }

  Future<bool> _requestPop(){
    if(_editando){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
        );
        return Future.value(false);
    }   else{
        return Future.value(true);
    }
  }
}