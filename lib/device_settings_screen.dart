import 'package:flutter/material.dart';

class DeviceSettingsScreen extends StatefulWidget {
  @override
  _DeviceSettingsScreenState createState() => _DeviceSettingsScreenState();
}

class _DeviceSettingsScreenState extends State<DeviceSettingsScreen> {
  bool _showMedsName = false;
  bool _notifyPharma = false;
  bool _addSorryTime = false;
  bool _setVacationTime = false;

  String _selectedAlarmTune = 'Rooster';
  String _selectedAlarmStrength = 'Louder';
  String _selectedSnooze = '5mins';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Device Settings', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF5CE0E6)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    title: Text('Set vacation time'),
                    value: _setVacationTime,
                    onChanged: (value) {
                      setState(() {
                        _setVacationTime = value;
                      });
                    },
                    activeColor: Color(0xFF5CE0E6),
                    inactiveTrackColor: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  _buildDateTimePicker('Start date & time'),
                  SizedBox(height: 20),
                  _buildDateTimePicker('End date & time'),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildSwitchListTile('Show meds name', _showMedsName, (value) => setState(() => _showMedsName = value)),
            SizedBox(height: 10),
            _buildSwitchListTile('Notify pharma to autofill', _notifyPharma, (value) => setState(() => _notifyPharma = value)),
            SizedBox(height: 10),
            _buildSwitchListTile('Add sorry time', _addSorryTime, (value) => setState(() => _addSorryTime = value)),
            SizedBox(height: 20),
            _buildOccupiedCabinetsField(),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alarm settings',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  _buildDropdownField('Alarm tune', ['Chimes', 'Rooster', 'Sweet piano'], _selectedAlarmTune, 'Select tune', (newValue) {
                    setState(() {
                      _selectedAlarmTune = newValue;
                    });
                  }),
                  SizedBox(height: 10),
                  _buildDropdownField('Alarm strength', ['Low', 'Medium', 'Louder'], _selectedAlarmStrength, 'Select alarm strength', (newValue) {
                    setState(() {
                      _selectedAlarmStrength = newValue;
                    });
                  }),
                  SizedBox(height: 10),
                  _buildDropdownField('Snooze', ['5mins', '10mins', '15mins'], _selectedSnooze, 'Select snooze', (newValue) {
                    setState(() {
                      _selectedSnooze = newValue;
                    });
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16.0)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'DD / MM / YYYY',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'HH: MM',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitchListTile(String title, bool value, void Function(bool) onChanged) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildOccupiedCabinetsField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Occupied cabinets',
          hintText: '1, 2, 3, 4, 5',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String value, String dialogTitle, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16.0)),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showPicker(items, value, dialogTitle, onChanged),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showPicker(List<String> items, String currentValue, String dialogTitle, ValueChanged<String> onChanged) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            dialogTitle,
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 48), // Placeholder to balance the back icon
                  ],
                ),
                Divider(height: 1, color: Colors.grey),
                Container(
                  height: 150.0, 
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Center(child: Text(items[index], style: TextStyle(color: items[index] == currentValue ? Colors.black : Colors.grey))),
                        onTap: () {
                          onChanged(items[index]);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}