using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    [AuthorizePermissions]
    public class GrantPermissionsController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: GrantPermissions
        public PartialViewResult Index()
        {
            if(Session["EmployeeId"] != null)
            {
                var lstEmployee = db.sp_getEmployeeByRole();
                ViewBag.lstEmployeeByDepartment = lstEmployee;
                ViewBag.Department = db.Departments.Where(x => x.DepartmentStatus == 1).ToList();
                
                return PartialView();
            }
            else
            {
                return PartialView();
            }
        }
        public PartialViewResult loadListEmployeeByDepartmentGranPermissions(int id)
        {
            try
            {
                if (id == 0)
                {
                    var lstEmployee = db.sp_getEmployeeByRole();
                    ViewBag.lstEmployeeByDepartmentId = lstEmployee;
                    return PartialView();
                }
                else
                {
                    var lst = db.sp_getEmployeeByRoleByDepartment(id);
                    ViewBag.lstEmployeeByDepartmentId = lst;
                    return PartialView();
                }
            }
            catch (Exception)
            {
                return PartialView();
                throw;
            }
        }
        public PartialViewResult setGrantPermissions(int id,int idDepartment)
        {
            try
            {
                Employee e = db.Employees.SingleOrDefault(x => x.EmployeeId == id && x.EmployeeStatus == 1);
                Department d = db.Departments.SingleOrDefault(x => x.DepartmentId == idDepartment && x.DepartmentStatus == 1);
                ViewBag.Employee = e;
                ViewBag.Department = d;
                var lstRole = db.Roles.Where(x => x.RoleStatus == 1).ToList();
                ViewBag.lstRole = lstRole;
                DepartmentEmployee de = db.DepartmentEmployees.SingleOrDefault(x => x.DepartmentId == idDepartment && x.EmployeeId == id);
                GrantPermission g = db.GrantPermissions.SingleOrDefault(x => x.DepartmentEmployeeId == de.DepartmentEmployeeId);
                if(g != null)
                {
                    ViewBag.GrantPermissions = g;
                }
                return PartialView();
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }
        [HttpPost]
        public Boolean insertGrantPermissions(int EmployeeId, int DepartmentId, int RoleId)
        {
            try
            {
                DepartmentEmployee d = db.DepartmentEmployees.SingleOrDefault(x => x.DepartmentId == DepartmentId && x.EmployeeId == EmployeeId);
                GrantPermission gp = db.GrantPermissions.SingleOrDefault(x => x.DepartmentEmployeeId == d.DepartmentEmployeeId && x.RoleId == RoleId);
                if(gp != null)
                {

                    return true;
                }
                GrantPermission g = db.GrantPermissions.SingleOrDefault(x => x.DepartmentEmployeeId == d.DepartmentEmployeeId);
                g.DepartmentEmployeeId = d.DepartmentEmployeeId;
                g.RoleId = RoleId;
                g.GrantPermissionStatus = 1;
                db.Entry(g).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
                throw;
            }
        }
    }
}