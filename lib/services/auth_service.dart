import 'package:explore_flutter_2/utils/my_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Notes (SOURCE GEMINI):
/// "Continue with Google" adalah metode login-nya (Metode Auth), sedangkan Firebase Auth adalah
/// "Mesin Penanggung Jawab"-nya (Platform Auth).
/// Bayangkan sebuah gedung apartemen:
/// Firebase Auth adalah Resepsionis/Security gedung tersebut. Dia yang mencatat siapa saja yang
/// boleh masuk, memegang buku tamu, dan memberikan kunci kamar.
/// "Continue with Google" (SSO) adalah Kartu Akses milikmu. Si Resepsionis (Firebase) bilang:
/// "Oke, kamu nggak perlu daftar pakai formulir baru (email/pass), cukup tunjukkan kartu Google-mu
/// saja, nanti aku catat kamu sebagai penghuni resmi."
///
/// Alur nya :
///
/// 1. Google Sign-In: Aplikasi kamu akan memanggil SDK Google untuk memunculkan pop-up pilihan akun
/// Google.
/// 2. Credential: Setelah kamu pilih akun, Google akan memberikan sebuah Token (bukti kalau kamu
/// beneran pemilik akun itu).
/// 3. Firebase Auth: Token tersebut kamu kirim ke Firebase Auth. Firebase akan memvalidasi ke server Google: "Eh Google, token ini beneran dari kamu buat user ini kan?".
/// 4. User Created: Kalau valid, Firebase Auth akan membuatkan satu baris data user baru di
/// Firebase Console kamu.
///
/// Kenapa di combo ? :
/// 1. Multi-Provider: Hari ini kamu pakai Google. Besok kalau kamu mau tambah "Login with GitHub"
/// atau "Login with Apple", kodenya di sisi database tetap sama karena semuanya dikelola satu
/// pintu oleh Firebase.
/// 2. User Management: Firebase memberimu UI di dashboard untuk melihat siapa saja yang sudah
/// daftar, kapan terakhir login, sampai fitur buat ban user nakal.
/// 3. Keamanan: Firebase menghandle enkripsi dan penyimpanan data sensitif user, jadi kamu nggak
/// perlu pusing mikirin database user sendiri di Express.js.
///

class AuthService {
  // bikin instance nya
  // di doc GoogleSignIn() gaada adanya langsung tembak instance GoogleSignIn.instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // buat akses user saat ini
  User? get currentUser => _firebaseAuth.currentUser;

  // stream data realtime buat cek status login misal pindah halaman mungkin konsepnya kaya prinsip auth me di BE service
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // handling login pakai future karena sifatnya async
  Future<UserCredential?> signInWithGoogle() async {
    MyLogger().t("sign in 1 -> masuk sign in mulai proses...");
    try {
      MyLogger().t("sign in 2 -> masuk blok try");

      // panggil inisiasi ini dari doc nya
      await _googleSignIn.initialize();
      // mulai proses interaksi dengan google function signIn() udah gaada adanya authenticate()
      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      MyLogger().t("sign in 3 -> isi googleUser $googleUser ");

      // kalo kosong return null
      if (googleUser == null) {
        MyLogger().e("googleUser kosong kena abort dari user kayaknya");
        return null;
      }

      // proses authenticate kalo googleUser ga kosong
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      MyLogger().t("sign in 4 -> isi googleAuth $googleAuth ");

      // bikin credentials buat dikirim ke Firebase Gate
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      MyLogger().t("sign in 5 -> isi credential $credential");

      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      MyLogger().e("Error woi: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
