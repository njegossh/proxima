import 'package:flutter/material.dart';
import 'package:proxima/pages/course_creation/components/course_display_image.dart';
import '../controller.dart';

class InputForm extends StatefulWidget {
  final CourseCreationController controller;
  const InputForm({super.key, required this.controller});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Coursedisplayimage(
                    displayImageURL: widget.controller.thumbnailURL.text,
                  ),
                  SizedBox(height: 12),
                  TextField(
                    maxLines: 1,
                    controller: widget.controller.thumbnailURL,
                    onChanged: (_) => setState(() {}),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    decoration: InputDecoration(
                      labelText: 'URL do slike kursa',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12,),
              TextField(
                maxLines: 1,
                controller: widget.controller.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                decoration: InputDecoration(
                  labelText: 'Naziv',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                maxLines: 1,
                controller: widget.controller.tags,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                decoration: InputDecoration(
                  labelText: 'Tagovi',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                maxLines: 1,
                controller: widget.controller.pricePerHour,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                decoration: InputDecoration(
                  labelText: 'Cena po satu',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                maxLines: 4,
                controller: widget.controller.description,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                decoration: InputDecoration(
                  labelText: 'Opis',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                maxLines: 1,
                controller: widget.controller.videoURL,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                decoration: InputDecoration(
                  labelText: 'URL do Youtube videa',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget.controller.createCourse();
                  Navigator.pop(context);
                },
                child: Text('Dodaj'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
