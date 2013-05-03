package au.com.mymart3.mymartandroid.test;

import java.io.UnsupportedEncodingException;
import java.util.UUID;
import java.util.concurrent.DelayQueue;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import javax.crypto.Cipher;
import javax.crypto.Mac;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import junit.framework.TestCase;

import android.app.Activity;
import android.content.Context;
import android.os.AsyncTask;
import android.provider.Settings.Secure;
import android.test.ActivityInstrumentationTestCase2;
import android.util.Log;
import android.view.KeyEvent;
import android.widget.EditText;
import android.widget.TextView;
import android.content.Context;
import android.telephony.TelephonyManager;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.database.SQLException;
import android.provider.Settings.Secure;

import au.com.mymart3.mymartandroid.*;
import au.com.mymart3.mymartandroid.config.*;
import au.com.mymart3.mymartandroid.controller.*;
import au.com.mymart3.mymartandroid.library.*;
import au.com.mymart3.mymartandroid.models.*;
import au.com.mymart3.mymartandroid.models.AuthenticateModel.AuthenticateTask;
import au.com.mymart3.mymartandroid.testModel.*;
//import au.com.mymart3.mymartandroid.mock.*;

public class LogicTest extends TestCase

{

	// initial Class from myMart

	AuthenticateModel mAuthenticate = new AuthenticateModel();
	LoginUserActivity mLoginUserActivity = new LoginUserActivity();
	RegisterDeviceQuickPinModel mRegisterDeviceQuickPin = new RegisterDeviceQuickPinModel();
	AuthenticateDeviceQuickPinModel mAuthenticateDeviceQuickPin = new AuthenticateDeviceQuickPinModel();
	
	// Test Case SetUp

	@Override
	protected void setUp() throws Exception {
		super.setUp();
	}

	protected void tearDown() throws Exception {
		super.tearDown();
	}

	// Test Case Instruction

	public void TestGetDeviceID() {
		assertTrue(ConfigManager.getDeviceID.length() <= 0);
	}

	public void testEncryption() {
		// /Arrange
		String UsernameHex = "922eee08472fe5878ce3322121f45af8"; // /Hex String
																	// for
																	// Encrypted
																	// Username
		String KnownIV = "b76ed59093c35f251322dcc6063d3bd2"; // /Hex String for
																// IV
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

		// /Act
		byte[] Result = aesEncrypt(username.getBytes(), keyData, KnowIVData);
		String actualData = EncryptionConverter.toBase64(Result);
	}

	public byte[] aesEncrypt(byte[] data, byte[] key, byte[] iv) {
		// check length of key and iv
		if (iv.length != 16) {
			// log.debug("Length of iv is wrong. Length of iv should be 16(128bits)");
			return null;
		}
		if (key.length != 16 && key.length != 24 && key.length != 32) {
			// log.debug("Length of key is wrong. Length of iv should be 16, 24 or 32(128, 192 or 256bits)");
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
			assertTrue(ctLength!=0);		
		} catch (Exception e) {
			// log.debug(e.getMessage());
		}
		return encrypted;
	}

	public void testBase64() {
		// /Arrange
		String DataHex = "922eee08472fe5878ce3322121f45af8"; // /Hex String for
																// Encrypted
																// Username
		byte[] DataToEncode = EncryptionConverter.toByte(DataHex);
		String ExpectedBase64 = "ki7uCEcv5YeM4zIhIfRa-A2";

		// /Act
		String actualBase64 = EncryptionConverter.toBase64(DataToEncode);

	}

	public void testHMACSHA256() {
		// /Arrange
		String QueryString = "username=t-oaJVHJJcPK3g1lNocZVg2&password=0Qr4rTcnd6EhhjYTV0WvQA2&useriv=AgICAgICBQsLCwsLCwgI1w2&passiv=Dw_Z2Q8PAwOQ-PgFBAQEBA2&requestdatetime=2013-04-07T06:00:50.001Z";
		String PrivateKey = "C48BC385-25F5-4CAD-BD2C-7EEA72546FF7";
		String KnownUTF8String = "HAVySi0tNeEtzgodyG7CsgoaHpNrT3OBG21aYy0g2UY1";

		byte[] aa = hmacSha256(QueryString.getBytes(), PrivateKey);

		String actualHex = EncryptionConverter.toHexLower(aa);
		String actualHexB64 = EncryptionConverter.toBase64(aa);

	}

