using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    public class HomeController : Controller
    {
       
        WorkManagermentEntities db = new WorkManagermentEntities();
        public ActionResult Index()
        {
            try
            {
                if(Session["EmployeeId"]!= null)
                {
                    var lstProject = db.Projects.Where(x => x.ProjectStatus == 1).ToList();
                    var lstDepartments = db.Departments.Where(x => x.DepartmentStatus == 1).ToList();
                    ViewBag.listProject = lstProject;
                    ViewBag.listDepartment = lstDepartments;
                    return View();
                }
                else
                {
                    return RedirectToAction("Index", "Login");

                }
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult Error()
        {
            return View();
        }
    }
}