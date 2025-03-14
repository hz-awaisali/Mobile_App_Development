// main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/calculator': (context) => const CalculatorPage(),
        '/gradebook': (context) => const GradeBookPage(),
        '/myname': (context) => const JustName(),
        '/button': (context) => const DemoButton(),
        '/simple-form': (context) => const MyForm(),
        '/user-form': (context) => const UserFormScreen(),
        '/user-record': (context) => const UserRecordsScreen(),
      },
    );
  }
}

// HomePage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'About BGNU',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Baba Guru Nanak University (BGNU) is a Public sector university located in District Nankana Sahib, in the Punjab region of Pakistan. It plans to facilitate between 10,000 to 15,000 students from all over the world at the university. The foundation stone of the university was laid on October 28, 2019 ahead of 550th of Guru Nanak Gurpurab by the Prime Minister of Pakistan. On July, 02, 2020 Government of Punjab has formally passed Baba Guru Nanak University Nankana Sahib Act 2020 (X of 2020).'
                ' The plan behind the establishment of this university to be modeled along the lines of world renowned universities with focus on languages and Punjab Studies offering faculties in "Medicine", "Pharmacy", "Engineering", "Computer science”, “Languages", "Music" and "Social sciences". The initial cost Rupees 6 billion has already been allocated in the budget for this project to be spent in three phases on construction of Baba Guru Nanak University Nankana Sahib. The development work of Phase-I has already been started by Communication and Works Department of Government of Punjab.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 20),
            Image.asset('assets/images/Awais.png', height: 200),
            SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        color: Colors.blueAccent,
        child: Text(
          '© 2025 BGNU. All rights reserved.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// AppDrawer
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Navigation Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text('Calculator'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/calculator');
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Grade Book'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/gradebook');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('My Name'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/myname');
            },
          ),
          ListTile(
            leading: const Icon(Icons.smart_button),
            title: const Text('Demo Button'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/button');
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_copy_outlined),
            title: const Text('Simple Form'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/simple-form');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('User Form'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/user-form');
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Users Record'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/user-record');
            },
          ),
        ],
      ),
    );
  }
}

// Calculator Page
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();
  String _operation = '+';
  String _result = 'Result will appear here';

  void _calculateResult() {
    double firstNumber;
    double secondNumber;

    try {
      firstNumber = double.parse(_firstNumberController.text);
      secondNumber = double.parse(_secondNumberController.text);
    } catch (e) {
      setState(() {
        _result = 'Please enter valid numbers';
      });
      return;
    }

    setState(() {
      switch (_operation) {
        case '+':
          _result = 'Result: ${firstNumber + secondNumber}';
          break;
        case '-':
          _result = 'Result: ${firstNumber - secondNumber}';
          break;
        case '*':
          _result = 'Result: ${firstNumber * secondNumber}';
          break;
        case '/':
          if (secondNumber == 0) {
            _result = 'Cannot divide by zero';
          } else {
            _result = 'Result: ${firstNumber / secondNumber}';
          }
          break;
        default:
          _result = 'Invalid operation';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                _result,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              controller: _firstNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'First Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _secondNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Second Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _operation,
              decoration: const InputDecoration(
                labelText: 'Operation',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: '+', child: Text('Addition (+)')),
                DropdownMenuItem(value: '-', child: Text('Subtraction (-)')),
                DropdownMenuItem(value: '*', child: Text('Multiplication (*)')),
                DropdownMenuItem(value: '/', child: Text('Division (/)')),
              ],
              onChanged: (value) {
                setState(() {
                  _operation = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateResult,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}

// Grade Book Page
class GradeBookPage extends StatelessWidget {
  const GradeBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the grade book
    final List<Map<String, dynamic>> grades = [
      {'index': 1, 'subject': 'Mathematics', 'marks': 92},
      {'index': 2, 'subject': 'Science', 'marks': 88},
      {'index': 3, 'subject': 'English', 'marks': 85},
      {'index': 4, 'subject': 'History', 'marks': 78},
      {'index': 5, 'subject': 'Computer Science', 'marks': 95},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Grade Book')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Table header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              color: Colors.blue,
              child: const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Index',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Subject Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Marks',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Table rows
            ...grades.map((grade) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        grade['index'].toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        grade['subject'],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        grade['marks'].toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

//Just Name Page
class JustName extends StatelessWidget {
  const JustName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Name")),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Center(child: Text("My Name is Muhammad Awais Ali.")),
      ),
    );
  }
}

//Simple Button
class DemoButton extends StatelessWidget {
  const DemoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple Button")),
      drawer: AppDrawer(),
      body: Center(
        child: ElevatedButton(
          onPressed: () => {},
          child: const Text("Click Here!"),
        ),
      ),
    );
  }
}

//Form Having Input Field and a Button
class MyForm extends StatefulWidget {
  const MyForm({super.key});
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _textController = TextEditingController();
  String _displayText = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _updateText() {
    setState(() {
      _displayText = _textController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Field and Button')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter some text',
                hintText: 'Type here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _updateText, child: Text('Submit')),
            SizedBox(height: 20),
            Text('You entered: $_displayText', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}


// User Model
class User {
  final String name;
  final String mobileNumber;
  final bool isActive;

  User({
    required this.name,
    required this.mobileNumber,
    required this.isActive,
  });

  // Convert a User into a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobileNumber': mobileNumber,
      'isActive': isActive,
    };
  }

  // Create a User from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      mobileNumber: map['mobileNumber'],
      isActive: map['isActive'],
    );
  }

  // Convert to JSON string
  String toJson() => json.encode(toMap());

  // Create a User from a JSON string
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

// User Form Screen
class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  bool _isActive = true;

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      // Create a new User object
      User newUser = User(
        name: _nameController.text,
        mobileNumber: _mobileController.text,
        isActive: _isActive,
      );

      // Get the shared preferences instance
      final prefs = await SharedPreferences.getInstance();
      
      // Get existing users or create an empty list
      List<String> userList = prefs.getStringList('users') ?? [];
      
      // Add the new user to the list
      userList.add(newUser.toJson());
      
      // Save the updated list
      await prefs.setStringList('users', userList);
      
      // Clear the form
      _nameController.clear();
      _mobileController.clear();
      setState(() {
        _isActive = true;
      });
      
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User saved successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Status:'),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('Active'),
                      value: true,
                      groupValue: _isActive,
                      onChanged: (value) {
                        setState(() {
                          _isActive = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('Inactive'),
                      value: false,
                      groupValue: _isActive,
                      onChanged: (value) {
                        setState(() {
                          _isActive = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveUser,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Submit'),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserRecordsScreen()),
          );
        },
        child: const Icon(Icons.list),
        tooltip: 'View Records',
      ),
    );
  }
}

// User Records Screen
class UserRecordsScreen extends StatefulWidget {
  const UserRecordsScreen({super.key});

  @override
  _UserRecordsScreenState createState() => _UserRecordsScreenState();
}

class _UserRecordsScreenState extends State<UserRecordsScreen> {
  List<User> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> userList = prefs.getStringList('users') ?? [];
    
    setState(() {
      _users = userList.map((userString) => User.fromJson(userString)).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Records'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _users.isEmpty
              ? const Center(child: Text('No users found'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final user = _users[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: user.isActive ? Colors.green : Colors.red,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Mobile: ${user.mobileNumber}',
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 16.0,
                            right: 16.0,
                            child: Icon(
                              user.isActive ? Icons.check_circle : Icons.cancel,
                              color: user.isActive ? Colors.green : Colors.red,
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}