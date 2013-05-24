using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.VisualStudio.TestPlatform.UnitTestFramework;
using MyMart.Library;

namespace MyMartTest
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void testGetDeviceID()
        {
            //Arrange

            //Act
            string deviceID = Helper.generateDeviceID();

            //Assert
            Assert.IsTrue(deviceID.Length > 0);
        }

        [TestMethod]
        public void testEncryptionAES()
        {
            //Arrange
            string plainText = "stirling.admin";
            string key = "0DB03F0B8D734F339A22E1FCC31D85BC";
            string iv = "gVgjwY45IBElCPuwYQ04uw==";
            string expectEncryptedText = "1HgFSbQ/Mge3rVllctg40g==";

            //Act
            string encryptedText = Helper.encryptAES(plainText, key, ref iv);

            //Assert
            Assert.IsTrue(encryptedText == expectEncryptedText);
        }

        [TestMethod]
        public void testBase64()
        {
            //Arrange
            string dataHex = "922eee08472fe5878ce3322121f45af8";             
            byte[] dataToEncode = Encoding.UTF8.GetBytes(dataHex);
            String expectedBase64 = "OTIyZWVlMDg0NzJmZTU4NzhjZTMzMjIxMjFmNDVhZjg=";

            //Act
            string actualBase64 = Convert.ToBase64String(dataToEncode);

            //Assert
            Assert.IsTrue(actualBase64 == expectedBase64);
        }

        [TestMethod]
        public void testHMACSHA256()
        {
            // /Arrange
            string queryString = "username=t-oaJVHJJcPK3g1lNocZVg2&password=0Qr4rTcnd6EhhjYTV0WvQA2&useriv=AgICAgICBQsLCwsLCwgI1w2&passiv=Dw_Z2Q8PAwOQ-PgFBAQEBA2&requestdatetime=2013-04-07T06:00:50.001Z";
            string privateKey = "C48BC385-25F5-4CAD-BD2C-7EEA72546FF7";
            string expectHashText = "HAVySi0tNeEtzgodyG7CsgoaHpNrT3OBG21aYy0g2UY=";

            //Act
            string hashText = Helper.hmacSha256(queryString, privateKey);

            //Assert
            Assert.IsTrue(hashText == expectHashText);
        }

        [TestMethod]
        public void testSafeBase64Sring()
        {
            //Arrange
            string base64String = "1HgFSbQ/Mge3rVllctg40g==";
            string expectSafeBase64String = "1HgFSbQ_Mge3rVllctg40g2";

            //Act
            string result = Helper.safeBase64String(base64String);

            //Assert
            Assert.IsTrue(result == expectSafeBase64String);
        }

        [TestMethod]
        public async void testAuthenticateSucess()
        {
            //Arrange
            string username = "stirling.admin";
            string password = "duck121";
            string expectUserID = "bc9ce5ff-1731-457f-bee3-336a99165c22";

            //Act
            AuthenticateJsonResult result = await MyMartService.AuthenWithUsername(username, password);

            //Assert
            Assert.IsTrue(result.UserID == expectUserID);
        }

        [TestMethod]
        public async void testAuthenticateFail()
        {
            //Arrange
            string username = "stirling.admin";
            string password = "duck121x";
            bool expectAuthenticated = false;

            //Act
            AuthenticateJsonResult result = await MyMartService.AuthenWithUsername(username, password);

            //Assert
            Assert.IsTrue(result.Authenticated == expectAuthenticated);
        }

        [TestMethod]
        public async void testAuthenticateNullValue()
        {
            //Arrange
            string username = "";
            string password = "";
            bool expectAuthenticated = false;

            //Act
            AuthenticateJsonResult result = await MyMartService.AuthenWithUsername(username, password);

            //Assert
            Assert.IsTrue(result.Authenticated == expectAuthenticated);
        }

       
    }
}
