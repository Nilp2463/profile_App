import 'package:flutter/material.dart';

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

  List<Map<String, String>> projects = [
    {
      "title": "Fitness Tracker",
      "description": "Track workout and calories daily.",
    },
    {
      "title": "Travel Booking UI",
      "description": "Modern travel booking application UI.",
    },
    {
      "title": "Notes App",
      "description": "Simple notes app using Flutter.",
    },
  ];

  final List<String> skills = [
    "Flutter",
    "Dart",
    "Firebase",
    "JavaScript",
    "HTML",
    "CSS",
    "GitHub",
  ];

  void addProject(String title) {
    setState(() {
      projects.add({
        "title": title,
        "description": "New Flutter project added.",
      });
    });
  }

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
              onPressed: () {
                Navigator.pop(context);
              },
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

  Widget buildProfileScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4F46E5),
                  Color(0xFF06B6D4),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black87,
                  child: Icon(
                    Icons.person,
                    size: 55,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Neel Patel",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Flutter Developer",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    ProfileStat(number: "10+", label: "Projects"),
                    ProfileStat(number: "7", label: "Skills"),
                    ProfileStat(number: "1", label: "Internship"),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          buildInfoCard(
            Icons.email,
            "neelpatel@gmail.com",
          ),

          buildInfoCard(
            Icons.phone,
            "+91 9876543210",
          ),

          buildInfoCard(
            Icons.location_on,
            "Ahmedabad, Gujarat",
          ),
        ],
      ),
    );
  }

  Widget buildInfoCard(IconData icon, String text) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo.shade100,
          child: Icon(
            icon,
            color: Colors.indigo,
          ),
        ),
        title: Text(text),
      ),
    );
  }

  Widget buildProjectsScreen() {
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
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 10,
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.laptop_mac,
                  color: Colors.indigo,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projects[index]["title"]!,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      projects[index]["description"]!,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildSkillsScreen() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Technical Skills",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: skills.map((skill) {
              return Chip(
                label: Text(skill),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                backgroundColor: Colors.indigo.shade100,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      buildProfileScreen(),
      buildProjectsScreen(),
      buildSkillsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Developer Portfolio",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: screens[currentIndex],

      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddProjectDialog,
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          NavigationDestination(
            icon: Icon(Icons.work),
            label: "Projects",
          ),
          NavigationDestination(
            icon: Icon(Icons.code),
            label: "Skills",
          ),
        ],
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String number;
  final String label;

  const ProfileStat({
    super.key,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}