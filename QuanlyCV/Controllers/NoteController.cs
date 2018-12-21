using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    [AuthorizePermissions]
    public class NoteController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: Note
        public ActionResult Index()
        {
            if (Session["EmployeeId"] != null)
            {
                int idEmployee = (int)Session["EmployeeId"];
                var lstNote = db.Notes.Where(x => x.NoteStatus == 1 && x.EmployeeId == idEmployee).ToList();
                ViewBag.EmployeeId = idEmployee;
                ViewBag.Note = db.Notes.SingleOrDefault(x => x.NoteId == 1);
                return View(lstNote);
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }

        }
        [HttpPost]
        public ActionResult Create(Note n)
        {
            try
            {
                db.Notes.Add(n);
                db.SaveChanges();
                TempData["error"] = "Thêm mới Thành công";
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                TempData["error"] = "Thêm mới không Thành công";
                return RedirectToAction("Index");
                throw;
            }
        }

        public PartialViewResult LoadContentNote(int id)
        {
            try
            {
                Note n = db.Notes.Find(id);
                return PartialView(n);
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }
        [HttpPost]
        public ActionResult updateNote(int id,string NoteContent)
        {
            try
            {
                Note n = db.Notes.Find(id);
                n.NoteContent = NoteContent;
                db.Entry(n).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                //TempData["error"] = "Cập Nhật Thành Công";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                //TempData["error"] = "Cập Nhật không Thành Công";
                return RedirectToAction("Index");
                throw;
            }
        }
        [HttpPost]
        public ActionResult DeleteNote(int id)
        {
            try
            {
                Note n = db.Notes.Find(id);
                n.NoteStatus = 2;
                db.Entry(n).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                //TempData["error"] = "Xóa Thành Công";
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                //TempData["error"] = "Xóa không Thành Công";
                return RedirectToAction("Index");
                throw;
            }
        }
    }
}