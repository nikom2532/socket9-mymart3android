using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading.Tasks;

namespace MyMart.Library
{
    public static class MyMartService
    {
        private static async Task<ServiceRequestResult> requestService(string serviceUri)
        {
            using (HttpClient client = new HttpClient())
            {
                HttpResponseMessage response = await client.GetAsync(serviceUri);

                using (var stream = await response.Content.ReadAsStreamAsync())
                {
                    DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(ServiceRequestResult));
                    return serializer.ReadObject(stream) as ServiceRequestResult;
                }
            }
        }

        public static async Task<AuthenticateJsonResult> AuthenWithUsername(string username, string password)
        {
            if (username.Length > 0 && password.Length > 0)
            {
                string useriv = "";
                string passiv = "";
                string usernameEncrypted = Helper.encryptAES(username, ref useriv);
                string passwordEncrypted = Helper.encryptAES(password, ref passiv);
                string requestDateTime = Helper.getRequestDateTime();

                usernameEncrypted = Helper.safeBase64String(usernameEncrypted);
                passwordEncrypted = Helper.safeBase64String(passwordEncrypted);
                useriv = Helper.safeBase64String(useriv);
                passiv = Helper.safeBase64String(passiv);

                string requestParam = string.Format("username={0}&password={1}&useriv={2}&passiv={3}&requestdatetime={4}", usernameEncrypted, passwordEncrypted, useriv, passiv, requestDateTime);
                string signature = Helper.safeBase64String(Helper.hmacSha256(requestParam));

                string serviceUri = string.Format("{0}?{1}&signature={2}", LocalSetting.AuthenWithUsernameURL, requestParam, signature);

                var authenRequest = await requestService(serviceUri);
                return authenRequest.AuthenticateJsonResult;
            }
            else
            {
                AuthenticateJsonResult result = new AuthenticateJsonResult();
                result.Authenticated = false;
                result.ExceptionMessage = "Username or password invalid";
                return result;
            }
        }

        public static async Task<AuthenticateJsonResult> AuthenWithQuickPin(string quickPin)
        {
            string deviceid = LocalSetting.DeviceID;
            string quickpiniv = "";
            string deviceidiv = "";
            string quickpinEncrypted = Helper.encryptAES(quickPin, ref quickpiniv);
            string deviceidEncrypted = Helper.encryptAES(deviceid, ref deviceidiv);
            string requestDateTime = Helper.getRequestDateTime();

            quickpinEncrypted = Helper.safeBase64String(quickpinEncrypted);
            deviceidEncrypted = Helper.safeBase64String(deviceidEncrypted);
            quickpiniv = Helper.safeBase64String(quickpiniv);
            deviceidiv = Helper.safeBase64String(deviceidiv);

            string requestParam = string.Format("quickpin={0}&deviceid={1}&quickpiniv={2}&deviceidiv={3}&requestdatetime={4}", quickpinEncrypted, deviceidEncrypted, quickpiniv, deviceidiv, requestDateTime);
            string signature = Helper.safeBase64String(Helper.hmacSha256(requestParam));

            string serviceUri = string.Format("{0}?{1}&signature={2}", LocalSetting.AuthenWithQuickPinURL, requestParam, signature);

            var authenRequest = await requestService(serviceUri);
            return authenRequest.AuthenticateDeviceQuickPinJsonResult;
        }

        public static async Task<RegisterDeviceQuickPinJsonResult> RegisterDeviceQuickPin(string quickPin, bool forceOverride)
        {
            string userid = LocalSetting.UserID;
            string deviceid = LocalSetting.DeviceID;
            string quickpiniv = "";
            string deviceidiv = "";
            string quickpinEncrypted = Helper.encryptAES(quickPin, ref quickpiniv);
            string deviceidEncrypted = Helper.encryptAES(deviceid, ref deviceidiv);
            string requestDateTime = Helper.getRequestDateTime();

            quickpinEncrypted = Helper.safeBase64String(quickpinEncrypted);
            deviceidEncrypted = Helper.safeBase64String(deviceidEncrypted);
            quickpiniv = Helper.safeBase64String(quickpiniv);
            deviceidiv = Helper.safeBase64String(deviceidiv);

            string requestParam = string.Format("userid={0}&quickpin={1}&deviceid={2}&quickpiniv={3}&deviceidiv={4}&forceoverride={5}&requestdatetime={6}", userid, quickpinEncrypted, deviceidEncrypted, quickpiniv, deviceidiv, forceOverride, requestDateTime);
            string signature = Helper.safeBase64String(Helper.hmacSha256(requestParam));

            string serviceUri = string.Format("{0}?{1}&signature={2}", LocalSetting.RegisterDeviceQuickPinURL, requestParam, signature);

            var authenRequest = await requestService(serviceUri);
            return authenRequest.RegisterDeviceQuickPinJsonResult;
        }

        public static async Task<ClassListJsonResult> GetClassList()
        {
            string userid = LocalSetting.UserID;
            string requestDateTime = Helper.getRequestDateTime();

            string requestParam = string.Format("userid={0}&requestdatetime={1}", userid, requestDateTime);
            string signature = Helper.safeBase64String(Helper.hmacSha256(requestParam)); ;

            string serviceUri = string.Format("{0}?{1}&signature={2}", LocalSetting.GetClassListURL, requestParam, signature);

            var authenRequest = await requestService(serviceUri);
            return authenRequest.GetClassListJsonResult;
        }

        public static async Task<UnitListJsonResult> GetUnitList(string classID)
        {
            string userid = LocalSetting.UserID;
            string requestDateTime = Helper.getRequestDateTime();

            string requestParam = string.Format("userid={0}&classid={1}&requestdatetime={2}", userid, classID, requestDateTime);
            string signature = Helper.safeBase64String(Helper.hmacSha256(requestParam));

            string serviceUri = string.Format("{0}?{1}&signature={2}", LocalSetting.GetUnitListURL, requestParam, signature);

            var authenRequest = await requestService(serviceUri);
            return authenRequest.GetUnitListJsonResult;
        }
    }
}
