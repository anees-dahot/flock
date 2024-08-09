import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SuggestedFriends extends StatefulWidget {
  static const String routeName = 'add-suggested-friends';
  const SuggestedFriends({super.key});

  @override
  State<SuggestedFriends> createState() => _SuggestedFriendsState();
}

class _SuggestedFriendsState extends State<SuggestedFriends> {
  List<Map<String, dynamic>> people = [
    {
      "name": "John Doe",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "John is a software engineer with over 10 years of experience in web development.",
    },
    {
      "name": "Jane Smith",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Jane is a digital marketer who specializes in social media strategies for startups.",
    },
    {
      "name": "Alice Johnson",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Alice is a graphic designer known for her innovative approach to brand identity.",
    },
    {
      "name": "Bob Brown",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Bob is a project manager with a knack for delivering complex projects on time.",
    },
    {
      "name": "Sarah Davis",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Sarah is a UX/UI designer passionate about creating user-centered designs.",
    },
    {
      "name": "Michael Wilson",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Michael is a data scientist who enjoys solving complex problems with machine learning.",
    },
    {
      "name": "Emily Taylor",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Emily is a content writer with a love for crafting compelling narratives.",
    },
    {
      "name": "David Moore",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "David is an app developer specializing in mobile solutions for e-commerce platforms.",
    },
    {
      "name": "Olivia Anderson",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Olivia is a product manager with experience in launching successful tech products.",
    },
    {
      "name": "Daniel Thomas",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Daniel is a cybersecurity expert who focuses on protecting digital assets.",
    },
    {
      "name": "Sophia Martinez",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Sophia is an educator who develops innovative teaching methods for STEM subjects.",
    },
    {
      "name": "James White",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "James is an entrepreneur with a passion for creating sustainable businesses.",
    },
    {
      "name": "Mia Harris",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Mia is a health coach who helps clients achieve their wellness goals.",
    },
    {
      "name": "William Clark",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "William is a financial advisor with expertise in retirement planning and investments.",
    },
    {
      "name": "Isabella Lewis",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Isabella is an environmental scientist dedicated to researching climate change solutions.",
    },
    {
      "name": "Benjamin Lee",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Benjamin is a software developer who enjoys building scalable cloud applications.",
    },
    {
      "name": "Ava Walker",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Ava is a photographer who captures stunning landscapes and portraits.",
    },
    {
      "name": "Christopher Hall",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Christopher is a mechanical engineer with a focus on renewable energy systems.",
    },
    {
      "name": "Charlotte Young",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Charlotte is a social worker committed to helping vulnerable communities.",
    },
    {
      "name": "Alexander King",
      "imageUrl": "https://via.placeholder.com/150",
      "bio":
          "Alexander is a historian who specializes in ancient civilizations and their cultures.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Friends',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.05),
          Text(
            'Suggested Friends',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Add at least 5 friends to get started!',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(height: height * 0.05),
          Expanded(
            child: ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                var data = people[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: width * 0.9,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14)),
                      child: ListTile(
                        leading: Image.network(data['imageUrl']),
                        title: Text(data['name']),
                        trailing: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                                child: Text(
                              'Add Friend',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
