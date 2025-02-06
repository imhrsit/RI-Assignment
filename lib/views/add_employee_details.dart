import 'package:flutter/material.dart';
import 'package:realtime_innovations/global/colors.dart';

class AddEmployeeDetails extends StatefulWidget {
  const AddEmployeeDetails({super.key});

  @override
  State<AddEmployeeDetails> createState() => _AddEmployeeDetailsState();
}

class _AddEmployeeDetailsState extends State<AddEmployeeDetails> {
  String? selectedRole;
  DateTime? selectedDate;
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Updated Employee name text field
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: _nameController.text.isEmpty ? 'Employee name' : '',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelStyle: TextStyle(color: kgrey),
                prefixIcon: Icon(Icons.person_2_outlined, color: kdarkBlue,),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kgrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kgrey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Updated Role dropdown
            TextFormField(
              readOnly: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          'Product Designer',
                          'Flutter Developer',
                          'QA Tester',
                          'Product Owner',
                        ].map((role) => ListTile(
                          title: Center(
                            child: Text(
                              role,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedRole = role;
                            });
                            Navigator.pop(context);
                          },
                        )).toList(),
                      ),
                    );
                  },
                );
              },
              controller: TextEditingController(text: selectedRole),
              decoration: InputDecoration(
                labelText: selectedRole?.isEmpty ?? true ? 'Select role' : '',
                prefixIcon: Icon(Icons.work_outline_outlined, color: kdarkBlue),
                suffixIcon: Icon(Icons.arrow_drop_down, color: kdarkBlue),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kgrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kgrey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            //Date Selectors
            
            
            
            const Spacer(),
            
            // Bottom buttons
            Divider(
              color: kgrey,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: kdarkBlue.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: kdarkBlue),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add save logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kdarkBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Save', style: TextStyle(color: kwhite)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
