import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/domain/entities/push_message.dart';
import 'package:push_app/presentation/blocs/notifications/notifications_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final String pushMessageId;
  const DetailsScreen({super.key, required this.pushMessageId});

  @override
  Widget build(BuildContext context) {
    final PushMessage? message =
        context.watch<NotificationsBloc>().getNotificationById(pushMessageId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: (message != null)
          ? _DetailsView(message: message)
          : const Center(
              child: Text('Message not found'),
            ),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final PushMessage message;
  const _DetailsView({required this.message});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image widget if imageUrl is not null
          if (message.imageUrl != null)
            Image.network(
              message.imageUrl!,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

          // Title
          const SizedBox(height: 8.0),
          Text(
            message.title,
            style: textStyles.titleLarge,
          ),

          // Body
          const SizedBox(height: 8.0),
          Text(
            message.body,
            style: textStyles.titleMedium,
          ),

          // Sent datetime
          const SizedBox(height: 8.0),
          Text(
            'Sent at: ${message.sentDateTime}',
            style: textStyles.titleSmall,
          ),

          // Data
          const SizedBox(height: 8.0),
          Text(
            'Data: ${message.data}',
            style: textStyles.titleSmall,
          ),
        ],
      ),
    );
  }
}
