using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading.Tasks;
using Windows.Security.Cryptography;
using Windows.Security.Cryptography.Core;
using Windows.Storage.Streams;

namespace MyMart.Library
{
    public static class Helper
    {
        #region save code
        //public static string encryptAES(string plainText, out string iv)
        //{
        //    string aesKey = LocalSetting.PrivateAESKey;
        //    byte[] aesKeyBytes = Encoding.UTF8.GetBytes(aesKey);
        //    byte[] plainTextBytes = Encoding.UTF8.GetBytes(plainText);

        //    SymmetricKeyAlgorithmProvider SAP = SymmetricKeyAlgorithmProvider.OpenAlgorithm(SymmetricAlgorithmNames.AesCbcPkcs7);
        //    CryptographicKey AES;
        //    HashAlgorithmProvider HAP = HashAlgorithmProvider.OpenAlgorithm(HashAlgorithmNames.Md5);
        //    CryptographicHash Hash_AES = HAP.CreateHash();

        //    string ivTemp = Guid.NewGuid().ToString();
        //    byte[] ivBytes = new byte[16];
        //    Hash_AES.Append(CryptographicBuffer.CreateFromByteArray(Encoding.UTF8.GetBytes(ivTemp)));
        //    byte[] ivTempBytes;
        //    CryptographicBuffer.CopyToByteArray(Hash_AES.GetValueAndReset(), out ivTempBytes);
        //    Array.Copy(ivTempBytes, 0, ivBytes, 0, 16);

        //    AES = SAP.CreateSymmetricKey(CryptographicBuffer.CreateFromByteArray(aesKeyBytes));
        //    IBuffer plainTextBuffer = CryptographicBuffer.CreateFromByteArray(plainTextBytes);
        //    IBuffer ivBuffer = CryptographicBuffer.CreateFromByteArray(ivBytes);
        //    string encryptedText = CryptographicBuffer.EncodeToBase64String(CryptographicEngine.Encrypt(AES, plainTextBuffer, ivBuffer));

        //    iv = safeBase64String(Convert.ToBase64String(ivBytes));
        //    return safeBase64String(encryptedText);

        //}

        //public static string decryptAES(string encryptedText, string iv)
        //{
        //    string aesKey = LocalSetting.PrivateAESKey;
        //    byte[] aesKeyBytes = Encoding.UTF8.GetBytes(aesKey);

        //    SymmetricKeyAlgorithmProvider SAP = SymmetricKeyAlgorithmProvider.OpenAlgorithm(SymmetricAlgorithmNames.AesCbcPkcs7);
        //    CryptographicKey AES;
        //    HashAlgorithmProvider HAP = HashAlgorithmProvider.OpenAlgorithm(HashAlgorithmNames.Md5);
        //    CryptographicHash Hash_AES = HAP.CreateHash();

        //    AES = SAP.CreateSymmetricKey(CryptographicBuffer.CreateFromByteArray(aesKeyBytes));

        //    IBuffer encryptedTextBuffer = CryptographicBuffer.DecodeFromBase64String(encryptedText);
        //    IBuffer ivBuffer = CryptographicBuffer.DecodeFromBase64String(iv);
        //    byte[] decryptedBytes;
        //    CryptographicBuffer.CopyToByteArray(CryptographicEngine.Decrypt(AES, encryptedTextBuffer, ivBuffer), out decryptedBytes);
        //    string decryptedText = Encoding.UTF8.GetString(decryptedBytes, 0, decryptedBytes.Length);

        //    return decryptedText;

        //}
        #endregion

        /// <summary>
        /// 
        /// </summary>
        /// <param name="plainText"></param>
        /// <param name="iv">base64string</param>
        /// <returns></returns>
        public static string encryptAES(string plainText, ref string iv)
        {
            return encryptAES(plainText, LocalSetting.PrivateAESKey, ref iv);          
        }

        public static string encryptAES(string plainText, string key, ref string iv)
        {
            byte[] aesKeyBytes = Encoding.UTF8.GetBytes(key);
            byte[] plainTextBytes = Encoding.UTF8.GetBytes(plainText);

            if (iv == "") iv = generateIV();
            byte[] ivBytes = Convert.FromBase64String(iv);

            SymmetricKeyAlgorithmProvider SAP = SymmetricKeyAlgorithmProvider.OpenAlgorithm(SymmetricAlgorithmNames.AesCbcPkcs7);
            CryptographicKey AES = SAP.CreateSymmetricKey(CryptographicBuffer.CreateFromByteArray(aesKeyBytes));
            IBuffer plainTextBuffer = CryptographicBuffer.CreateFromByteArray(plainTextBytes);
            IBuffer ivBuffer = CryptographicBuffer.CreateFromByteArray(ivBytes);
            return CryptographicBuffer.EncodeToBase64String(CryptographicEngine.Encrypt(AES, plainTextBuffer, ivBuffer));
        }
        
