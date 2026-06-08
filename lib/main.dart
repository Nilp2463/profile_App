// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const DeveloperPortfolioApp());
// }
//
// class DeveloperPortfolioApp extends StatelessWidget {
//   const DeveloperPortfolioApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Developer Portfolio',
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: Colors.indigo,
//         scaffoldBackgroundColor: const Color(0xFFF5F7FB),
//       ),
//       home: const PortfolioHomePage(),
//     );
//   }
// }
//
// class PortfolioHomePage extends StatefulWidget {
//   const PortfolioHomePage({super.key});
//
//   @override
//   State<PortfolioHomePage> createState() => _PortfolioHomePageState();
// }
//
// class _PortfolioHomePageState extends State<PortfolioHomePage> {
//   int currentIndex = 0;
//
//   List<Map<String, String>> projects = [];
//
//   final List<String> skills = [
//     "Flutter",
//     "Dart",
//     "Firebase",
//     "JavaScript",
//     "HTML",
//     "CSS",
//     "GitHub",
//   ];
//
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadProjects();
//   }
//
//   Future<void> loadProjects() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getString("projects");
//
//     if (data != null) {
//       projects = List<Map<String, String>>.from(
//         jsonDecode(data).map((item) => Map<String, String>.from(item)),
//       );
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   Future<void> saveProjects() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString("projects", jsonEncode(projects));
//   }
//
//   void addProject(String title) {
//     setState(() {
//       projects.add({
//         "title": title,
//         "description": "Saved locally (Task 2)",
//       });
//     });
//
//     saveProjects();
//   }
//
//   void showAddProjectDialog() {
//     TextEditingController controller = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Add New Project"),
//           content: TextField(
//             controller: controller,
//             decoration: const InputDecoration(
//               hintText: "Enter project name",
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (controller.text.isNotEmpty) {
//                   addProject(controller.text);
//                 }
//                 Navigator.pop(context);
//               },
//               child: const Text("Add"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget buildProfileScreen() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(25),
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
//               ),
//               borderRadius: BorderRadius.all(Radius.circular(30)),
//             ),
//             child: Column(
//               children: const [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundColor: Colors.black87,
//                   child: Icon(Icons.person, size: 55, color: Colors.white),
//                 ),
//                 SizedBox(height: 15),
//                 Text(
//                   "Neel Patel",
//                   style: TextStyle(
//                     fontSize: 28,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   "Flutter Developer",
//                   style: TextStyle(color: Colors.white70, fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 25),
//
//           buildInfoCard(Icons.email, "neel@gmail.com"),
//           buildInfoCard(Icons.phone, "+91 9999999999"),
//           buildInfoCard(Icons.location_on, "Ahmedabad"),
//         ],
//       ),
//     );
//   }
//
//   Widget buildInfoCard(IconData icon, String text) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 15),
//       child: ListTile(
//         leading: Icon(icon),
//         title: Text(text),
//       ),
//     );
//   }
//
//   Widget buildProjectsScreen() {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     if (projects.isEmpty) {
//       return const Center(child: Text("No projects added yet"));
//     }
//
//     return ListView.builder(
//       padding: const EdgeInsets.all(15),
//       itemCount: projects.length,
//       itemBuilder: (context, index) {
//         return Container(
//           margin: const EdgeInsets.only(bottom: 15),
//           padding: const EdgeInsets.all(18),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(25),
//             boxShadow: const [
//               BoxShadow(color: Colors.black12, blurRadius: 10),
//             ],
//           ),
//           child: ListTile(
//             leading: const Icon(Icons.work, color: Colors.indigo),
//             title: Text(projects[index]["title"]!),
//             subtitle: Text(projects[index]["description"]!),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget buildSkillsScreen() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Wrap(
//         spacing: 12,
//         runSpacing: 12,
//         children: skills.map((skill) => Chip(label: Text(skill))).toList(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screens = [
//       buildProfileScreen(),
//       buildProjectsScreen(),
//       buildSkillsScreen(),
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Developer Portfolio"),
//         centerTitle: true,
//       ),
//       body: screens[currentIndex],
//       floatingActionButton: FloatingActionButton(
//         onPressed: showAddProjectDialog,
//         child: const Icon(Icons.add),
//       ),
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: currentIndex,
//         onDestinationSelected: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         destinations: const [
//           NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
//           NavigationDestination(icon: Icon(Icons.work), label: "Projects"),
//           NavigationDestination(icon: Icon(Icons.code), label: "Skills"),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const DeveloperPortfolioApp());
}

class DeveloperPortfolioApp extends StatelessWidget {
  const DeveloperPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Developer Portfolio',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  int currentIndex = 0;

  // ✅ ONLY PROJECTS ARE DYNAMIC (NOT PROFILE)
  List<Map<String, String>> projects = [];

  final List<String> skills = [
    "Flutter",
    "Dart",
    "Firebase",
    "JavaScript",
    "HTML",
    "CSS",
    "GitHub",
  ];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProjects();
  }

  // ================= LOAD ONLY PROJECTS =================
  Future<void> loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("projects");

    if (data != null) {
      final decoded = jsonDecode(data);

      projects = List<Map<String, String>>.from(
        decoded.map((item) => Map<String, String>.from(item)),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  // ================= SAVE ONLY PROJECTS =================
  Future<void> saveProjects() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("projects", jsonEncode(projects));
  }

  // ================= ADD PROJECT =================
  void addProject(String title) {
    setState(() {
      projects.add({
        "title": title,
        "description": "Saved locally",
      });
    });

    saveProjects();
  }

  // ================= DELETE PROJECT =================
  void deleteProject(int index) {
    setState(() {
      projects.removeAt(index);
    });

    saveProjects();
  }

  // ================= UI DIALOG =================
  void showAddProjectDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Project"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Enter project name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  addProject(controller.text);
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  // ================= PROFILE (STATIC - NEVER TOUCH) =================
  Widget buildProfileScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
              ),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black87,
                  child: Icon(Icons.person, size: 55, color: Colors.white),
                ),
                SizedBox(height: 15),
                Text(
                  "Neel Patel",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Flutter Developer",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          buildInfoCard(Icons.email, "neel@gmail.com"),
          buildInfoCard(Icons.phone, "+91 9999999999"),
          buildInfoCard(Icons.location_on, "Ahmedabad"),
        ],
      ),
    );
  }

  Widget buildInfoCard(IconData icon, String text) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
    );
  }

  // ================= PROJECTS =================
  Widget buildProjectsScreen() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          child: ListTile(
            leading: const Icon(Icons.work, color: Colors.indigo),
            title: Text(projects[index]["title"]!),
            subtitle: Text(projects[index]["description"]!),

            // ✅ DELETE FIXED (NO PROFILE IMPACT)
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteProject(index),
            ),
          ),
        );
      },
    );
  }

  // ================= SKILLS =================
  Widget buildSkillsScreen() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: skills.map((e) => Chip(label: Text(e))).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      buildProfileScreen(),
      buildProjectsScreen(),
      buildSkillsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer Portfolio"),
        centerTitle: true,
      ),
      body: screens[currentIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: showAddProjectDialog,
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          NavigationDestination(icon: Icon(Icons.work), label: "Projects"),
          NavigationDestination(icon: Icon(Icons.code), label: "Skills"),
        ],
      ),
    );
  }
}