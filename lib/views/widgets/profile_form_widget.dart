import 'package:explore_flutter_2/data/types/complete_profile_dto.dart';
import 'package:explore_flutter_2/models/user_model.dart';
import 'package:explore_flutter_2/services/store/user_store.dart';
import 'package:explore_flutter_2/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';

class ProfileFormWidget extends StatefulWidget {
  const ProfileFormWidget({super.key, required this.user});
  final UserModel user;

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();
  final _userStore = UserStore();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // pre-fill
    _phoneController.text = widget.user.phoneNum;
    _bioController.text = widget.user.bio;
    _locationController.text = widget.user.location;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Lengkapi Profil",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "No Hp Aktif",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.length < 12) return "Nomor hp minimal 12 digit!";
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: "Lokasi (Kota)",
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _bioController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: "Bio Singkat",
                    prefixIcon: Icon(Icons.info),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.length < 5) return "Bio terlalu pendek";
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    // onPressed: _isLoading ? null : _submitProfile,
                    onPressed: () {
                      if (_isLoading) return;
                      if (!_isLoading && _formKey.currentState!.validate()) {
                        _submitProfile();
                      }
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Simpan & Lanjutkan"),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Center(child: Text("Lewati sementara")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitProfile() async {
    setState(() => _isLoading = true);

    final data = CompleteProfileDTO(
      phoneNum: _phoneController.text.trim(),
      bio: _bioController.text.trim(),
      location: _locationController.text.trim(),
    );
    final res = await _userStore.completeProfile(data);

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pop(context);
      SnackbarWidget.show(context, res);
    }
  }
}
