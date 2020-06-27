import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imenumanagedemo/Dialogs.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuList extends StatefulWidget {
  final List<String> typeList;
  final List<String> typeListHE;
  final String hebSuff;
  final ItemScrollController itemScrollController;
  final List<String> message;
  final List<String> messageHE;

  const MenuList(
      {Key key,
      this.typeList,
      this.itemScrollController,
      this.typeListHE,
      this.hebSuff,
      this.message,
      this.messageHE})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MenuListState();
  }
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: ScrollablePositionedList.builder(
          physics: ScrollPhysics(),
          itemCount: widget.typeList.length+1,
          itemScrollController: widget.itemScrollController,
          itemBuilder: (context, i) {
            if (i == widget.typeList.length)
              return Column(
                children: [
                  ExpansionTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(widget.hebSuff == "" ?
                            "Hidden dishes" : "מנות מוסתרות",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: widget.hebSuff == "" ? TextAlign.left : TextAlign.right,),
                        ),
                      ],
                    ),
                    children: [
                      _hiddenTile(hebSuff: widget.hebSuff,name: 'Zigzag french fries',nameHE: 'ציפס זיגזג',),
                      _hiddenTile(hebSuff: widget.hebSuff,name: 'French fries',nameHE: 'ציפס רגיל',),
                    ],
                  ),
                           Divider(
                            thickness: 3,
                            color: Colors.black,
                          ),
                ],
              );
            final String type = widget.typeList[i];
            final String typeHE = widget.typeListHE[i];
            return Column(
              children: [
                if (i == 0 && widget.message != null && widget.message != [])
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: messageBoard(
                      hebSuff: widget.hebSuff,
                      message: widget.message,
                      messageHE: widget.messageHE,
                    ),
                  ),
                typeHeader(
                  hebSuff: widget.hebSuff,
                  type: type,
                  typeHE: typeHE,
                  index: i,
                ),
                Divider(
                  thickness: 3,
                  color: Colors.black,
                ),
              ],
            );
          }),
    );
  }
}

class TileGroupState extends StatefulWidget {
  final String type;
  final String hebSuff;
  final int index;

  const TileGroupState({Key key, this.type, this.hebSuff, this.index}) : super(key: key);

  @override
  _TileGroupStateState createState() => _TileGroupStateState();
}

class _TileGroupStateState extends State<TileGroupState> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(this.widget.type.toLowerCase())
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasData == null) {
            return Text('');
          }
          return Container(
            height: widget.index == 0 ? 6.00*65.00 : 7.00*65.00,
            child: ReorderableListView(
                    onReorder: (oldIndex, newIndex){
                    },
                    children:
                        List<Widget>.generate(snapshot.data.documents.length, (index) {
                      String imageUrl = snapshot.data.documents[index]["imageUrl"];
                      return Padding(
                        key: ValueKey(index),
                          padding: const EdgeInsets.all(2),
                          child: dishTile(
                            snapshot: snapshot,
                            hebSuff: widget.hebSuff,
                            index: index,
                          )
                      );
                    }).toList(),
            ),
          );
        });
  }
}


class _hiddenTile extends StatefulWidget{
  final String hebSuff;
  final String name;
  final String nameHE;

  const _hiddenTile({Key key, this.hebSuff, this.name, this.nameHE}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __hiddenTileState();
  }
}

class __hiddenTileState extends State<_hiddenTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (_){
        setState(() {
          expanded = !expanded;
        });
      },
      title: Text( widget.hebSuff == "" ? widget.name : widget.nameHE,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.add,
            color: Colors.black,),
            onPressed: (){Dialogs().showRestoreDishDialog(context, widget.hebSuff);},
          ),
          expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more)
        ],
      ),
      children: [
        Column(
          children: [
            ListTile(
              trailing: Text('22₪'),
            ),
            SizedBox(height: 10)
          ],
        ),
      ],
    );
  }
}

class dishTile extends StatefulWidget{
  final AsyncSnapshot snapshot;
  final int index;
  final String hebSuff;

  const dishTile({Key key, this.snapshot, this.index, this.hebSuff}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _dishTileState();
  }
}

