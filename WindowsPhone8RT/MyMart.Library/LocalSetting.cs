using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.Storage;

namespace MyMart.Library
{
    public static class LocalSetting
    {
        static ApplicationDataContainer settings = ApplicationData.Current.LocalSettings;

        public static string APIServerURL
        {
            get
            {
                return "http://mymart3demo.cloudapp.net/MobileService.svc/";
            }
        }

        public static string PrivateAESKey
        {
            get
            {
                return "0DB03F0B8D734F339A22E1FCC31D85BC";
            }
        }

        public static string PrivateHMACKey
        {
            get
            {
                return "C48BC385-25F5-4CAD-BD2C-7EEA72546FF7";
            }
        }

        public static string DeviceID
        {
            get
            {
                if (settings.Values["DeviceID"] == null)
                {
                    settings.Values["DeviceID"] = Helper.generateDeviceID();
                }

                return settings.Values["DeviceID"].ToString();
            }
        }

        public static string AuthenWithUsernameURL
        {
            get
            {
                return string.Format("{0}json/Authenticate", LocalSetting.APIServerURL);
            }
        }

        public static string AuthenWithQuickPinURL
        {
            get
            {
                return string.Format("{0}json/AuthenticateDeviceQuickPin", LocalSetting.APIServerURL);
            }
        }

        public static string RegisterDeviceQuickPinURL
        {
            get
            {
                return string.Format("{0}json/RegisterDeviceQuickPin", LocalSetting.APIServerURL);
            }
        }

        public static string GetClassListURL
        {
            get
            {
                return string.Format("{0}json/GetClassList", LocalSetting.APIServerURL);
            }
        }

        public static string GetUnitListURL
        {
            get
            {
                return string.Format("{0}json/GetUnitList", LocalSetting.APIServerURL);
            }
        }

        public static string UserID { get; set; }

        public static bool IsRegisterDevice
        {
            get
            {
                if (settings.Values["IsRegisterDevice"] == null)
                {
                    settings.Values["IsRegisterDevice"] = false;
                }

                return (bool)settings.Values["IsRegisterDevice"];
            }
            set
            {
                settings.Values["IsRegisterDevice"] = value;
            }
        }
    }
}
