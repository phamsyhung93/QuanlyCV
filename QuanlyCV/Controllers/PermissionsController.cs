using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    //[AuthorizePermissions]
    public class PermissionsController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: Permissions
        public PartialViewResult Index()
        {
            if(Session["EmployeeId"] != null)
            {
                var lst = db.Permissions.ToList();
                ViewBag.ManagerZone = db.ManagerZones.Where(x => x.ManagerZoneStatus == 1).ToList();

                return PartialView(lst);
            }
            else
            {
                return PartialView();
            }
           
        }
        public ActionResult Create()
        {
            try
            {
                ReflectionController reflectionController = new ReflectionController();
                List<Type> lstController = reflectionController.GetController("QuanlyCV");
                List<string> listCurrentPermisson = db.Permissions.Select(p => p.PermissionName).ToList();
                foreach (var item in lstController)
                {
                    List<String> listPermisson = reflectionController.GetAction(item);
                    foreach (var item1 in listPermisson)
                    {
                        if (!listCurrentPermisson.Contains(item.Name + "-" + item1))
                        {
                            Permission permisson = new Permission();
                            permisson.PermissionName = item.Name + "-" + item1;
                            permisson.PermissionStatus = 1;
                            permisson.ManagerZoneID = item.Name;
                            db.Permissions.Add(permisson);
                        }
                    }
                }
                db.SaveChanges();
                TempData["error"] = "Thêm mới thành công";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["error"] = "Thêm mới không thành công";
                return RedirectToAction("Index");
                throw;
            }
        }
        public ActionResult ViewUpdate(int id)
        {
            try
            {
                Permission p = db.Permissions.Find(id);
                return View(p);
            }
            catch (Exception)
            {
                TempData["error"] = "Chưa chọn đối tượng nào";
                return RedirectToAction("Index");
                throw;
            }
        }
        [HttpPost]
        public ActionResult UpdatePermissions(Permission p)
        {
            try
            {
                db.Entry(p).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                TempData["error"] = "cập nhật thành công";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["error"] = "cập nhật thất bại";
                return View();
                throw;
            }
        }
        [HttpPost]
        public ActionResult Delete(int id)
        {
            try
            {
                Permission p = db.Permissions.Find(id);
                p.PermissionStatus = 2;
                db.Entry(p).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                TempData["error"] = "cập nhật thành công";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["error"] = "cập nhật thất bại";
                return View();
                throw;
            }
        }

        public PartialViewResult loadListPermissionsManagerZone(int id)
        {
            try
            {
                if(id == 0)
                {
                    var lstPermissions = db.Permissions.ToList();
                    ViewBag.ManagerZone = db.ManagerZones.Where(x => x.ManagerZoneStatus == 1).ToList();
                    return PartialView(lstPermissions);
                }
                else
                {
                    ManagerZone m = db.ManagerZones.Find(id);
                    ViewBag.ManagerZone = db.ManagerZones.Where(x => x.ManagerZoneStatus == 1).ToList();
                    var lstPermissions = db.Permissions.Where(x => x.ManagerZoneID.Equals(m.ManagerZoneName)).ToList();
                    return PartialView(lstPermissions);
                }
                
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }
    }
}