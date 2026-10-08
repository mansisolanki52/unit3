import 'package:flutter/material.dart';

class UserFormData {
  String username = '';
  String userRole = 'Developer';
  bool subscribeToNewsletter = false;
}

class Hard06ComplexFormSaveNavigationScreen extends StatefulWidget {
  const Hard06ComplexFormSaveNavigationScreen({super.key});

  @override
  State<Hard06ComplexFormSaveNavigationScreen> createState() =>
      _Hard06ComplexFormSaveNavigationScreenState();
}

class _Hard06ComplexFormSaveNavigationScreenState
    extends State<Hard06ComplexFormSaveNavigationScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserFormData _formData = UserFormData();

  final List<String> _roles = ['Developer', 'Designer', 'Manager', 'Student'];

  void _submitAndSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormSummaryScreen(formData: _formData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard 6: Form.save() Navigation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (val) {
                  _formData.username = val ?? '';
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _formData.userRole,
                decoration: const InputDecoration(
                  labelText: 'Select Role',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.work),
                ),
                items: _roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _formData.userRole = val;
                    });
                  }
                },
                onSaved: (val) {
                  if (val != null) _formData.userRole = val;
                },
              ),
              const SizedBox(height: 16),
              FormField<bool>(
                initialValue: _formData.subscribeToNewsletter,
                validator: (val) {
                  if (val != true) {
                    return 'You must agree to subscribe to continue';
                  }
                  return null;
                },
                onSaved: (val) {
                  _formData.subscribeToNewsletter = val ?? false;
                },
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        title: const Text('Subscribe to daily updates'),
                        value: field.value,
                        onChanged: (bool? val) {
                          field.didChange(val);
                          _formData.subscribeToNewsletter = val ?? false;
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                      if (field.hasError)
                        Text(
                          field.errorText!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitAndSaveForm,
                icon: const Icon(Icons.save),
                label: const Text('Save & View Summary'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormSummaryScreen extends StatelessWidget {
  final UserFormData formData;

  const FormSummaryScreen({super.key, required this.formData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Saved Form Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 24),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Username'),
                    subtitle: Text(formData.username),
                  ),
                  ListTile(
                    leading: const Icon(Icons.work),
                    title: const Text('Role'),
                    subtitle: Text(formData.userRole),
                  ),
                  ListTile(
                    leading: const Icon(Icons.mark_email_read),
                    title: const Text('Newsletter Subscribed'),
                    subtitle: Text(formData.subscribeToNewsletter ? 'Yes' : 'No'),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Edit Details'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
