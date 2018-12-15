using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    public class NoteController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: Note
        public ActionResult Index()
        {
            if(Session["EmployeeId"]!= null)
            {
                var lstNote = db.Notes.Where(x => x.NoteStatus == 1 && x.EmployeeId == (int)Session["EmployeeId"]);
                return View(lstNote);
            }else
            {
                return RedirectToAction("Index", "Login");
            }
            
        }
    }
}