        public static string decryptAES(string encryptedText, string iv)
        {
            byte[] aesKeyBytes = Encoding.UTF8.GetBytes(LocalSetting.PrivateAESKey);
            
            SymmetricKeyAlgorithmProvider SAP = SymmetricKeyAlgorithmProvider.OpenAlgorithm(SymmetricAlgorithmNames.AesCbcPkcs7);            
            CryptographicKey AES = SAP.CreateSymmetricKey(CryptographicBuffer.CreateFromByteArray(aesKeyBytes));
            IBuffer encryptedTextBuffer = CryptographicBuffer.DecodeFromBase64String(encryptedText);
            IBuffer ivBuffer = CryptographicBuffer.DecodeFromBase64String(iv);
            byte[] decryptedBytes;
            CryptographicBuffer.CopyToByteArray(CryptographicEngine.Decrypt(AES, encryptedTextBuffer, ivBuffer), out decryptedBytes);
            return Encoding.UTF8.GetString(decryptedBytes, 0, decryptedBytes.Length);

        }

        public static string hmacSha256(string plainText)
        {
            return hmacSha256(plainText, LocalSetting.PrivateHMACKey);
        }

        public static string hmacSha256(string plainText, string key)
        {
            // Create a MacAlgorithmProvider object for the specified algorithm.
            MacAlgorithmProvider objMacProv = MacAlgorithmProvider.OpenAlgorithm(MacAlgorithmNames.HmacSha256);

            // Create a buffer that contains the message to be signed.
            IBuffer valueBuffer = CryptographicBuffer.ConvertStringToBinary(plainText, BinaryStringEncoding.Utf8);

            // Create a key to be signed with the message.
            IBuffer buffKeyMaterial = CryptographicBuffer.ConvertStringToBinary(key, BinaryStringEncoding.Utf8);
            CryptographicKey cryptographicKey = objMacProv.CreateKey(buffKeyMaterial);

            // Sign the key and message together.
            IBuffer bufferProtected = CryptographicEngine.Sign(cryptographicKey, valueBuffer);

            DataReader dataReader = DataReader.FromBuffer(bufferProtected);
            byte[] bytes = new byte[bufferProtected.Length];
            dataReader.ReadBytes(bytes);

            return Convert.ToBase64String(bytes);
        }

        public static string safeBase64String(string base64String)
        {
            //replace on the character + and replace it with a – (minus sign)
            string result = base64String.Replace("+", "-");

            //replace the character / with a _ (underscore)
            result = result.Replace("/", "_");

            //replace the character \n with empty
            result = result.Replace("\n", "");

            //replace the character = with count number
            int count = countOccurrences(result, '=');
            result = result.Replace("=", "");
            result = result + count.ToString();

            return result;
        }

        public static int countOccurrences(String haystack, char needle)
        {
            int count = 0;
            for (int i = 0; i < haystack.Length; i++)
            {
                if (haystack[i] == needle)
                {
                    count++;
                }
            }
            return count;
        }

        public static string getRequestDateTime()
        {
            return string.Format("{0:yyyy-MM-ddTHH:mm:ss.FFFZ}", DateTime.UtcNow);
        }

        public static string generateDeviceID()
        {
            return Guid.NewGuid().ToString();
        }

        public static byte[] HexStringToHexByteArray(string s)
        {
            byte[] ab = new byte[s.Length >> 1];
            for (int i = 0; i < s.Length; i++)
            {
                int b = s[i] - 55;
                b = b + (((b - 2) >> 31) & 7);
                ab[i >> 1] |= (byte)(b << 4 * ((i & 1) ^ 1));
            }
            return ab;
        }

        public static string HexByteArrayToHexString(byte[] ba)
        {
            return string.Concat(ba.SelectMany(b => new int[] { b >> 4, b & 0xF }).Select(b => (char)(55 + b + (((b - 10) >> 31) & -7))));
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns>IV with base64string</returns>
        public static string generateIV()
        {
            HashAlgorithmProvider HAP = HashAlgorithmProvider.OpenAlgorithm(HashAlgorithmNames.Md5);
            CryptographicHash Hash_AES = HAP.CreateHash();

            string ivTemp = Guid.NewGuid().ToString();
            byte[] ivBytes = new byte[16];
            Hash_AES.Append(CryptographicBuffer.CreateFromByteArray(Encoding.UTF8.GetBytes(ivTemp)));
            byte[] ivTempBytes;
            CryptographicBuffer.CopyToByteArray(Hash_AES.GetValueAndReset(), out ivTempBytes);
            Array.Copy(ivTempBytes, 0, ivBytes, 0, 16);
            return Convert.ToBase64String(ivBytes);
        }
    }
}
