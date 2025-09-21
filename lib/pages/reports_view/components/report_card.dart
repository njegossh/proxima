import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proxima/classes/models/report.dart';
import 'package:proxima/classes/models/user.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.report,
    required this.fromUser,
    required this.toUser,
  });

  final Report report;
  final User fromUser;
  final User toUser;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy. HH:mm').format(report.date);

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              children: [
                _buildUserAvatar(fromUser),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${fromUser.fullName} → ${toUser.fullName}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(report.desc, style: Theme.of(context).textTheme.bodyLarge),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                formattedDate,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAvatar(User user) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: (user.imageString != null && user.imageString!.isNotEmpty)
            ? Image.memory(
                base64Decode(user.imageString!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, size: 40),
              )
            : const Icon(Icons.person, size: 40),
      ),
    );
  }
}
