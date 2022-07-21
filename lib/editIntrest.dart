import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/trivyTech.dart';

class EditIntreste extends StatefulWidget {
  @override
  _EditIntresteState createState() => _EditIntresteState();
}

class _EditIntresteState extends State<EditIntreste> {
  bool _isSelected = false;

  List<String> _intrests_categories = [
    'Adventure',
    'Art & Crafts',
    'Backpacking',
    'Beaches',
    'Maountains',
    'Historicla',
    'Natural Trails',
    'Romantic',
    'Biking',
    'Pub Crawling',
    'Shopping',
    'Culture',
    'Home Stay',
    'Trekking',
    'Waterfalls',
    'Diving',
    'Caving',
    'Offroading',
    'Events & Exhibitions',
    'Food',
    'Cities',
    'Heritage Walks',
    'Jungle safaris',
    'Cycle Tours',
    'Water Sports',
    'Winters Sports',
    'Pilgrimage',
    'Religious',
    'Meet ups',
    'Health & fitness',
    'Sustainable Liveing'
  ];
  @override
  void dispose() {
    updateInterest();
    super.dispose();
  }

  @override
  void initState() {
    getSelectedList();
    super.initState();
  }

  getSelectedList() async {
    setState(() {
      FirebaseFirestore.instance
          .collection("users")
          .doc(ServiceApp.auth.currentUser.uid)
          .get()
          .then((dataSnapshot) async {
        try {
          ServiceApp.selectedChoices = await dataSnapshot.get("interests");
        } catch (e) {
          ServiceApp.selectedChoices = [];
          print(e);
        }
      });
    });
  }

  updateInterest() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(ServiceApp.auth.currentUser.uid)
        .set({
      'interests': ServiceApp.selectedChoices,
    }, SetOptions(merge: true)).then((_) {
      print("success!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Intrest"),
      ),
      body: Column(
        children: [
          MultiSelectChip(_intrests_categories),
        ],
      ),
    );
  }

  Widget inputeChip() {
    // this widge's choips are as we rquired
    return Wrap(
      spacing: 2.0,
      runSpacing: 0.0,
      children: List.generate(_intrests_categories.length, (int index) {
        return InputChip(
          label: Text(_intrests_categories[index]),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColor.c2, width: 1)
              // borderRadius: BorderRadius.all(),
              ),
          selected: _isSelected,
          selectedColor: AppColor.c2,
          onSelected: (bool selected) {
            print(selected);
            setState(() {
              _isSelected = selected;
            });
          },
        );
      }),
    );
  }
}
// import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged; // +added
  MultiSelectChip(this.reportList, {this.onSelectionChanged} // +added
      );

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  //List<String> selectedChoices = List();
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: ServiceApp.selectedChoices.contains(item),
          shadowColor: AppColor.c4,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColor.c2, width: 1)
              // borderRadius: BorderRadius.all(),
              ),
          onSelected: (selected) {
            setState(() {
              print(ServiceApp.selectedChoices);
              ServiceApp.selectedChoices.contains(item)
                  ? ServiceApp.selectedChoices.remove(item)
                  : ServiceApp.selectedChoices.add(item);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

//import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  ValueNotifier<int> _counter;

  @override
  void initState() {
    _counter = ValueNotifier<int>(0);
    super.initState();
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: _counter,
          builder: (context, value, child) => Text(
            'You had tapped $value.',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _counter.value++,
      ),
    );
  }
}
