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
    
    public partial class StepMember
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public StepMember()
        {
            this.SmallStepMembers = new HashSet<SmallStepMember>();
        }
    
        public int StepMemberId { get; set; }
        public int StepId { get; set; }
        public int ProjectMemberId { get; set; }
        public int StepMemberStatus { get; set; }
    
        public virtual ProjectMember ProjectMember { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SmallStepMember> SmallStepMembers { get; set; }
        public virtual Step Step { get; set; }
    }
}
