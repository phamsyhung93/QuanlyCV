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
    
    public partial class GroupChat
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GroupChat()
        {
            this.GroupChatMembers = new HashSet<GroupChatMember>();
        }
    
        public int GroupChatId { get; set; }
        public string GroupChatName { get; set; }
        public int EmployeeId { get; set; }
        public System.DateTime CreateTime { get; set; }
        public int GroupChatStatus { get; set; }
    
        public virtual Employee Employee { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GroupChatMember> GroupChatMembers { get; set; }
    }
}
