import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

final List<SpendingLog> _allLogList = [
  SpendingLog(id: 'UP0001', name: 'Ram', gender: 'M'),
  SpendingLog(id: 'UP0002', name: 'Shyam', gender: 'M'),
  SpendingLog(id: 'UP0003', name: 'Ganshyam', gender: 'M'),
  SpendingLog(id: 'UP0004', name: 'Rani', gender: 'F'),
  SpendingLog(id: 'UP0005', name: 'Suresh', gender: 'M'),
  SpendingLog(id: 'UP0006', name: 'Mukesh', gender: 'M'),
  SpendingLog(id: 'UP0007', name: 'Ranesh', gender: 'M'),
  SpendingLog(id: 'UP0008', name: 'Pooja', gender: 'F'),
  SpendingLog(id: 'UP0009', name: 'Neha', gender: 'F'),
];


  List<SpendingLog> _filteredList = [];

  @override
  void initState() {
    super.initState();
    _filteredList = _allLogList;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _filterLogListBySearchText(String searchText) {
  setState(() {
    _filteredList = _allLogList
        .where((logObj) =>
            logObj.name.toLowerCase().startsWith(searchText.toLowerCase()) ||
            logObj.id.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  });
}


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
              color: const Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(5)),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.search_rounded,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () => FocusScope.of(context).unfocus(),
              ),
              suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    _textController.text = "";
                    _filterLogListBySearchText("");
                  }),
              hintText: 'Search...',
              border: InputBorder.none,
            ),
            onChanged: (value) => _filterLogListBySearchText(value),
            onSubmitted: (value) => _filterLogListBySearchText(value),
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColorDark,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          screenSize.height * 0.05,
          screenSize.height * 0.1,
          screenSize.height * 0.05,
          0,
        ),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: _filteredList.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 10),
          itemBuilder: (BuildContext context, int index) {
            final log = _filteredList[index];
            return Card(
              child: ListTile(
                title: Text(log.name),
                subtitle:Text(log.id),
                
              ),
            );
          },
        ),
      ),
    );
  }
}

// Define the SpendingLog class
class SpendingLog {
  final String id;
  final String name;
  final String gender;

  SpendingLog({
    required this.id,
    required this.name,
    required this.gender,
    
  });
}
