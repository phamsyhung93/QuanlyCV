using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    [AuthorizePermissions]
    public class RoleController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: Role
        public PartialViewResult Index()
        {
            if(Session["EmployeeId"] != null)
            {
                var lstRole = db.Roles.ToList();
                return PartialView(lstRole);
            }else
            {
                return PartialView();
            }
            
        }
        public PartialViewResult ViewCreate()
        {
            return PartialView();
        }
        [HttpPost]
        public ActionResult Create(Role r)
        {
            try
            {
                Role ro = db.Roles.SingleOrDefault(x => x.RoleName.Equals(r.RoleName));
                if (ro != null)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    db.Roles.Add(r);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            catch (Exception ex)
            {
                TempData["error"] = "Thêm mới không thành công";
                return View();
                throw;
            }
        }
        public PartialViewResult ViewUpdate(int id)
        {
            if (id <= 0)
            {
                //TempData["error"] = "chưa chọn chức vụ muốn sửa";
                return PartialView("Index");
            }
            else
            {
                Role e = db.Roles.Find(id);
                return PartialView(e);
            }
            
        }
        [HttpPost]
        public bool Update(Role r)
        {
            try
            {
                db.Entry(r).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                //TempData["error"] = "Cập nhật thành công";
                return true;
            }
            catch (Exception ex)
            {
                //TempData["error"] = "Cập nhật không thành công";
                return false;
                throw;
            }
        }
        public ActionResult Delete(int id)
        {
            try
            {
                Role r = db.Roles.Find(id);
                r.RoleStatus = 2;
                db.Entry(r).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                TempData["error"] = "xóa thành công";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["error"] = "xóa không thành công";
                return RedirectToAction("Index");
                throw;
            }
        }
    }
}