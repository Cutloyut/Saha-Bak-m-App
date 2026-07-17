import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../index.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.black, width: 1.3),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "login".tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Divider(thickness: 1.3, color: Colors.black),
                  SizedBox.shrink(),
                  TextField(
                    decoration: InputDecoration(hintText: "name".tr),
                    controller: _nameController,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () => context.read<AuthProvider>().login(
                        UserRole.technician,
                        _nameController.text,
                        context,
                      ),
                      child: Text("technician".tr),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () => context.read<AuthProvider>().login(
                        UserRole.teamlead,
                        _nameController.text,
                        context,
                      ),
                      child: Text("teamlead".tr),
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
