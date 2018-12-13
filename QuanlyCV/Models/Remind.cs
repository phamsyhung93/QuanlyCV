//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace QuanlyCV.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Remind
    {
        public int RemindId { get; set; }
        public string RemindContent { get; set; }
        public System.DateTime RemindTime { get; set; }
        public Nullable<int> EmployeeId { get; set; }
        public Nullable<int> ProjectId { get; set; }
        public Nullable<int> DepartmentId { get; set; }
        public int RemindStatus { get; set; }
    
        public virtual Department Department { get; set; }
        public virtual Employee Employee { get; set; }
        public virtual Project Project { get; set; }
    }
}
