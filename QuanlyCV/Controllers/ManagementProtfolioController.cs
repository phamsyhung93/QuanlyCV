using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{

    [AuthorizePermissions]
    public class ManagementProtfolioController : Controller
    {
        // GET: ManagementProtfolio

        public ActionResult Index()
        {
            if(Session["EmployeeId"]!= null) { 
                return View();
            }else
            {
                return RedirectToAction("Index", "Home");
            }
        }
    }
}