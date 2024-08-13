import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/sugges friends bloc/suggested_friends_bloc.dart';

class RequestsCount extends StatelessWidget {
  const RequestsCount({
    super.key,
    required SuggestedFriendsBloc suggestedFriendsBloc,
  }) : _suggestedFriendsBloc = suggestedFriendsBloc;

  final SuggestedFriendsBloc _suggestedFriendsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestedFriendsBloc, SuggestedFriendsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Add at least 5 friends to get started!',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_suggestedFriendsBloc.currentRequestCount}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '/5',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
