import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            const Text('Flock', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(CupertinoIcons.search), onPressed: () {}),
          IconButton(icon: const Icon(CupertinoIcons.bell), onPressed: () {}),
        ],
       backgroundColor: Theme.of(context).colorScheme.background, 
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.pencil,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 12),
                        Text(
                          "What's on your mind?",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.photo,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/100?random=$index'),
                        ),
                        title: Text('User $index',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text('2 hours ago'),
                        trailing: IconButton(
                          icon: const Icon(CupertinoIcons.ellipsis),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(15)),
                        child: Image.network(
                          'https://picsum.photos/400/300?random=$index',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(CupertinoIcons.heart,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                const SizedBox(width: 4),
                                Text('1.2k',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                                const SizedBox(width: 16),
                                Icon(CupertinoIcons.chat_bubble,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                const SizedBox(width: 4),
                                Text('84',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                              ],
                            ),
                            Icon(CupertinoIcons.share,
                                color: Theme.of(context).colorScheme.primary),
                          ],
                        ),
                      ),
                    ],
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
