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
    
    public partial class File
    {
        public int FileId { get; set; }
        public string FileName { get; set; }
        public Nullable<int> FolderId { get; set; }
        public Nullable<int> EmployeeId { get; set; }
        public Nullable<int> ProjectId { get; set; }
        public int FileStatus { get; set; }
    
        public virtual Employee Employee { get; set; }
        public virtual Folder Folder { get; set; }
        public virtual Project Project { get; set; }
    }
}
