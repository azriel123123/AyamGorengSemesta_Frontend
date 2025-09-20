import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_system/data/datasource/auth_local_datasource.dart';
import 'package:pos_system/data/datasource/auth_remote_datasource.dart';
import 'package:pos_system/ui/bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String getErrorMessage(String raw) {
    try {
      final decoded = jsonDecode(raw);
      return decoded['message'] ?? raw;
    } catch (e) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(AuthRemoteDataSource()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // Background
            Positioned.fill(
              child: Image.network(
                "https://i.pinimg.com/736x/87/fc/9c/87fc9cba1ed751254f6faac3023d8aa7.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),

            // Layout utama
            Row(
              children: [
                // Kiri: Form login
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white.withOpacity(0.9),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 40,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Welcome",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                "Please sign in",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 40),

                              const Text("Email"),
                              const SizedBox(height: 6),
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: "Enter your email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              const Text("Password"),
                              const SizedBox(height: 6),
                              TextField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),

                              BlocConsumer<LoginBloc, LoginState>(
                                listener: (context, state) async {
                                  if (state is LoginSuccess) {
                                    // simpan token
                                    await AuthLocalDatasource().saveAuthData(
                                        state.authResponseModel);

                                    print("🟢 Login berhasil!");
                                    print("Nama: ${state.authResponseModel.user.name}");
                                    print("Email: ${state.authResponseModel.user.email}");
                                    print("Token: ${state.authResponseModel.accessToken}");

                                    // pindah ke halaman home
                                    Navigator.pushReplacementNamed(context, '/home');
                                  }

                                  if (state is LoginFailure) {
                                    final errorMessage =
                                    getErrorMessage(state.message);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(errorMessage),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is LoginLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  return SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                      ),
                                      onPressed: () {
                                        context.read<LoginBloc>().add(
                                          LoginButtonPressed(
                                            email:
                                            _emailController.text.trim(),
                                            password: _passwordController.text.trim(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Sign in",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Kanan: Gambar panel
                Expanded(
                  flex: 2,
                  child: Image.network(
                    "https://i.pinimg.com/736x/ca/ff/1d/caff1d3607d27d2cefa4e66a95bcd2d2.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
