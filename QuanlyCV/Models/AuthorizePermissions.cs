using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Models
{
    public class AuthorizePermissions:ActionFilterAttribute
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if(HttpContext.Current.Session["EmployeeId"] == null)
            {
                filterContext.Result = new RedirectResult("/Home/Login");
                return;
            }
            string actionName = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName + "Controller-" + filterContext.ActionDescriptor.ActionName;
            Employee e = db.Employees.Find(HttpContext.Current.Session["EmployeeId"]);
            Department d = db.Departments.Find(HttpContext.Current.Session["DepartmentId"]);
            DepartmentEmployee de = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == e.EmployeeId && x.DepartmentId == d.DepartmentId);
            GrantPermission gp = db.GrantPermissions.SingleOrDefault(x => x.DepartmentEmployeeId == de.DepartmentEmployeeId);

            var sp = db.SetPermissions.Where(x => x.RoleId == gp.RoleId).ToList();
            var lstPermissionsName = db.sp_getAllPermissionsNameByRoleId(gp.RoleId);
            if (!lstPermissionsName.Contains(actionName))
            {
                filterContext.Result = new RedirectResult("/Home/Error");
                return;
            }
        }
    }
}