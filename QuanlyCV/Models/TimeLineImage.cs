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
    
    public partial class TimeLineImage
    {
        public int TimeLineImageId { get; set; }
        public int TimeLineDetailId { get; set; }
        public string TimeLineImage1 { get; set; }
        public int TimeLineImageStatus { get; set; }
    
        public virtual TimeLineDetail TimeLineDetail { get; set; }
    }
}
