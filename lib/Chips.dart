import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imenumanagedemo/Dialogs.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';



class Chips extends StatefulWidget {
  final List<String> typeListRender;
  final ItemScrollController itemScrollController;
  final String hebSuff;

  const Chips({Key key, this.typeListRender, this.itemScrollController, this.hebSuff}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChipsState();
}

class _ChipsState extends State<Chips> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 55.0,
          child:
              ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: List<Widget>.generate(
              widget.typeListRender.length+2,
              (int index) {
                if (index == widget.typeListRender.length+1)
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ChoiceChip(
                      selectedColor: Colors.black,
                      label: Text(
                        widget.hebSuff == "" ? "Hidden dishes" : "מנות מוסתרות",
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: _value == index ? Colors.white : Colors.black),
                      ),
                      selected: _value == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = index;
                          widget.itemScrollController.scrollTo(index: index-1, duration: Duration(seconds: 1));
                        });
                      },
                    ),
                  );
                if (index == 0)
                  return IconButton(
                    icon: Icon(
                      Icons.add_circle
                    ),
                    onPressed: (){
                      Dialogs().showAddTypeDialog(context, widget.hebSuff);
                    },
                  );
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ChoiceChip(
                    selectedColor: Colors.black,
                    label: Text(
                        widget.typeListRender[index-1],
                            style: TextStyle(fontWeight: FontWeight.bold,
                            color: _value == index ? Colors.white : Colors.black),
                    ),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = index;
                        widget.itemScrollController.scrollTo(index: index-1, duration: Duration(seconds: 1));
                      });
                    },
                  ),
                );
              },
            ).toList(),
          )),
    );
  }
}
