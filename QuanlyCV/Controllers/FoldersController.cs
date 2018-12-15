using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    //[AuthorizePermissions]
    public class FoldersController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}