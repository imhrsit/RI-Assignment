import 'package:flutter/material.dart';
import 'package:realtime_innovations/global/colors.dart';
import 'package:realtime_innovations/models/employee.dart';

class AddEmployeeDetails extends StatefulWidget {
  final bool isEditing;
  final Employee? employee;

  const AddEmployeeDetails({
    super.key,
    this.isEditing = false,
    this.employee,
  });

  @override
  State<AddEmployeeDetails> createState() => _AddEmployeeDetailsState();
}

class _AddEmployeeDetailsState extends State<AddEmployeeDetails> {
  String? selectedRole;
  DateTime? selectedDate;
  DateTime? selectedEndDate;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.employee != null) {
      _nameController.text = widget.employee!.name;
      selectedRole = widget.employee!.role;
      selectedDate = widget.employee!.startDate;
      selectedEndDate = widget.employee!.endDate;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  DateTime getNextMonday() {
    DateTime now = DateTime.now();
    return now.add(Duration(days: (DateTime.monday - now.weekday + 7) % 7));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Employee Details' : 'Add Employee Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: widget.isEditing ? [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Employee'),
                    content: const Text('Do you want to delete this employee?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel', style: TextStyle(color: kdarkBlue)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context, 'delete'); // Return 'delete' to previous screen
                        },
                        child: const Text('Delete', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ] : null,
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
                labelStyle: TextStyle(color: kgrey),
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
            
            // Date Selectors
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          DateTime? tempSelectedDate = selectedDate ?? DateTime.now();
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          tempSelectedDate = DateTime.now();
                                          Navigator.pop(context, tempSelectedDate);
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue.shade50,
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text('Today', style: TextStyle(color: kdarkBlue)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          tempSelectedDate = getNextMonday();
                                          Navigator.pop(context, tempSelectedDate);
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue.shade50,
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text('Next Monday', style: TextStyle(color: kdarkBlue)),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        final now = DateTime.now();
                                        tempSelectedDate = now.add(const Duration(days: ((DateTime.tuesday - 1 + 7) % 7) + 7));
                                        Navigator.pop(context, tempSelectedDate);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue.shade50,
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text('Next Tuesday', style: TextStyle(color: kdarkBlue)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        tempSelectedDate = DateTime.now().add(const Duration(days: 7));
                                        Navigator.pop(context, tempSelectedDate);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue.shade50,
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text('After 1 week', style: TextStyle(color: kdarkBlue)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 400,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: Theme.of(context).colorScheme.copyWith(
                                        primary: kdarkBlue,
                                      ),
                                    ),
                                    child: StatefulBuilder(
                                      builder: (context, setCalendarState) {
                                        return CalendarDatePicker(
                                          initialDate: tempSelectedDate,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                          onDateChanged: (DateTime date) {
                                            tempSelectedDate = date;
                                            setCalendarState(() {});
                                            setState(() {});
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Divider(color: kgrey),
                                StatefulBuilder(
                                  builder: (context, setBottomState) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_today_outlined, 
                                                size: 20, 
                                                color: kdarkBlue
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                "${tempSelectedDate!.day}/${tempSelectedDate!.month}/${tempSelectedDate!.year}",
                                                style: TextStyle(color: kdarkBlue),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: Text('Cancel', style: TextStyle(color: kdarkBlue)),
                                              ),
                                              const SizedBox(width: 5),
                                              ElevatedButton(
                                                onPressed: () => Navigator.pop(context, tempSelectedDate),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: kdarkBlue,
                                                ),
                                                child: Text('Save', style: TextStyle(color: kwhite)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: selectedDate == null ? 'Today' : '',
                      prefixIcon: Icon(Icons.calendar_today_outlined, color: kdarkBlue),
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
                    controller: TextEditingController(
                      text: selectedDate != null 
                          ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                          : '',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          DateTime? tempSelectedDate = selectedEndDate ?? DateTime.now();
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          tempSelectedDate = DateTime.now();
                                          Navigator.pop(context, tempSelectedDate);
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue.shade50,
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text('Today', style: TextStyle(color: kdarkBlue)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          tempSelectedDate = getNextMonday();
                                          Navigator.pop(context, tempSelectedDate);
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue.shade50,
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text('Next Monday', style: TextStyle(color: kdarkBlue)),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        final now = DateTime.now();
                                        tempSelectedDate = now.add(const Duration(days: ((DateTime.tuesday - 1 + 7) % 7) + 7));
                                        Navigator.pop(context, tempSelectedDate);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue.shade50,
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text('Next Tuesday', style: TextStyle(color: kdarkBlue)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        tempSelectedDate = DateTime.now().add(const Duration(days: 7));
                                        Navigator.pop(context, tempSelectedDate);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue.shade50,
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text('After 1 week', style: TextStyle(color: kdarkBlue)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 400,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: Theme.of(context).colorScheme.copyWith(
                                        primary: kdarkBlue,
                                      ),
                                    ),
                                    child: StatefulBuilder(
                                      builder: (context, setCalendarState) {
                                        return CalendarDatePicker(
                                          initialDate: tempSelectedDate,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                          onDateChanged: (DateTime date) {
                                            tempSelectedDate = date;
                                            setCalendarState(() {});
                                            setState(() {});
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Divider(color: kgrey),
                                StatefulBuilder(
                                  builder: (context, setBottomState) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_today_outlined, 
                                                size: 20, 
                                                color: kdarkBlue
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                selectedEndDate == null ? "No date" : "${tempSelectedDate!.day}/${tempSelectedDate!.month}/${tempSelectedDate!.year}",
                                                style: TextStyle(color: kdarkBlue),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: Text('Cancel', style: TextStyle(color: kdarkBlue)),
                                              ),
                                              const SizedBox(width: 5),
                                              ElevatedButton(
                                                onPressed: () => Navigator.pop(context, tempSelectedDate),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: kdarkBlue,
                                                ),
                                                child: Text('Save', style: TextStyle(color: kwhite)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          selectedEndDate = picked;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: selectedEndDate == null ? 'No date' : '',
                      labelStyle: TextStyle(color: kgrey),
                      prefixIcon: Icon(Icons.calendar_today_outlined, color: kdarkBlue),
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
                    controller: TextEditingController(
                      text: selectedEndDate != null 
                          ? "${selectedEndDate!.day}/${selectedEndDate!.month}/${selectedEndDate!.year}"
                          : '',
                    ),
                  ),
                ),
              ],
            ),
            
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
                    if (_nameController.text.isEmpty || selectedRole == null || selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all required fields')),
                      );
                      return;
                    }

                    final employee = Employee(
                      name: _nameController.text,
                      role: selectedRole!,
                      startDate: selectedDate!,
                      endDate: selectedEndDate,
                      isFormer: selectedEndDate != null,
                    );

                    Navigator.pop(context, employee);
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
