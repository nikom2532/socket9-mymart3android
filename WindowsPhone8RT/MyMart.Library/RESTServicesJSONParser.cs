namespace MyMart.Library
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Linq;
    using System;
    using System.Runtime.Serialization;

    [DataContract]
    public class ServiceRequestResult
    {
        [DataMember]
        public AuthenticateJsonResult AuthenticateJsonResult { get; set; }

        [DataMember]
        public AuthenticateJsonResult AuthenticateDeviceQuickPinJsonResult { get; set; }

        [DataMember]
        public RegisterDeviceQuickPinJsonResult RegisterDeviceQuickPinJsonResult { get; set; }

        [DataMember]
        public ClassListJsonResult GetClassListJsonResult { get; set; }

        [DataMember]
        public UnitListJsonResult GetUnitListJsonResult { get; set; }
    }

    [DataContract]
    public class AuthenticateJsonResult
    {
        [DataMember]
        public bool Authenticated { get; set; }
        [DataMember]
        public string ExceptionMessage { get; set; }
        [DataMember]
        public string UserID { get; set; }

    }

    [DataContract]
    public class RegisterDeviceQuickPinJsonResult
    {
        [DataMember]
        public bool AlreadyRegistered { get; set; }
        [DataMember]
        public string ExceptionMessage { get; set; }
        [DataMember]
        public bool RegisterSuccess { get; set; }
    }

    [DataContract]
    public class ClassListJsonResult
    {
        [DataMember]
        public bool ClassListSuccess { get; set; }
        [DataMember]
        public List<Class> Classes { get; set; }
        [DataMember]
        public string ExceptionMessage { get; set; }
        [DataMember]
        public string ReportingPeriod { get; set; }
    }

    [DataContract]
    public class UnitListJsonResult
    {
        [DataMember]
        public string ExceptionMessage { get; set; }
        [DataMember]
        public bool UnitListSuccess { get; set; }
        [DataMember]
        public List<Unit> Units { get; set; }
    }

    [DataContract]
    public class Class
    {
        [DataMember]
        public string ClassID { get; set; }

        [DataMember]
        public string ClassTitle { get; set; }
    }

    [DataContract]
    public class Unit
    {
        [DataMember]
        public string UnitID { get; set; }

        [DataMember]
        public string UnitTitle { get; set; }
    }
}
