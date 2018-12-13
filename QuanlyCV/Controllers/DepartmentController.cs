using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    public class DepartmentController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: Department
        public ActionResult Index()
        {
            var lstDepartment = db.Departments.Where(x => x.DepartmentStatus == 1).ToList();
            return View(lstDepartment);
        }
        public ActionResult Create()
        {
            var d = db.Departments.Where(x => x.DepartmentStatus == 1).ToList();
            return View(d);
        }
        [HttpPost]
        public ActionResult Create(string DepartmentName,int DepartmentId,int DepartmentStatus)
        {
            try
            {
                Department d = new Department();
                d.DepartmentName = DepartmentName;
                d.ParentId = DepartmentId;
                d.DepartmentStatus = DepartmentStatus;
                db.Departments.Add(d);
                db.SaveChanges();
                TempData["error"] = "thêm mới thành công ";
                return RedirectToAction("Index");

            }
            catch (Exception ex)
            {
                TempData["error"] = "thêm mới không thành công ";
                return View();
                throw;
            }
        }
        public ActionResult Update(int id)
        {
            Department d = db.Departments.Find(id);
            ViewBag.lstDepartment = db.Departments.Where(x => x.DepartmentStatus == 1).ToList();
            return View(d);
        }
        [HttpPost]
        public ActionResult Update(int DepartmentId,string DepartmentName,int ParentId,int DepartmentStatus)
        {
            try
            {
                Department d = db.Departments.Find(DepartmentId);
                d.DepartmentName = DepartmentName;
                d.ParentId = ParentId;
                d.DepartmentStatus = DepartmentStatus;
                db.Entry(d).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                TempData["error"] = "cập nhật thành công ";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["error"] = "cập nhật không thành công ";
                throw;
            }
        }
        public ActionResult Delete(int id)
        {
            try
            {
                Department d = db.Departments.Find(id);
                d.DepartmentStatus = 2;
                db.Entry(d).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                TempData["error"] = "xóa thành công ";
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                TempData["error"] = "xóa không thành công ";
                throw;
            }
        }
    }
}