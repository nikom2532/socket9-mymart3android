/*
 * 
 */
package au.com.mymart3.mymartandroid.config;
  
import java.io.UnsupportedEncodingException;

import java.security.AlgorithmParameters;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.Security;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.Mac;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import android.os.Bundle;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.app.Dialog;
import android.util.Base64;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import au.com.mymart3.mymartandroid.config.ConfigManager;
import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.LogManager;
import au.com.mymart3.mymartandroid.library.LogFactory;
import au.com.mymart3.mymartandroid.library.EncryptionConverter;
import au.com.mymart3.mymartandroid.models.AuthenticateModel;
import au.com.mymart3.mymartandroid.webapis.BaseAPI;
import static junit.framework.Assert.*;
import android.view.View.OnClickListener;
import android.content.DialogInterface;
import android.content.Intent;
import android.app.AlertDialog;
import android.content.DialogInterface;
import au.com.mymart3.mymartandroid.R;

// TODO: Auto-generated Javadoc
/**
 * The Class MainActivity.
 */
public class MainActivity extends Activity {
	
	/** The Constant log. */
	private static final LogManager log = LogFactory.getLog(MainActivity.class);
	
	/** The m context. */
	private Activity mContext;
	
	/* (non-Javadoc)
	 * @see android.app.Activity#onCreate(android.os.Bundle)
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		// Initial val
		mContext = this;
		ConfigManager.Init(this);
		
		//testBase64();
		//testEncryption();
		//testHMACSHA256();

		//assertEquals("stirling.admin", "stirling.admin");
	}

    /* (non-Javadoc)
     * @see android.app.Activity#onStart()
     */
    @Override
    protected void onStart() {
        super.onStart();
        
        // Use ActivitySelector to start sub activity 
        ActivitySelector.Init(mContext);
	}
    
    /* (non-Javadoc)
     * @see android.app.Activity#onStop()
     */
    @Override  
    public void onStop() {    
    	super.onStop();
    }

