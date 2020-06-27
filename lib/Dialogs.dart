import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

class Dialogs {

  showAddTypeDialog(BuildContext context, String hebSuff) {
    Widget cancelButton = FlatButton(
      child: Text(
        hebSuff == "" ? "Cancel" : "ביטול",
        style: TextStyle(color: Colors.blueAccent,
            fontWeight: FontWeight.bold
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(hebSuff == "" ? "Restore type" : "שחזור קטוגריה",
        textAlign: hebSuff == "" ? TextAlign.left : TextAlign.right,),
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      content: Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 5.5,
        child: Column(
          children: [
            Text(hebSuff == "" ?
            "Choose the type you want to make visible"
                : "בחר איזו קטגוריה לשחזר"),
            ChoiceChip(
              label: Text(hebSuff == "" ? 'Business lunch' : 'עסקיות',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              selected: false,
              onSelected: (_) {
                Navigator.pop(context);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    hebSuff == "" ? 'Restored successfully!' : '!שוחזר בהצלחה',
                    textAlign: hebSuff == "" ? TextAlign.left : TextAlign
                        .right,),
                )
                );
              },
            )
          ],
        ),
      ),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showDeleteTypeDialog(BuildContext context, String hebSuff) {
    Widget okButton = FlatButton(
      child: Text(
        hebSuff == "" ? "OK" : "אישור",
        style: TextStyle(color: Colors.blueAccent,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              hebSuff == "" ? 'Changed successfully!' : '!שונה בהצלחה',
              textAlign: hebSuff == "" ? TextAlign.left : TextAlign.right,)));
      },
    );

