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
    
    public partial class GroupChatMember
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GroupChatMember()
        {
            this.GroupChatDetails = new HashSet<GroupChatDetail>();
        }
    
        public int GroupChatMemberId { get; set; }
        public int GroupChatId { get; set; }
        public int EmployeeId { get; set; }
        public int Adder { get; set; }
        public System.DateTime AddedTime { get; set; }
        public int GroupChatMemberStatus { get; set; }
    
        public virtual Employee Employee { get; set; }
        public virtual Employee Employee1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GroupChatDetail> GroupChatDetails { get; set; }
        public virtual GroupChat GroupChat { get; set; }
    }
}
