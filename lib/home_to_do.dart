import 'package:flutter/material.dart';

class ToDOHome extends StatefulWidget {
  const ToDOHome({super.key});

  @override
  State<ToDOHome> createState() => _ToDOHomeState();
}

class _ToDOHomeState extends State<ToDOHome> {
  final _formKey = GlobalKey<FormState>();
  final todoController = TextEditingController();
  late Color toogleColor = const Color.fromARGB(255, 151, 54, 54);
  List<Map<String, dynamic>> taskList = [];
  int flag=0;
  int editIndex=-1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('To Do List',
              style: TextStyle(
                color: Colors.white
              ),
              ),
              IconButton(
                color: Colors.red,
                  onPressed: () {
                    clearList();
                  },
                  icon: const Icon(Icons.delete,
                  color: Colors.white,))
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Task Cannot be empty!';
                          } else {
                            return null;
                          }
                        },
                        controller: todoController,
                        decoration: InputDecoration(
                          labelText: "Enter Task",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 4),
                          //color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 36,
                          icon: Icon(
                            flag==0?Icons.add:Icons.check,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              flag==0?addList():editSave(editIndex);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          
                          onLongPress: () {
                            changeStatus(index, taskList[index]['Title'],
                                taskList[index]['Status']);
                          },
                          title: Text(taskList[index]['Title'],
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          subtitle: Row(
                            children: [
                              taskList[index]['Status'] == '0'
                                  ? const Text('Not Completed',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold

                                  ),
                                  )
                                  : const Text('Completed',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold
                                  ),),
                              const SizedBox(
                                width: 180,
                              ),
                              IconButton(
                                  onPressed: () {
                                    editSelected(index, taskList[index]['Status']);
                                  },
                                  icon: const Icon(Icons.edit,
                                  color: Colors.blue,)),
                              IconButton(
                                  onPressed: () {
                                    deleteSelected(index);
                                  },
                                  icon: const Icon(Icons.delete,
                                  color: Colors.red,))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: taskList.length)),
            ],
          ),
        ));
  }

  void addList() {
    
    Map<String, dynamic> tempList = {
      'Title': todoController.text,
      'Status': '0'
    };
    setState(() {
      taskList.add(tempList);
      todoController.text = '';
      
    });
    flag==0?1:0;
    //print(taskList);
  }

  void clearList() {
    if (taskList.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
           
            title: const Text('To Do List Says..'),
            content: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Image(
                        image: AssetImage('assets/emptylist.webp'),
                        height: 200,
                         )
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ToDOHome()));
                },
                child: const Text('Go Back'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        taskList.clear();
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('To Do List Says..'),
            content: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Item Deleted!',
              style:TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 15
              ) ,
              )
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ToDOHome()));
                },
                child: const Text('Go Back'),
              ),
            ],
          );
        },
      );

      });
    }
  }

  void deleteSelected(int item) {
    setState(() {
      taskList.removeAt(item);
    });
  }

  void changeStatus(int index, String title, String status) {
    setState(() {
      taskList[index] = {
        'Title': title.toString(),
        'Status': status == '0' ? '1' : '0'
      };
    });
  }
  void editSelected(int index,String status)
  {
   
    
    setState(() {
      todoController.text=taskList[index]['Title'];
      editIndex=index;
      flag=1;
    });
  }
  void editSave(int index){
    setState(() {
      taskList[index] = {
        'Title': todoController.text.toString(),
        'Status': taskList[index]['Status']
      };
      flag=0;
      todoController.text='';
    });
  }
}
