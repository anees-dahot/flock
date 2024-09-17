import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/features/profile/bloc/profile_bloc.dart';
import 'package:flock/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsSection extends StatelessWidget {
  const FriendsSection({
    super.key,
    required ProfileBloc profileBloc,
    required this.size,
  }) : _profileBloc = profileBloc;

  final ProfileBloc _profileBloc;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: _profileBloc,
      builder: (context, state) {
        if (state is GetFriendRequestsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetFriendRequestsFailureState) {
          return Container(
            width: size.width * 0.9,
            height: size.height * 0.3,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(state.error),
            ),
          );
        } else if (state is GetFriendRequestsSuccessState) {
          return SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.39,
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      shrinkWrap: true, // Prevent scrolling
                      physics:
                          const NeverScrollableScrollPhysics(), // Prevent scrolling
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.68,
                              crossAxisSpacing: 20),
                      itemCount: state.friendRequests.length == 6
                          ? 6
                          : state.friendRequests.length < 6
                              ? state.friendRequests.length
                              : 6,
                      itemBuilder: (context, index) {
                        final data = state.friendRequests[index];
                        return GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              ProfileScreen.routeName,
                              arguments: data),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: data.profileImage!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      color: Colors.grey[300],
                                      child: Icon(Icons.person,
                                          size: 50, color: Colors.grey[600]),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Flexible(
                                child: Text(
                                  data.fullName!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // SizedBox(height: size.height * 0.01),
                  Container(
                    width: size.width * 0.9,
                    height: size.height * 0.055,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        'See all friends',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  )
                ],
              ));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