	public byte[] hmacSha256(byte[] hashData, String key) {
		Mac mac;
		byte[] result = null;
		byte[] keyData = null;
		try {
			keyData = key.getBytes();
			SecretKeySpec sk = new SecretKeySpec(keyData, "HMACSHA256");
			mac = Mac.getInstance("HMACSHA256");
			mac.init(sk);
			result = mac.doFinal(hashData);
		} catch (Exception e) {
			
		}

		return result;
	}
	
//	public void testNotnull(){
//		assertNotNull(username, mLoginUserActivity);
//		assertNotNull(password, mLoginUserActivity);
//	}
	
//	public void testRegisterDeviceQuickPin(){
//		mRegisterDeviceQuickPin.RegisterDeviceQuickPin(
//				"bc9ce5ff-1731-457f-bee3-336a99165c22", "1234", 
//				ConfigManager.getDeviceID, true
//				);
//	}
	
	public void testAuthenticateSucess(){
		
		// tell the mock object what value we expect
		AuthenticateMock authenMock = new AuthenticateMock("{\"AuthenticateJsonResult\":{\"Authenticated\":true,\"ExceptionMessage\":null,\"UserID\":\"bc9ce5ff-1731-457f-bee3-336a99165c22\"}}");
		AuthenticateModel authenModel = new AuthenticateModel(authenMock);
		
		AsyncTask asyncTask = authenModel.authenticate("", "");
		try {
			asyncTask.get(10, TimeUnit.SECONDS);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		} catch (ExecutionException e1) {
			e1.printStackTrace();
		} catch (TimeoutException e1) {
			e1.printStackTrace();
		}
		
		if(authenModel.userID.equals("bc9ce5ff-1731-457f-bee3-336a99165c22")){
			assertTrue(true);
		}
		else{
			assertTrue(false);
		}
	}
	
	public void testAuthenticateFail(){
		
		// tell the mock object what value we expect
		AuthenticateMock authenMock = new AuthenticateMock("{\"AuthenticateJsonResult\":{\"Authenticated\":false,\"ExceptionMessage\":\"Username or password is incorrect.\",\"UserID\":null}}");
		AuthenticateModel authenModel = new AuthenticateModel(authenMock);
		AsyncTask asyncTask = authenModel.authenticate("", "");
		
		try {
			asyncTask.get(10, TimeUnit.SECONDS);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		} catch (ExecutionException e1) {
			e1.printStackTrace();
		} catch (TimeoutException e1) {
			e1.printStackTrace();
		}
		
		if(authenModel.Authenticated == false){
			assertTrue(true);	
		}
		else{
			assertTrue(false);
		}
	}
	