    /* (non-Javadoc)
     * @see android.app.Activity#onActivityResult(int, int, android.content.Intent)
     */
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		finish();
		ActivitySelector.Clean();
    }
        
	/* (non-Javadoc)
	 * @see android.app.Activity#onCreateOptionsMenu(android.view.Menu)
	 */
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		
		return true;
	}
	
	/**
	 * Test encryption.
	 */
	public void testEncryption()
	{
	    ///Arrange
	    String UsernameHex = "922eee08472fe5878ce3322121f45af8"; ///Hex String for Encrypted Username
	    String KnownIV = "b76ed59093c35f251322dcc6063d3bd2"; ///Hex String for IV
	    byte[] ExpectedUsernameData = EncryptionConverter.toByte(UsernameHex);
	    String ExpectedUsername = EncryptionConverter.toBase64(ExpectedUsernameData);
	    
	    String key = "0DB03F0B8D734F339A22E1FCC31D85BC";
	    String username = "stirling.admin";
	    
	    byte[] KnowIVData = EncryptionConverter.toByte(KnownIV);
	    byte[] keyData = null;
		try {
			keyData = key.getBytes("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		};
	    

	    ///Act
	    byte[] Result = aesEncrypt(username.getBytes(),keyData,KnowIVData);
	    String actualData = EncryptionConverter.toBase64(Result);

	    ///Assert
	    if(!actualData.equals(ExpectedUsername)) 
	    {
	    	log.debug("Failed to meet encryption expectation :"+actualData+","+ExpectedUsername);
	    }
	    else log.debug("Encryption pass");
	    
	    //log.debug(actualData+","+ExpectedUsername);
	}

	/**
	 * Aes encrypt.
	 *
	 * @param data
	 * @param key
	 * @param iv
	 * @return byte[]
	 */
	public byte[] aesEncrypt(byte[] data, byte[] key,byte[] iv)
	{
	    // check length of key and iv
	    if (iv.length != 16) {
	    	log.debug("Length of iv is wrong. Length of iv should be 16(128bits)");
	    	return null;
	    }
	    if (key.length != 16 && key.length != 24 && key.length != 32 ) {
	    	log.debug("Length of key is wrong. Length of iv should be 16, 24 or 32(128, 192 or 256bits)");
	    	return null;
	    }
	    	    	    	    
		// do encrypt
		byte[] encrypted = null;
	    SecretKeySpec keySpec = new SecretKeySpec(key, "AES");

	    try {
	        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS7Padding");
	        cipher.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv));

	        encrypted = new byte[cipher.getOutputSize(data.length)];
	        int ctLength = cipher.update(data, 0, data.length, encrypted, 0);
	        ctLength += cipher.doFinal(encrypted, ctLength);
	    } catch (Exception e) {
	        log.debug(e.getMessage());
	    } 
	        
	    return encrypted;
	}


	/**
	 * Test base64.
	 */
	public void testBase64()
	{
	    ///Arrange
	    String DataHex = "922eee08472fe5878ce3322121f45af8"; ///Hex String for Encrypted Username
	    byte[] DataToEncode = EncryptionConverter.toByte(DataHex);
	    String ExpectedBase64 = "ki7uCEcv5YeM4zIhIfRa-A2";
	    
	    ///Act
	    String actualBase64 = EncryptionConverter.toBase64(DataToEncode);
	
	
	    ///Assert
	    if(!actualBase64.equals(ExpectedBase64)) log.debug("Failed to meet base64 expectation");
	    else log.debug("base64 pass");
	}
	
	/**
	 * Test hmacsh a256.
	 */
	public void testHMACSHA256()
	{
	    ///Arrange
	    String QueryString = "username=t-oaJVHJJcPK3g1lNocZVg2&password=0Qr4rTcnd6EhhjYTV0WvQA2&useriv=AgICAgICBQsLCwsLCwgI1w2&passiv=Dw_Z2Q8PAwOQ-PgFBAQEBA2&requestdatetime=2013-04-07T06:00:50.001Z";
	    String PrivateKey = "C48BC385-25F5-4CAD-BD2C-7EEA72546FF7";
	    String KnownUTF8String = "HAVySi0tNeEtzgodyG7CsgoaHpNrT3OBG21aYy0g2UY1";
	    
	    ///Act
	    //CocoaSecurityResult *aa = [CocoaSecurity hmacSha256:QueryString hmacKey:PrivateKey];
	    //NSLog(@"A : %@",[[[aa hexLower]hexToBytes]base64EncodedString]);
	
	    byte[] aa = hmacSha256(QueryString.getBytes(),PrivateKey);
	    
	
	    String actualHex = EncryptionConverter.toHexLower(aa);
	    //String actualHexB64 = MyMartCrypto.toBase64(actualHex.getBytes());
	    String actualHexB64 = EncryptionConverter.toBase64(aa);
	    
	    //String actualHexB64 = MyMartCrypto.toBase64(MyMartCrypto.toByte(actualHex));
	    //String actualHexB64 = actualHex;

	    ///Assert
	    //NSAssert(actualHexB64 != KnownUTF8String, @"Failed to meet HMAC expectation");
	    if(!actualHexB64.equals(KnownUTF8String)) log.debug("Failed to meet HMAC expectation");
	    else log.debug("HMAC pass");
	    
	    log.debug(actualHexB64+":"+actualHexB64.length()+","+KnownUTF8String+":"+KnownUTF8String.length());
	    //log.debug(MyMartCrypto.toBase64(MyMartCrypto.toByte(KnownUTF8String)));
	    //log.debug(actualHex);
	}
	
	/**
	 * Hmac sha256.
	 *
	 * @param hashData the hash data
	 * @param key the key
	 * @return the byte[]
	 */
	public byte[] hmacSha256(byte[] hashData,String key)
	{
	    Mac mac;
	    byte[] result = null;	    
	    byte[] keyData = null;
	    try {
			keyData = key.getBytes();
		    SecretKeySpec sk = new SecretKeySpec(keyData,"HMACSHA256");
		    mac = Mac.getInstance("HMACSHA256");
		    mac.init(sk);
		    result = mac.doFinal(hashData);
		}  catch (Exception e) {
	        log.debug(e.getMessage());
	    } 

	    return result;
	    /*
	    unsigned char *digest;
	    digest = malloc(CC_SHA256_DIGEST_LENGTH);
	    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];

	    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
	    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
	    free(digest);
	    cKey = nil;
	    
	    return result;*/
	}
	
}
