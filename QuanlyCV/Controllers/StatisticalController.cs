using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    [AuthorizePermissions]
    public class StatisticalController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        public ActionResult Index()
        {
            if (Session["EmployeeId"] != null)
            {
                int id = (int)Session["EmployeeId"];
                DepartmentEmployee de = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == id);
                GrantPermission gp = db.GrantPermissions.SingleOrDefault(x => x.DepartmentEmployeeId == de.DepartmentEmployeeId);
                var pm = db.ProjectMembers.Where(x => x.GrantPermissionId == gp.GrantPermissionId).ToList();
                ViewBag.ProjectMembers = pm;
                var lstProject = db.Projects.Where(x => x.ProjectStatus == 1).ToList();
                var lstDepartments = db.Departments.Where(x => x.DepartmentStatus == 1).ToList();
                ViewBag.listProject = lstProject;
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }

        }

        public PartialViewResult GetAllProjectByYearAndMonth(int? month, int? year)
        {
            try
            {
                int idEmployee = (int)Session["EmployeeId"];
                DepartmentEmployee de = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == idEmployee);
                GrantPermission gp = db.GrantPermissions.SingleOrDefault(x => x.DepartmentEmployeeId == de.DepartmentEmployeeId);
                var pm = db.ProjectMembers.Where(x => x.GrantPermissionId == gp.GrantPermissionId).ToList();
                ViewBag.ProjectMembers = pm;
                if (month == null && year == null)
                {
                    var lstProject = db.Projects.Where(x => x.ProjectStatus == 1).ToList();
                    ViewBag.listProject = lstProject;
                }
                else
                {
                    if (month == null)
                    {
                        var lstProject = db.Projects.Where(x => x.ProjectStatus == 1 && x.StartTime.Year == year).ToList();
                        ViewBag.listProject = lstProject;
                    }
                    else if (year == null)
                    {
                        var lstProject = db.Projects.Where(x => x.ProjectStatus == 1 && x.StartTime.Month == month).ToList();
                        ViewBag.listProject = lstProject;
                    }
                    else
                    {
                        var lstProject = db.Projects.Where(x => x.ProjectStatus == 1 && x.StartTime.Year == year && x.StartTime.Month == month).ToList();
                        ViewBag.listProject = lstProject;
                    }
                }


                return PartialView();

            }
            catch (Exception ex)
            {

                throw;
            }
        }
        public PartialViewResult LoadListEmployeeByProject(int id)
        {
            try
            {
                var lstEmployee = db.Employees.Where(x => x.EmployeeStatus == 1).ToList();
                var lstDepartment = db.Departments.Where(x => x.DepartmentStatus == 1).ToList();
                var lstEmployeeByProjectId = db.sp_GetAllEmployeeByProjectID(id);
                ViewBag.listEmployeeByProjectId = lstEmployeeByProjectId;
                var lstEmployeeByRoleId = db.sp_getAllEmployeeByRoleID(6).ToList();
                ViewBag.listEmployeeByRoleId = lstEmployeeByRoleId;
                return PartialView();
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public PartialViewResult LoadModelDetailWork(int ProjectId,int EmployeeId)
        {
            try
            {
                var DetailEmployeeByWork = db.sp_getAllByProjectIdAndEmployeeId(ProjectId, EmployeeId).ToList();
                ViewBag.DetailEmployeeByWork = DetailEmployeeByWork;
                return PartialView();
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}