class _dishTileState extends State<dishTile> with SingleTickerProviderStateMixin{
  AnimationController tileController;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    tileController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
      reverseDuration: Duration(milliseconds: 900),
    );}

  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.snapshot.data.documents[widget.index]["imageUrl"];
    return ExpansionTile(
      onExpansionChanged: (_) {
        if (!expanded){
          tileController.forward();
          Future.delayed(const Duration(milliseconds: 1000), () {
          tileController.reverse();
        });
        }
          setState(() {
            expanded = !expanded;
          });
      },
      title: Text(
          widget.snapshot.data.documents[widget.index]
          ["name" + this.widget.hebSuff],
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.index%3!=0 ?
          IconButton(
            icon: (Icon(Icons.star_border)),
                onPressed: (){Dialogs().showAddFavoriteDialog(context, widget.hebSuff);},
          ) :
              IconButton(
              icon: Icon(Icons.star, color: Colors.yellow,),
    onPressed: (){Dialogs().showRemoveFavoriteDialog(context, widget.hebSuff);},
              ),
          IconButton(
            icon: Icon(Icons.edit,
                color: Colors.black),
//            onPressed: (){Dialogs().showEditDishDialog(context, widget.hebSuff);},
          onPressed: (){
              showDialog(context: context, child: editDishDialog(hebSuff: widget.hebSuff, snapshot: widget.snapshot,index: widget.index));
          },
          ),
          IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.list_view,
              color: Colors.black,
              progress: tileController,
            ),
            onPressed: (){Dialogs().showNavigationDialog(context, widget.hebSuff);},
          ),
          expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more)
        ],
      ),
      children: [
        Column(
          children: [
            ListTile(
              subtitle: Text(widget.snapshot.data.documents[widget.index]
                              ["ingredients" + this.widget.hebSuff],
            ),
            trailing: Text(widget.snapshot.data.documents[widget.index]["price"]),
            ),
            if (imageUrl != "")
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                ),
              ),
            SizedBox(height: 10)
          ],
        ),
      ],
    );
  }
}

class messageBoard extends StatelessWidget {
  final String hebSuff;
  final List<String> message;
  final List<String> messageHE;

  const messageBoard({Key key, this.hebSuff, this.message, this.messageHE}) : super(key: key);

  Widget messages(){
    return Align(
      alignment: Alignment.centerRight,
      child: ListView(
        shrinkWrap: true,
        children: List<Widget>.generate(message.length,
                (index) {
              return hebSuff == ""
                  ? Text("   " +message[index])
                  : Align(
                  alignment: Alignment.bottomRight,
                  child: Text(messageHE[index]+"   "));
            }).toList(),
      ),
    );
  }

  Widget editIcon(BuildContext context){
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(
          Icons.edit,
        ),
        onPressed: () {
          showDialog(context: context, child:EditMessageDialog(hebSuff: hebSuff, messages: message, messagesHE: messageHE,));},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hebSuff == "")
      return
        Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: messages()),
          editIcon(context),
        ],
      );
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        editIcon(context),
        Expanded(child: messages(),)
      ],
    );
  }
}

class typeHeader extends StatelessWidget {
  final String type;
  final String typeHE;
  final String hebSuff;
  final int index;

  const typeHeader({Key key, this.hebSuff, this.type, this.typeHE, this.index})
      : super(key: key);

  Widget title() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(hebSuff == "" ? type : typeHE,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Widget deleteIcon(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(
          Icons.delete,
        ),
        onPressed: () {
          Dialogs().showDeleteTypeDialog(context, hebSuff);
        },
      ),
    );
  }

  Widget addIcon(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(
          Icons.add,
        ),
        onPressed: () {Dialogs().showAddDishDialog(context, hebSuff);},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hebSuff == "")
      return ExpansionTile(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title(),
            Expanded(child:
            addIcon(context)),
            deleteIcon(context),
          ],
        ),
        children: [
          TileGroupState(type: type, hebSuff: hebSuff, index: index,)
        ],
      );
    return ExpansionTile(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          deleteIcon(context),
          addIcon(context),
          Expanded(child: title()),
        ],
      ),
      children: [
        TileGroupState(type: type, hebSuff: hebSuff, index: index,)
      ],
    );
  }
}
