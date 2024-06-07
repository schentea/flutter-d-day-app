import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  final void Function(bool) changeTheme;

  //생성자 (constructor)
  const Home({
    super.key, 
    required this.changeTheme,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDark = false;
  bool isEditing = false;
  String title = '수능';
  DateTime setDate = DateTime.now();
  // 시간을 제외한 날짜
  DateTime onlyDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  late TextEditingController _controller;
  @override
  void initState() {
    _controller =TextEditingController(text :title);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int timeDiff =onlyDate.difference(setDate).inDays;
    return Scaffold(
      appBar: AppBar(
        title: Text("D-Day"),
        actions: 
        [
          IconButton(onPressed: (){
            setState(() {
              isDark= !isDark;
            });
            widget.changeTheme(isDark);
          }, 
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode)),
          IconButton(onPressed: (){
            setState(() {
              isEditing = !isEditing;
            });
          }, icon: Icon(isEditing ? Icons.check : Icons.edit)),
        ],
      ),
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(!isEditing)
            Text("$title"),
            if(isEditing)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: "제목을 입력해주세요."),
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    title = value;  
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${timeDiff > 0 ? timeDiff.toString().padLeft(timeDiff.toString().length+1,'+') : timeDiff}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                Text("일째"),
              ],
            ),
            TextButton(onPressed: () async{
              // optional data
              final date = await showDatePicker(
                context: context, 
                firstDate: DateTime(2024,1,1), 
                lastDate: DateTime(2024,12,31));
                setState(() {
                  // 앱이 안터짐
                  setDate = date ?? setDate;
                  // 강제적 => 앱이 터질수도 있음
                  // setDate = date!;
                });
            }, 
            child: Text("${DateFormat('yyyy-MM-dd').format(setDate)}"))
          ],
        ),
      ),
    );
  }
}