import 'package:flutter/material.dart';

class AddMedicineInfoScreen extends StatefulWidget {
  @override
  _AddMedicineInfoScreenState createState() => _AddMedicineInfoScreenState();
}

class _AddMedicineInfoScreenState extends State<AddMedicineInfoScreen> {
  List<AlarmInput> _alarms = [AlarmInput(key: UniqueKey())];
  String _frequency = 'Daily';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Medicine Info', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Medicine name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'enter name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildFrequencyOptions(),
            SizedBox(height: 20),
            ..._alarms,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _alarms.add(AlarmInput(key: UniqueKey()))),
        label: Text(
          'Add more alarm',
          style: TextStyle(color: Color(0xFF5CE0E6), fontSize: 18.0), 
        ),
        icon: Icon(
          Icons.add_alarm,
          color: Color(0xFF5CE0E6), 
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
      ),
    );
  }

  Widget _buildFrequencyOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Frequency', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
        RadioListTile(
          title: Text('Daily'),
          value: 'Daily',
          groupValue: _frequency,
          onChanged: (value) => setState(() => _frequency = value.toString()),
        ),
        RadioListTile(
          title: Text('Specific days'),
          value: 'Specific days',
          groupValue: _frequency,
          onChanged: (value) => setState(() => _frequency = value.toString()),
        ),
        RadioListTile(
          title: Text('Interval'),
          value: 'Interval',
          groupValue: _frequency,
          onChanged: (value) => setState(() => _frequency = value.toString()),
        ),
        RadioListTile(
          title: Text('As needed'),
          value: 'As needed',
          groupValue: _frequency,
          onChanged: (value) => setState(() => _frequency = value.toString()),
        ),
      ],
    );
  }
}

class AlarmInput extends StatefulWidget {
  const AlarmInput({Key? key}) : super(key: key);

  @override
  _AlarmInputState createState() => _AlarmInputState();
}

class _AlarmInputState extends State<AlarmInput> {
  TextEditingController _timeController = TextEditingController(text: '08:00');
  TextEditingController _doseController = TextEditingController(text: '5 ml');

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Set time & dose', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  hintText: '08:00',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () => _selectTime(context),
                  ),
                ),
                readOnly: true,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _doseController,
                decoration: InputDecoration(
                  hintText: '5 ml',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
