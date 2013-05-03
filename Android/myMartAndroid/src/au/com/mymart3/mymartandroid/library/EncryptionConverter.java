/*
 * 
 */
package au.com.mymart3.mymartandroid.library;

//http://stackoverflow.com/questions/6486121/aes-encryption-in-java
//http://stackoverflow.com/questions/10759392/java-aes-encryption-and-decryption
//http://stackoverflow.com/questions/992019/java-256-bit-aes-password-based-encryption
//http://www.javamex.com/tutorials/cryptography/aes_block_ciphers.shtml
import java.io.UnsupportedEncodingException;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import android.util.Base64;
import au.com.mymart3.mymartandroid.config.Constants;

// TODO: Auto-generated Javadoc
/**
 * Encryption Converter Class: To convert the Encryption.
 */
public class EncryptionConverter {
	
	/** The Constant log. */
	private static final LogManager log = LogFactory.getLog(EncryptionConverter.class);
	
	/**
	 * The Class Result.
	 */
	public static class Result
	{
		
		/** The result. */
		public String result = null;
		
		/** The iv. */
		public String iv = null;
	}
	
    /**
     * Encrypt.
     *
     * @param cleartext the cleartext
     * @return result
     * @throws Exception the exception
     */
    public static Result encrypt(String cleartext) throws Exception {
    	Result result = new Result();
    	
    	byte[] rawKey = null;
    	try {
    		rawKey = Constants.PrivateAESKey.getBytes("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		};
    	
        SecretKeySpec skeySpec = new SecretKeySpec(rawKey, "AES");
        //String KnownIV = "b76ed59093c35f251322dcc6063d3bd2";
        byte [] iv = getIV();
        
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS7Padding");
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec, new IvParameterSpec(iv));
        
        byte[] codeText = cipher.doFinal(cleartext.getBytes());

        result.result = toBase64(codeText);
        result.iv = toBase64(iv); 
        return result;
        //decoding byte array into base64
        //byte[] decoded = Base64.decodeBase64(encoded);       
        //System.out.println("Base 64 Decoded  String : " + new String(decoded));
        //Read more: http://javarevisited.blogspot.com/2012/02/how-to-encode-decode-string-in-java.html
    }
    
    /**
     * Encrypt.
     *
     * @param seed the seed
     * @param cleartext the cleartext
     * @return the string
     * @throws Exception the exception
     */
    public static String encrypt(String seed, String cleartext) throws Exception {
        byte[] rawKey = getRawKey(seed.getBytes());
        byte[] result = encrypt(rawKey, cleartext.getBytes());
        return toHex(result);
    }
    
    /**
     * Decrypt.
     *
     * @param seed the seed
     * @param encrypted the encrypted
     * @return the string
     * @throws Exception the exception
     */
    public static String decrypt(String seed, String encrypted) throws Exception {
        byte[] rawKey = getRawKey(seed.getBytes());
        byte[] enc = toByte(encrypted);
        byte[] result = decrypt(rawKey, enc);
        return new String(result);
    }

    /**
     * Gets the iv.
     *
     * @return the iv
     * @throws Exception the exception
     */
    private static byte[] getIV() throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);
        SecretKey skey = kgen.generateKey();
        byte[] raw = skey.getEncoded();
        return raw;
    }

    /**
     * Gets the raw key.
     *
     * @param seed the seed
     * @return the raw key
     * @throws Exception the exception
     */
    private static byte[] getRawKey(byte[] seed) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
        sr.setSeed(seed);
        kgen.init(128, sr); // 192 and 256 bits may not be available
        SecretKey skey = kgen.generateKey();
        byte[] raw = skey.getEncoded();
        return raw;
    }


    /**
     * Encrypt.
     *
     * @param raw the raw
     * @param clear the clear
     * @return the byte[]
     * @throws Exception the exception
     */
    private static byte[] encrypt(byte[] raw, byte[] clear) throws Exception {
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
        byte[] encrypted = cipher.doFinal(clear);
        return encrypted;
    }

    /**
     * Decrypt.
     *
     * @param raw the raw
     * @param encrypted the encrypted
     * @return the byte[]
     * @throws Exception the exception
     */
    private static byte[] decrypt(byte[] raw, byte[] encrypted) throws Exception {
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, skeySpec);
        byte[] decrypted = cipher.doFinal(encrypted);
        return decrypted;
    }

    /**
     * To hex.
     *
     * @param txt the txt
     * @return the string
     */
    public static String toHex(String txt) {
        return toHex(txt.getBytes());
    }
    
    /**
     * From hex.
     *
     * @param hex the hex
     * @return the string
     */
    public static String fromHex(String hex) {
        return new String(toByte(hex));
    }

    /**
     * To byte.
     *
     * @param hexString the hex string
     * @return the byte[]
     */
    public static byte[] toByte(String hexString) {
        int len = hexString.length()/2;
        byte[] result = new byte[len];
        for (int i = 0; i < len; i++)
            result[i] = Integer.valueOf(hexString.substring(2*i, 2*i+2), 16).byteValue();
        return result;
    }

    /**
     * To hex.
     *
     * @param buf the buf
     * @return the string
     */
    public static String toHex(byte[] buf) {
        if (buf == null)
            return "";
        StringBuffer result = new StringBuffer(2*buf.length);
        for (int i = 0; i < buf.length; i++) {
            appendHex(result, buf[i]);
        }
        return result.toString();
    }
    
    /** The Constant HEX. */
    private final static String HEX = "0123456789ABCDEF";
    
    /**
     * Append hex.
     *
     * @param sb the sb
     * @param b the b
     */
    private static void appendHex(StringBuffer sb, byte b) {
        sb.append(HEX.charAt((b>>4)&0x0f)).append(HEX.charAt(b&0x0f));
    }

    /**
     * To hex lower.
     *
     * @param buf the buf
     * @return the string
     */
    public static String toHexLower(byte[] buf) {
        if (buf == null)
            return "";
        StringBuffer result = new StringBuffer(2*buf.length);
        for (int i = 0; i < buf.length; i++) {
            appendHexLower(result, buf[i]);
        }
        return result.toString();
    }
    
    /** The Constant HEXLOWER. */
    private final static String HEXLOWER = "0123456789abcdef";
    
    /**
     * Append hex lower.
     *
     * @param sb the sb
     * @param b the b
     */
    private static void appendHexLower(StringBuffer sb, byte b) {
        sb.append(HEXLOWER.charAt((b>>4)&0x0f)).append(HEXLOWER.charAt(b&0x0f));
    }

    
    /**
     * Count occurrences.
     *
     * @param haystack the haystack
     * @param needle the needle
     * @return the int
     */
    public static int countOccurrences(String haystack, char needle)
    {
        int count = 0;
        for (int i=0; i < haystack.length(); i++)
        {
            if (haystack.charAt(i) == needle)
            {
                 count++;
            }
        }
        return count;
    }
    
    /**
     * To base64.
     *
     * @param buf the buf
     * @return the string
     */
    public static String toBase64(byte[] buf) {
        if (buf == null)
            return "";
        String result = new String(Base64.encode(buf,0));
        result = result.replace("+", "-");
        result = result.replace("/", "_");
        result = result.replace("\n", "");
        int count = countOccurrences(result, '=');
        result = result.replace("=", "");
        StringBuilder newResult = new StringBuilder(result);
        newResult.append(count);
        return newResult.toString();
    }    
    
    
    
	/**
	 * Hmac sha256.
	 *
	 * @param data the data
	 * @return the string
	 */
	public static String hmacSha256(String data)
	{
		byte[] hashData = null;
	    Mac mac;
	    byte[] result = null;	    
	    byte[] keyData = null;
	    try {
	    	hashData = data.getBytes("UTF8");
			keyData = Constants.PrivateHMACKey.getBytes();
		    SecretKeySpec sk = new SecretKeySpec(keyData,"HMACSHA256");
		    mac = Mac.getInstance("HMACSHA256");
		    mac.init(sk);
		    result = mac.doFinal(hashData);
		}  catch (Exception e) {
	        log.debug(e.getMessage());
	    } 
	    return toBase64(result);
	}
}
