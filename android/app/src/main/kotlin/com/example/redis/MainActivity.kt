package com.example.focus

import android.annotation.SuppressLint
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.content.pm.Signature
import android.os.Build
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException


private const val TAG = "MainActivity"

class MainActivity : FlutterActivity() {
    private val HEX_ARRAY = "0123456789ABCDEF".toCharArray()
    fun bytesToHex(bytes: ByteArray): String? {
        val hexChars = CharArray(bytes.size * 2)
        for (j in bytes.indices) {
            val v = bytes[j].toInt() and 0xFF
            hexChars[j * 2] = HEX_ARRAY[v ushr 4]
            hexChars[j * 2 + 1] = HEX_ARRAY[v and 0x0F]
        }
        return String(hexChars)
    }

    fun byteArrayToHex(a: ByteArray): String? {
        val sb = StringBuilder(a.size * 2)
        for (b in a) sb.append(String.format("%02x", b))
        return sb.toString()
    }

    @Suppress("DEPRECATION")
    private fun getPackageInfo(): PackageInfo {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) packageManager.getPackageInfo(
            packageName,
            PackageManager.PackageInfoFlags.of(PackageManager.GET_SIGNING_CERTIFICATES.toLong())
        ) else packageManager.getPackageInfo(
            packageName,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) PackageManager.GET_SIGNING_CERTIFICATES
            else PackageManager.GET_SIGNATURES
        )
    }

    @SuppressLint("PrivateApi")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        try {

            getPackageInfo().getSignatures().firstOrNull()?.toByteArray()?.also {
                Log.d(
                    TAG,
                    "onCreate: ${
                        computeSha256Digest(it).uppercase().replace(Regex(".."), "$0:").dropLast(1)
                    }"
                )
//                Log.d(
//                    TAG,
//                    "onCreate: ${
//                        (Class.forName("android.util.PackageUtils")
//                            .getDeclaredMethod(
//                                "computeSha256Digest",
//                                ByteArray::class.java
//                            ).invoke(null, it) as String).replace(Regex(".."), "$0:").dropLast(1)
//                    }"
//                )
            }

//            val signingDetails = Class.forName("android.content.pm.PackageParser\$SigningDetails")
//            val signingDetailsWithDigests: Class<*> =
//                Class.forName("android.util.apk.ApkSignatureVerifier\$SigningDetailsWithDigests")
//            val signingDetailsWithDigestsConstructorExact: Constructor<*> =
//                signingDetailsWithDigests.getDeclaredConstructor(
//                    signingDetailsWithDigests, signingDetails,
//                    MutableMap::class.java
//                )


//            Class.forName("android.content.pm.parsing.result.ParseTypeImpl").also { aaaa ->
////            Class.forName("android.util.apk.ApkSignatureSchemeV4Verifier").also {
//
//                val meth = aaaa.getDeclaredMethod("forDefaultParsing")
//                val obj = meth.invoke(null)
//
//                val mm = Class.forName("android.util.apk.ApkSignatureVerifier")
//                val signatureGen =
////                    mm.getDeclaredMethod(
////                        "verifySignaturesInternal",
////                        Class.forName("android.content.pm.parsing.result.ParseInput"),
////                        String::class.java,
////                        Int::class.java,
////                        Boolean::class.java
////                    )
//                    mm.getDeclaredMethod(
//                        "unsafeGetCertsWithoutVerification",
//                        Class.forName("android.content.pm.parsing.result.ParseInput"),
//                        String::class.java,
//                        Int::class.java
//                    )
////                Log.d(TAG, "onCreate: $obj, ${meth.returnType}")
////                Log.d(TAG, "onCreate: ${context.applicationInfo.publicSourceDir}")
//                val aa = signatureGen.invoke(null, obj, context.applicationInfo.publicSourceDir, 2)
//
////                Log.d(TAG, "onCreate: $aa")
//                aaaa.getMethod("getErrorMessage").apply {
//                    if (invoke(aa) == null) {
//                        val res = aaaa.getMethod("getResult").invoke(aa)
//                        Log.d(
//                            TAG,
//                            "onCreate: aa=$aa res=$res, ${aaaa.getMethod("getResult").returnType}"
//                        )
//                        Class.forName("android.content.pm.SigningDetails")
//                            .getMethod("getSignatures").invoke(res).apply {
//                                val aa = this as Array<*>
////                            Log.d(TAG, "onCreate: getSignatures ${aa[0]}")
//
//                                Class.forName("android.content.pm.Signature")
//                                    .getMethod("toByteArray")
//                                    .invoke(aa[0]).apply {
//                                        val bb: ByteArray = this as ByteArray
////                                        val has256 =
////                                            Class.forName("android.content.pm.SigningDetails")
////                                                .getMethod(
////                                                    "hasSha256Certificate",
////                                                    ByteArray::class.java
////                                                ).invoke(res, bb)
//
//                                        Log.d(TAG, "onCreate: ${bb.size}, ${md.digest().size}")
//                                        Log.d(
//                                            TAG,
//                                            "onCreate: ${
//                                                (Class.forName("android.util.PackageUtils")
//                                                    .getDeclaredMethod(
//                                                        "computeSha256Digest",
//                                                        ByteArray::class.java
//                                                    ).invoke(null, bb) as String).replace(Regex(".."), "$0:").dropLast(1)
//                                            }"
//                                        )
//                                        Log.d(
//                                            TAG,
//                                            "onCreate: ${
//                                                (Class.forName("android.util.PackageUtils")
//                                                    .getDeclaredMethod(
//                                                        "computeSha256Digest",
//                                                        ByteArray::class.java
//                                                    ).invoke(null, bbb) as String).replace(Regex(".."), "$0:").dropLast(1)
//                                            }"
//                                        )
//                                    }
//                            }
////                        Class.forName("android.util.apk.ApkSignatureVerifier\$SigningDetailsWithDigests")
////                            .getField("contentDigests").apply {
//////                                Log.d(TAG, "onCreate: ${this[res]}")
////                        }
//
//                    } else {
//                        Log.d(TAG, "onCreate: error ${invoke(aa)}")
//                    }
//                }
//
////                Log.d(TAG, "onCreate: ${signatureGen.returnType}")
////                signatureGen.invoke()
//
////                it.declaredConstructors.forEach {
////                    Log.d(TAG, "onCreate: declaredConstructors ${it.name}")
////                }
////                it.constructors.forEach {
////                    Log.d(TAG, "onCreate: constructors ${it.name}")
////                }
////                it.declaredMethods.forEach {
////                    Log.d(TAG, "onCreate: declaredMethods ${it.name}, ${it.returnType.name}")
////                }
////                it.methods.forEach {
////                    Log.d(TAG, "onCreate: methods ${it.name}")
////                }
//            }

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun computeSha256Digest(
        data: ByteArray,
    ): String {
        val sha256DigestBytes: ByteArray = computeSha256DigestBytes(data) ?: return ""
        return byteArrayToHex(sha256DigestBytes) ?: ""
    }

    private fun computeSha256DigestBytes(data: ByteArray): ByteArray? {
        val messageDigest: MessageDigest = try {
            MessageDigest.getInstance("SHA256")
        } catch (e: NoSuchAlgorithmException) {
            /* can't happen */
            return null
        }
        messageDigest.update(data)
        return messageDigest.digest()
    }

    private fun PackageInfo.getSignatures(): Array<out Signature> {
        @Suppress("DEPRECATION")
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) signingInfo.apkContentsSigners
        else signatures
    }
}
