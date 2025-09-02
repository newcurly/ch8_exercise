import 'package:flutter/material.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  // ตัวแปร State และเมธอดต่างๆ จะอยู่ที่นี่
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  String _savedEmail = '';
  String _savedPassword = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // โครงสร้าง UI จะอยู่ที่นี่
    return Scaffold(
      // โครงสร้างพื้นฐาน
      appBar: AppBar(title: const Text('ฟอร์มล็อกอิน')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('กรุณาป้อนข้อมูลเข้าระบบ'),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'อีเมล',
                  hintText: 'you@example.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกอีเมล';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'กรุณากรอกให้ถูกต้อง';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    _savedEmail = value;
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'รหัสผ่าน',
                  hintText: 'กรอกรหัสผ่าน',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาป้อนรหัสผ่านของคุณ';
                  }
                  if (value.length < 6) {
                    return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    _savedPassword = value;
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'สำเร็จ! Email : $_savedEmail, password : $_savedPassword',
                        ),
                      ),
                    );
                    print('email : $_savedEmail');
                    print('password : $_savedPassword');
                  } else {
                    print('ฟอร์มไม่ถูกต้อง');
                  }
                },
                child: const Text('เข้าสู่ระบบ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}