	public void testAuthenticateNullValue(){
		
		// tell the mock object what value we expect
		AuthenticateMock authenMock = new AuthenticateMock("{\"AuthenticateJsonResult\":{\"Authenticated\":false,\"ExceptionMessage\":\"Unknown Exception Occurred. Error has been logged, and will be looked at.\",\"UserID\":null}}");
		AuthenticateModel authenModel = new AuthenticateModel(authenMock);
		AsyncTask asyncTask = authenModel.authenticate("", "");
		
		try {
			asyncTask.get(10, TimeUnit.SECONDS);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		} catch (ExecutionException e1) {
			e1.printStackTrace();
		} catch (TimeoutException e1) {
			e1.printStackTrace();
		}
		
		if(authenModel.Authenticated == false){
			assertTrue(true);	
		}
		else{
			assertTrue(false);
		}
	}
	
	
	//Note !!!
	//Not fill all, except QuickPinAuthenticate ----> cannot test b/c User is already register, so dont know what is Pin ID?????
	public void testAuthenticateDeviceQuickPinSucess(){
		
		// tell the mock object what value we expect
		AuthenticateDeviceQuickPinMock authenMock = new AuthenticateDeviceQuickPinMock("{\"AuthenticateDeviceQuickPinJsonResult\":{\"Authenticated\":false,\"ExceptionMessage\":\"Incorrect Quick Pin\",\"UserID\":null}}");
		AuthenticateDeviceQuickPinModel authenModel = new AuthenticateDeviceQuickPinModel(authenMock);
		
		AsyncTask asyncTask = authenModel.AuthenticateDeviceQuickPin("", "");
		try {
			asyncTask.get(10, TimeUnit.SECONDS);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		} catch (ExecutionException e1) {
			e1.printStackTrace();
		} catch (TimeoutException e1) {
			e1.printStackTrace();
		}
		
		if(authenModel.userID.equals("bc9ce5ff-1731-457f-bee3-336a99165c22")){
			assertTrue(true);
		}
		else{
			assertTrue(false);
		}
	}
	
	public void testAuthenticateDeviceQuickPinFail(){
		
		// tell the mock object what value we expect
		AuthenticateDeviceQuickPinMock authenMock = new AuthenticateDeviceQuickPinMock("{\"AuthenticateDeviceQuickPinJsonResult\":{\"Authenticated\":false,\"ExceptionMessage\":\"Incorrect Quick Pin\",\"UserID\":null}}");
		AuthenticateDeviceQuickPinModel authenModel = new AuthenticateDeviceQuickPinModel(authenMock);
		
		AsyncTask asyncTask = authenModel.AuthenticateDeviceQuickPin("", "");
		try {
			asyncTask.get(10, TimeUnit.SECONDS);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		} catch (ExecutionException e1) {
			e1.printStackTrace();
		} catch (TimeoutException e1) {
			e1.printStackTrace();
		}
		
		if(authenModel.authenticated == false){
			assertTrue(true);	
		}
		else{
			assertTrue(false);
		}
	}
	
	public void testAuthenticateDeviceQuickPinNullValue(){
		
		// tell the mock object what value we expect
		AuthenticateDeviceQuickPinMock authenMock = new AuthenticateDeviceQuickPinMock("{\"AuthenticateDeviceQuickPinJsonResult\":{\"Authenticated\":false,\"ExceptionMessage\":\"DataPortal.Update failed (System.ArgumentNullException: Value cannot be null.\\u000d\\u000aParameter name: Quick Pin and Mobile Device ID must not be left blank\\u000d\\u000a   at Schools.Business.DomainModels.Identity.AuthenticateMobileQuickPinUserCommand.DataPortal_Execute() in c:\\\\Build\\\\PublishAzure\\\\AzureBuild\\\\myMARTV3\\\\src\\\\DomainModels.Server\\\\Identity\\\\AuthenticateMobileQuickPinUserCommand.Server.cs:line 73\\u000d\\u000a   at lambda_method(Closure , Object , Object[] )\\u000d\\u000a   at Csla.Reflection.MethodCaller.CallMethod(Object obj, DynamicMethodHandle methodHandle, Object[] parameters) in c:\\\\Build\\\\PublishAzure\\\\AzureBuild\\\\lib\\\\Csla\\\\Csla\\\\Reflection\\\\MethodCaller.cs:line 545)\",\"UserID\":null}}");
		AuthenticateDeviceQuickPinModel authenModel = new AuthenticateDeviceQuickPinModel(authenMock);
		
		AsyncTask asyncTask = authenModel.AuthenticateDeviceQuickPin("", "");
		try {
			asyncTask.get(10, TimeUnit.SECONDS);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		} catch (ExecutionException e1) {
			e1.printStackTrace();
		} catch (TimeoutException e1) {
			e1.printStackTrace();
		}
		
		if(authenModel.authenticated == false){
			assertTrue(true);	
		}
		else{
			assertTrue(false);
		}
	}
	
}
