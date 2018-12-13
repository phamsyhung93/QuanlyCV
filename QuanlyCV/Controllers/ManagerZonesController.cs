using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    public class ManagerZonesController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: ManagerZones
        public ActionResult Index()
        {
            if(Session["EmployeeId"] != null)
            {
                var lstManagerZones = db.ManagerZones.ToList();
                return View(lstManagerZones);
            }else
            {
                return RedirectToAction("Index");
            }
            
        }

        public ActionResult Create()
        {
            try
            {
                ReflectionController reflectionController = new ReflectionController();
                List<Type> lstController = reflectionController.GetController("QuanlyCV");
                List<string> listCurrentController = db.ManagerZones.Select(c => c.ManagerZoneName).ToList();
                List<string> listCurrentPermisson = db.Permissions.Select(p => p.PermissionName).ToList();
                foreach (var item in lstController)
                {
                    if (!listCurrentController.Contains(item.Name)){
                        ManagerZone m = new ManagerZone();
                        m.ManagerZoneName = item.Name;
                        m.ManagerZoneStatus = 1;
                        db.ManagerZones.Add(m);
                    }
                    List<String> listPermisson = reflectionController.GetAction(item);
                    foreach (var item1 in listPermisson)
                    {
                        if (!listCurrentPermisson.Contains(item.Name + "-" + item1))
                        {
                            Permission permisson = new Permission();
                            permisson.PermissionName = item.Name + "-" + item1;
                            permisson.PermissionStatus = 1;
                            db.Permissions.Add(permisson);
                        }
                    }
                }
                db.SaveChanges();
                TempData["error"] = "Thêm mới thành công";
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                TempData["error"] = ex;
                return RedirectToAction("Index");
                throw;
            }
        }

        public ActionResult ViewUpdate(int id)
        {
            ManagerZone m = db.ManagerZones.Find(id);
            return View(m);
        }
        [HttpPost]
        public ActionResult Update(ManagerZone m)
        {
            try
            {
                db.Entry(m).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                TempData["error"] = "cập nhật thành công";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["error"] = "cập nhật không thành công";
                return View();
                throw;
            }
        }
        public ActionResult Delete(int id)
        {
            try
            {
                ManagerZone m = db.ManagerZones.Find(id);
                m.ManagerZoneStatus = 2;
                db.Entry(m).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                TempData["error"] = "Xóa thành công";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["error"] = "Xóa không thành công";
                return View();
                throw;
            }
        }
    }
}