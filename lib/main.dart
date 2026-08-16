import 'package:flutter/material.dart';

void main() {
  runApp(const MahaboteApp());
}

class MahaboteApp extends StatelessWidget {
  const MahaboteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'မြန်မာ့ဗေဒင် - မဟာဘုတ်နှင့် သက်ရောက်',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const MahaboteHomeScreen(),
    );
  }
}

class MahaboteHomeScreen extends StatefulWidget {
  const MahaboteHomeScreen({super.key});

  @override
  State<MahaboteHomeScreen> createState() => _MahaboteHomeScreenState();
}

class _MahaboteHomeScreenState extends State<MahaboteHomeScreen> {
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();

  String _result = '';

  // မဟာဘုတ် တွက်ချက်သည့် ရိုးရှင်းသော Logic (မြန်မာသက္ကရာဇ်အခြေခံ)
  void _calculateMahabote() {
    int? year = int.tryParse(_yearController.text);
    int? month = int.tryParse(_monthController.text);
    int? day = int.tryParse(_dayController.text);

    if (year == null || month == null || day == null) {
      setState(() {
        _result = 'ကျေးဇူးပြု၍ မွေးသက္ကရာဇ်ကို ဂဏန်းဖြင့် အမှန်အတိုင်း ထည့်ပါ။';
      });
      return;
    }

    // မဟာဘုတ် အကြွင်းတွက်ချက်ခြင်း ဥပမာဖော်မြူ
    int remainder = (year + month + day) % 7;
    
    List<String> houses = [
      'အဓိပတိ (ဘုရင်၊ အကြီးအကဲ)',
      'အာဓိပတိ (အစိုးရ၊ မင်း)',
      'သုခ (ချမ်းသာသုခ၊ ပျော်ရွှင်မှု)',
      'မရဏ (ရောဂါ၊ ပျက်စီးခြင်း)',
      'ပုတိ (အပုပ်၊ ဆွေးမြေ့ခြင်း)',
      'အဘိသမ္ပဒ (စည်းစိမ်ဥစ္စာ တိုးတက်ခြင်း)',
      'ရာဇ (အာဏာ၊ ဘုန်းတန်ခိုး)'
    ];

    // သက်ရောက်တွက်ချက်မှု (အကြမ်းဖျင်း)
    intသက်ရောက် = (year % 12);

    setState(() {
      _result = 'ရလဒ်:\n\n'
          'မဟာဘုတ်ခွင်ကျ: ${houses[remainder]}\n'
          'သက်ရောက်ဂဏန်း အကြွင်း: $သက်ရောက်';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('မဟာဘုတ်နှင့် သက်ရောက်တွက်စက်'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'မွေးနှစ် (ဥပမာ - 1995)'),
            ),
            TextField(
              controller: _monthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'မွေးလ (ဥပမာ - 5)'),
            ),
            TextField(
              controller: _dayController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'မွေးရက် (ဥပမာ - 12)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateMahabote,
              child: const Text('ဗေဒင် တွက်မည်'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
