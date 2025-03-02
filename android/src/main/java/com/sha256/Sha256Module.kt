package com.sha256

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.module.annotations.ReactModule
import java.io.UnsupportedEncodingException
import java.nio.charset.StandardCharsets
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

@ReactModule(name = Sha256Module.NAME)
class Sha256Module(reactContext: ReactApplicationContext) : NativeSha256Spec(reactContext) {

  override fun getName(): String {
    return NAME
  }

  private fun readableArrayToByteArray(readableArray: ReadableArray): ByteArray {
    return ByteArray(readableArray.size()) { readableArray.getInt(it).toByte() }
  }

  @Throws(NoSuchAlgorithmException::class, UnsupportedEncodingException::class)
  private fun buildHash(toHash: String, algo: String, length: Int): String {
    val md = MessageDigest.getInstance(algo)
    md.update(toHash.toByteArray(StandardCharsets.UTF_8))
    val digest = md.digest()
    return String.format("%0${length}x", java.math.BigInteger(1, digest))
  }

  @Throws(NoSuchAlgorithmException::class, UnsupportedEncodingException::class)
  private fun buildHashWithBytes(toHash: ReadableArray, algo: String, length: Int): String {
    val md = MessageDigest.getInstance(algo)
    val arr = readableArrayToByteArray(toHash)
    md.update(arr)
    val digest = md.digest()
    return String.format("%0${length}x", java.math.BigInteger(1, digest))
  }

  override fun sha256(toHash: String): String {
    try {
      val hash = buildHash(toHash, "SHA-256", 64)
      return hash
    } catch (e: Exception) {
      throw e
    }
  }

  override fun sha256Bytes(toHash: ReadableArray): String {
    try {
      val hash = buildHashWithBytes(toHash, "SHA-256", 64)
      return hash
    } catch (e: Exception) {
      throw e
    }
  }

  override fun sha1(toHash: String): String {
    try {
      val hash = buildHash(toHash, "SHA-1", 40)
      return hash
    } catch (e: Exception) {
      throw e
    }
  }

  override fun sha1Bytes(toHash: ReadableArray): String {
    try {
      val hash = buildHashWithBytes(toHash, "SHA-1", 40)
      return hash
    } catch (e: Exception) {
      throw e
    }
  }

  companion object {
    const val NAME = "Sha256"
  }
}
