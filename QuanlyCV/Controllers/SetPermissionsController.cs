using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    //[AuthorizePermissions]
    public class SetPermissionsController : Controller
    {
        private WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: SetPermissions
        public ActionResult Index()
        {
            if(Session["EmployeeId"] != null)
            {
                var lst = db.Roles.Where(x => x.RoleStatus == 1).ToList();
                return View(lst);
            }
            else
            {
                return RedirectToAction("Index");
            }
        }

        public ActionResult setPermissionsByManagerZone(int id)
        {
            try
            {
                Role r = db.Roles.Find(id);
                ViewBag.Role = r;
                var managerZone = db.ManagerZones.ToList();
                ViewBag.ManagerZone = managerZone;
                return View();
            }
            catch (Exception)
            {
                TempData["error"] = "chưa chọn đối tượng nào";
                return RedirectToAction("Index");
                throw;
            }
        }

        public PartialViewResult loadListPermissionsManagerZone(int id,int roleId)
        {
            try
            {
                
                ManagerZone m = db.ManagerZones.Find(id);
                var lstPerrmission = db.Permissions.Where(x => x.ManagerZoneID.Equals(m.ManagerZoneName)).ToList();
                ViewBag.RoleId = roleId;
                var lstSetPermissions = db.SetPermissions.Where(x => x.ManagerZoneId == id && x.RoleId == roleId).ToList();
                ViewBag.lstSetPermissions = lstSetPermissions;
                return PartialView(lstPerrmission);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public bool insertSetPermissions(int idPermissions,string managerZoneName,int roleId)
        {
            try
            {
                ManagerZone m = db.ManagerZones.SingleOrDefault(x => x.ManagerZoneName.Equals(managerZoneName));
                SetPermission sp = new SetPermission();
                sp.PermissionId = idPermissions;
                sp.ManagerZoneId = m.ManagerZoneId;
                sp.RoleId = roleId;
                sp.SetPermissionStatus = 1;
                db.SetPermissions.Add(sp);
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
                throw;
            }
        }
        [HttpPost]
        public bool deleteSetPermissions(int idPermissions, string managerZoneName, int roleId)
        {
            try
            {
                ManagerZone m = db.ManagerZones.SingleOrDefault(x => x.ManagerZoneName.Equals(managerZoneName));
                SetPermission sp = db.SetPermissions.SingleOrDefault(x => x.RoleId == roleId && x.PermissionId == idPermissions && x.ManagerZoneId == m.ManagerZoneId);
                db.SetPermissions.Remove(sp);
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
                throw;
            }
        }
    }
}