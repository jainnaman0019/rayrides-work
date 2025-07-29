import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rayride/role_selection_screen.dart';

class OTPscreen extends StatefulWidget {
  final String verificationId;

  OTPscreen({required this.verificationId});

  @override
  State<OTPscreen> createState() => _OTPscreenState();
}

class _OTPscreenState extends State<OTPscreen> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> otpFocusNodes =
      List.generate(6, (_) => FocusNode());

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
    }
  }

  void _verifyOtp() async {
    String otp = otpControllers.map((controller) => controller.text).join();

    if (otp.length < 6) {
      print("Enter all 6 digits.");
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("OTP Verified ✅");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>roleSelection()),
      );
    } catch (e) {
      print("OTP Verification Failed ❌: $e");
    }
  }

  void _resendOtp() {
    // Optionally implement resend logic
    print("Resend OTP not implemented.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EAF6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black87),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Verify OTP', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                    SizedBox(height: 32),
                    Icon(Icons.lock, size: 60, color: Colors.orange),
                    SizedBox(height: 24),
                    Text('Enter the 6-digit code sent to your phone', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black87)),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 40,
                          child: TextField(
                            controller: otpControllers[index],
                            focusNode: otpFocusNodes[index],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onChanged: (value) => _onOtpChanged(value, index),
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: _resendOtp,
                      child: Text('Resend OTP', style: TextStyle(color: Colors.grey[600])),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF7043),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text("Verify", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


