import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/screens/main_screen.dart';
import 'package:mobile_app/view_models/advise_view_model.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});
  @override
  State<Auth> createState() => AuthState();
}

class AuthState extends State<Auth> {
  static const authStates = [
    'sign_in',
    'sign_up',
    'forgot_password',
    'verification',
  ];

  var currentAuthState = authStates[0];
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String _name = '';
  String _email = '';
  String _username = '';
  String _password = '';
  bool isLoggingIn = false;
  late AdviseViewModel model;

  @override
  void initState() {
    model = AdviseViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(2, 84, 100, 1),
            Color.fromRGBO(42, 111, 125, 1),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text(
                    'ADVISE',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      color: Color.fromRGBO(246, 246, 249, 1),
                    ),
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(31, 20, 31, 0),
                      child: Column(
                        children: [
                          if (currentAuthState == 'sign_in')
                            Column(
                              children: [
                                Text(
                                  'Selamat Datang',
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.plusJakartaSans()
                                        .fontFamily,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: const Color.fromRGBO(2, 84, 100, 1),
                                  ),
                                ),
                                const SizedBox(
                                  height: 9.73,
                                ),
                                Text(
                                  'Silakan masukkan detail di bawah ini untuk melanjutkan',
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.plusJakartaSans()
                                        .fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromRGBO(2, 84, 100, 1),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Invalid username';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    // prefixIcon: Icon(
                                    //   Icons.person_outline_rounded,
                                    //   color: Color.fromRGBO(2, 84, 100, 1),
                                    // ),
                                    labelText: 'Username',
                                    labelStyle: TextStyle(
                                      fontFamily: GoogleFonts.plusJakartaSans()
                                          .fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color:
                                          const Color.fromRGBO(2, 84, 100, 1),
                                    ),
                                  ),
                                  onChanged: (value) => setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      _username = value.trim();
                                    }
                                  }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      // style: ButtonStyle(
                                      //     overlayColor:
                                      //         MaterialStateProperty.all(Colors.transparent)),
                                      onPressed: () => setState(() {
                                        _obscureText = !_obscureText;
                                      }),
                                      icon: _obscureText
                                          ? const Icon(
                                              Icons.visibility_outlined,
                                              color:
                                                  Color.fromRGBO(2, 84, 100, 1),
                                            )
                                          : const Icon(
                                              Icons.visibility_off_outlined,
                                              color:
                                                  Color.fromRGBO(2, 84, 100, 1),
                                            ),
                                    ),
                                    // prefixIcon: Icon(
                                    //   Icons.lock_outline_rounded,
                                    //   color: Color.fromRGBO(2, 84, 100, 1),
                                    // ),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      fontFamily: GoogleFonts.plusJakartaSans()
                                          .fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color:
                                          const Color.fromRGBO(2, 84, 100, 1),
                                    ),
                                  ),
                                  onChanged: (value) => setState(() {
                                    _password = value.trim();
                                  }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () async {
                                    setState(() {
                                      isLoggingIn = true;
                                    });
                                    if (kDebugMode) {
                                      print(_username);
                                      print(_password);
                                    }
                                    model.handleSignIn(
                                      username: _username,
                                      password: _password,
                                      onSuccess: () {
                                        setState(() {
                                          isLoggingIn = true;
                                        });
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Masuk ke akun dengan username $_username'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreen(),
                                          ),
                                        );
                                      },
                                      onFailed: () {
                                        setState(() {
                                          isLoggingIn = false;
                                        });
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Gagal masuk ke akun $_username'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                    );
                                  },
                                  style: IconButton.styleFrom(
                                    splashFactory: NoSplash.splashFactory,
                                  ),
                                  icon: Container(
                                    // width: 108,
                                    height: 44,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color.fromRGBO(2, 84, 100, 1),
                                          Color.fromRGBO(42, 111, 125, 1),
                                        ],
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color.fromRGBO(2, 84, 100, 1),
                                    ),
                                    child: isLoggingIn
                                        ? const CircularProgressIndicator()
                                        : Text(
                                            'Masuk',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Belum punya akun?',
                                      style: GoogleFonts.plusJakartaSans(
                                        // fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      style: IconButton.styleFrom(
                                        splashFactory: NoSplash.splashFactory,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          currentAuthState = authStates[1];
                                          if (kDebugMode) {
                                            print(currentAuthState);
                                          }
                                        });
                                      },
                                      icon: Text(
                                        'Daftar',
                                        style: GoogleFonts.plusJakartaSans(
                                          // fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromRGBO(
                                              48, 130, 192, 1),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          if (currentAuthState == 'sign_up')
                            Column(
                              children: [
                                Text(
                                  'Selamat Datang',
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.plusJakartaSans()
                                        .fontFamily,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: const Color.fromRGBO(2, 84, 100, 1),
                                  ),
                                ),
                                const SizedBox(
                                  height: 9.73,
                                ),
                                Text(
                                  'Silakan masukkan detail di bawah ini untuk melanjutkan',
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.plusJakartaSans()
                                        .fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromRGBO(2, 84, 100, 1),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Nama tidak valid';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    // prefixIcon: Icon(
                                    //   Icons.card,
                                    //   color: Color.fromRGBO(2, 84, 100, 1),
                                    // ),
                                    labelText: 'Nama Lengkap',
                                    labelStyle: TextStyle(
                                      fontFamily: GoogleFonts.plusJakartaSans()
                                          .fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color:
                                          const Color.fromRGBO(2, 84, 100, 1),
                                    ),
                                  ),
                                  onChanged: (value) => setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      _name = value.trim();
                                    }
                                  }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Invalid email address';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    // prefixIcon: Icon(
                                    //   Icons.alternate_email_rounded,
                                    //   color: Color.fromRGBO(2, 84, 100, 1),
                                    // ),
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      fontFamily: GoogleFonts.plusJakartaSans()
                                          .fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color:
                                          const Color.fromRGBO(2, 84, 100, 1),
                                    ),
                                  ),
                                  onChanged: (value) => setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      _email = value.trim();
                                    }
                                  }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Invalid username';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    // prefixIcon: Icon(
                                    //   Icons.alternate_email_rounded,
                                    //   color: Color.fromRGBO(2, 84, 100, 1),
                                    // ),
                                    labelText: 'Username',
                                    labelStyle: TextStyle(
                                      fontFamily: GoogleFonts.plusJakartaSans()
                                          .fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color:
                                          const Color.fromRGBO(2, 84, 100, 1),
                                    ),
                                  ),
                                  onChanged: (value) => setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      _username = value.trim();
                                    }
                                  }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(2, 84, 100, 1),
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      // style: ButtonStyle(
                                      //     overlayColor:
                                      //         MaterialStateProperty.all(Colors.transparent)),
                                      onPressed: () => setState(() {
                                        _obscureText = !_obscureText;
                                      }),
                                      icon: _obscureText
                                          ? const Icon(
                                              Icons.visibility_outlined,
                                              color:
                                                  Color.fromRGBO(2, 84, 100, 1),
                                            )
                                          : const Icon(
                                              Icons.visibility_off_outlined,
                                              color:
                                                  Color.fromRGBO(2, 84, 100, 1),
                                            ),
                                    ),
                                    // prefixIcon: Icon(
                                    //   Icons.lock_outline_rounded,
                                    //   color: Color.fromRGBO(2, 84, 100, 1),
                                    // ),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      fontFamily: GoogleFonts.plusJakartaSans()
                                          .fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color:
                                          const Color.fromRGBO(2, 84, 100, 1),
                                    ),
                                  ),
                                  onChanged: (value) => setState(() {
                                    _password = value.trim();
                                  }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () async {
                                    setState(() {
                                      isLoggingIn = true;
                                    });
                                    if (kDebugMode) {
                                      print(_name);
                                      print(_email);
                                      print(_username);
                                      print(_password);
                                    }
                                    model.handleSignUp(
                                      username: _username,
                                      password: _password,
                                      email: _email,
                                      name: _name,
                                      onSuccess: () {
                                        setState(() {
                                          isLoggingIn = false;
                                        });
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Akun dengan username $_username, berhasil dibuat'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreen(),
                                          ),
                                        );
                                      },
                                      onFailed: () {},
                                    );
                                  },
                                  style: IconButton.styleFrom(
                                    splashFactory: NoSplash.splashFactory,
                                  ),
                                  icon: Container(
                                    // width: 108,
                                    height: 44,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color.fromRGBO(2, 84, 100, 1),
                                          Color.fromRGBO(42, 111, 125, 1),
                                        ],
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color.fromRGBO(2, 84, 100, 1),
                                    ),
                                    child: isLoggingIn
                                        ? const CircularProgressIndicator()
                                        : Text(
                                            'Daftar',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sudah punya akun?',
                                      style: GoogleFonts.plusJakartaSans(
                                        // fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      style: IconButton.styleFrom(
                                        splashFactory: NoSplash.splashFactory,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          currentAuthState = authStates[0];
                                          if (kDebugMode) {
                                            print(currentAuthState);
                                          }
                                        });
                                      },
                                      icon: Text(
                                        'Masuk',
                                        style: GoogleFonts.plusJakartaSans(
                                          // fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromRGBO(
                                              48, 130, 192, 1),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