    Widget cancelButton = FlatButton(
      child: Text(
        hebSuff == "" ? "Cancel" : "ביטול",
        style: TextStyle(color: Colors.blueAccent,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: hebSuff == ""
          ? Text("Do you want to make this type invisible? ")
          : Text("בלחיצה על אישור קטוגריה זו תהיה מוסתרת",
        textAlign: TextAlign.right,),
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showNavigationDialog(BuildContext context, String hebSuff) {
    Widget okButton = FlatButton(
      child: Text(
        hebSuff == "" ? "OK" : "אישור",
        style: TextStyle(color: Colors.blueAccent,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: hebSuff == ""
          ? Text("Try holding the tile and reorder the dishes")
          : Text("לחץ לחיצה ארוכה על המנה לשינוי סדר ההופעה",
        textAlign: TextAlign.right,),
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showRestoreDishDialog(BuildContext context, String hebSuff) {
    Widget okButton = FlatButton(
      child: Text(
        hebSuff == "" ? "Restore" : "שחזר",
        style: TextStyle(color: Colors.blueAccent,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              hebSuff == "" ? 'Restored successfully!' : '!שוחזר בהצלחה',
              textAlign: hebSuff == "" ? TextAlign.left : TextAlign.right,)));
      },
    );

    Widget cancelButton = FlatButton(
      child: Text(
        hebSuff == "" ? "Cancel" : "ביטול",
        style: TextStyle(color: Colors.blueAccent,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: hebSuff == ""
          ? Text("Do you want to restore this dish? ")
          : Text("בלחיצה על אישור המנה תשוחזר",
        textAlign: TextAlign.right,),
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAddDishDialog(BuildContext context, String hebSuff) {
    Widget cancelButton = FlatButton(
      child: Text(
        hebSuff == "" ? "Cancel" : "ביטול",
        style: TextStyle(color: Colors.blueAccent,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(hebSuff == "" ? "Restore dish" : "שחזור מנה",
        textAlign: hebSuff == "" ? TextAlign.left : TextAlign.right,),
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      content: Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 5.5,
        child: Column(
          children: [
            Text(hebSuff == "" ?
            "Choose the dish you want to make visible"
                : "בחר איזו מנה לשחזר"),
            Center(
                child: Container(
                    height: 55.0,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: List<Widget>.generate(
                          2, (int i) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ChoiceChip(
                            label: Text(hebSuff == "" ? i == 0
                                ? 'French fries'
                                : 'Zigzag french fries' : i == 0
                                ? 'ציפס רגיל'
                                : 'ציפס זיגזג',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            selected: false,
                            onSelected: (_) {
                              Navigator.pop(context);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(hebSuff == ""
                                    ? 'Restored successfully!'
                                    : '!שוחזר בהצלחה',
                                  textAlign: hebSuff == ""
                                      ? TextAlign.left
                                      : TextAlign.right,),
                              )
                              );
                            },
                          ),
                        );
                      }
                      ),
                    )
                )
            )
          ],
        ),
      ),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAddFavoriteDialog(BuildContext context, String hebSuff) {
    Widget okButton = FlatButton(
      child: Text(
        hebSuff == "" ? "Add" : "הוסף",
        style: TextStyle(color: Colors.blueAccent,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(hebSuff == ""
                ? 'Added to favorites successfully!'
                : '!נוסף למועדפים בהצלחה',
              textAlign: hebSuff == "" ? TextAlign.left : TextAlign.right,)));
      },
    );

    Widget cancelButton = FlatButton(
      child: Text(
        hebSuff == "" ? "Cancel" : "ביטול",
        style: TextStyle(color: Colors.blueAccent,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: hebSuff == ""
          ? Text("Do you want to add this dish to favorites? ")
          : Text("מנה זו תתווסף למועדפים",
        textAlign: TextAlign.right,),
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showRemoveFavoriteDialog(BuildContext context, String hebSuff) {
    Widget okButton = FlatButton(
      child: Text(
        hebSuff == "" ? "Remove" : "הסר",
        style: TextStyle(color: Colors.blueAccent,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(hebSuff == ""
                ? 'Removed from favorites successfully!'
                : '!הוסר ממעודפים בהצלחה',
              textAlign: hebSuff == "" ? TextAlign.left : TextAlign.right,)));
      },
    );

    Widget cancelButton = FlatButton(
      child: Text(
        hebSuff == "" ? "Cancel" : "ביטול",
        style: TextStyle(color: Colors.blueAccent,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: hebSuff == "" ? Text(
          "Do you want to remove this dish from favorites? ") : Text(
        "מנה זו תוסר ממועדפים",
        textAlign: TextAlign.right,),
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class EditMessageDialog extends StatefulWidget{
  final String hebSuff;
  final List<String> messages;
  final List<String> messagesHE;

  const EditMessageDialog({Key key, this.hebSuff, this.messages, this.messagesHE}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditMessageDialogState();
  }

}

class EditMessageDialogState extends State<EditMessageDialog>{
  TextEditingController firstMessage;
  TextEditingController firstMessageHE;
  TextEditingController secondMessage;
  TextEditingController secondMessageHE;

  @override
  void initState() {
    firstMessage = new TextEditingController(text: widget.messages[0]);
    secondMessage = new TextEditingController(text: widget.messages[1]);
    firstMessageHE = new TextEditingController(text: widget.messagesHE[0]);
    secondMessageHE = new TextEditingController(text: widget.messagesHE[1]);
    super.initState();
  }

  Widget rowDesigner(String fieldName, String fieldNameHE){
    if (widget.hebSuff == "")
      return Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(fieldName),
              Expanded(
                child: FlatButton(
                  child: Icon(Icons.save,
                    size: 18,),
                  onPressed: (){
//                  setState((){
//                    this._text = _c.text;
//                  });
//                  Navigator.pop(context);
                  },
                ),
              )
            ],
          )
      );
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          FlatButton(
            child: Icon(Icons.save,
              size: 18,),
            onPressed: (){
//                setState((){
//                  this._text = _c.text;
//                });
//                Navigator.pop(context);
            },
          ),
          Expanded( child: Text(
              fieldNameHE),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.hebSuff == ""?
        Text("Messages editing") :
          Text("עריכת הודעות",
          textAlign: TextAlign.right,),
        shape:
    RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  rowDesigner("First message hebrew:", ":הודעה ראשונה בעברית"),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: firstMessageHE,
                          ),
                        ),
                      ],
                    ),
                  ),
                  rowDesigner("First message english:", ":הודעה ראשונה באנגלית"),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: firstMessage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  rowDesigner("Second message hebrew:", ":הודעה שנייה בעברית"),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: secondMessageHE,
                          ),
                        ),
                      ],
                    ),
                  ),
                  rowDesigner("Second message english:", ":הודעה שנייה באנגלית"),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: secondMessage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
            FlatButton(
              child: Text(
                widget.hebSuff == "" ? "Return" : "חזרה",
                style: TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        )
      ),
    );
  }

}

class editDishDialog extends StatefulWidget {
  final String hebSuff;
  final AsyncSnapshot snapshot;
  final int index;

  const editDishDialog({Key key, this.hebSuff, this.snapshot, this.index}) : super(key: key);

  @override
  _editDishDialogState createState() => new _editDishDialogState();
}

class _editDishDialogState extends State<editDishDialog> {
  TextEditingController nameHEController;
  TextEditingController nameController;
  TextEditingController ingredientsHEController;
  TextEditingController ingredientsController;
  TextEditingController priceController;

  @override
  initState(){
    nameHEController = new TextEditingController(text: widget.snapshot.data.documents[widget.index]["nameHE"]);
    nameController = new TextEditingController(text: widget.snapshot.data.documents[widget.index]["name"]);
    ingredientsHEController = new TextEditingController(text: widget.snapshot.data.documents[widget.index]["ingredientsHE"]);
    ingredientsController = new TextEditingController(text: widget.snapshot.data.documents[widget.index]["ingredients"]);
    priceController = new TextEditingController(text: widget.snapshot.data.documents[widget.index]["price"]);
    super.initState();
  }

  Widget photoRow(){
    if (widget.hebSuff == "") {
      return Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Update image:",
              textAlign: TextAlign.left,),
            ],
          )
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(':עדכן תמונה',
            textAlign: TextAlign.right,),
          )
        ],
      ),
    );
  }

  Widget rowDesigner(String fieldName, String fieldNameHE){
    if (widget.hebSuff == "") {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(fieldName),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Icon(Icons.save,
                    size: 18,),
                  onPressed: (){
//                  setState((){
//                    this._text = _c.text;
//                  });
//                  Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        )
      );
    }
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            FlatButton(
              child: Icon(Icons.save,
                size: 18,),
              onPressed: (){
//                setState((){
//                  this._text = _c.text;
//                });
//                Navigator.pop(context);
              },
            ),
            Expanded( child: Text(
                fieldNameHE,
            textAlign: TextAlign.right,),
            )
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.hebSuff == "" ?
      Text("Dish editing") : Text(
        "מלא/י שדות רצויים",
        textAlign: TextAlign.right,),
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
              content: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                        photoRow(),
                          ImageCapture(),
                        rowDesigner('Hebrew dish name:', ':שם המנה בעברית'),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: nameHEController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        rowDesigner('Hebrew ingredients:', ':מרכיבי המנה בעברית'),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: ingredientsHEController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        rowDesigner('English dish name:', ':שם המנה באנגלית'),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: nameController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        rowDesigner('English ingredients:', ':מרכיבי המנה באנגלית'),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: ingredientsController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        rowDesigner('price:', ':מחיר'),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: priceController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ]
                      ),
                    ),
                  FlatButton(
                    child: Text(
                      widget.hebSuff == "" ? "Return" : "חזרה",
                      style: TextStyle(color: Colors.blueAccent,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                  ],
                ),
              )
    );
  }
}

class ImageCapture extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ImageCaptureState();
  }
}

class ImageCaptureState extends State<ImageCapture>{
  Image imageFile;

  Future<void> pickImage(ImageSource source) async {
    Image selected = await ImagePickerWeb.getImage(outputType: ImageType.widget);
    setState(() {
      imageFile = selected;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.add_a_photo,
            size: 32,),
            onPressed: () => pickImage(ImageSource.gallery),
          ),
          SizedBox(height: 15,),
          if (imageFile != null)
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: (){},
                  ),
                  ClipRRect(
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                          height: 180,
                          width: 180,
                          child: imageFile)),
                ],
              ),
            )
        ],
      ),
    );
  }

}