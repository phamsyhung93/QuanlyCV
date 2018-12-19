using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    //[AuthorizePermissions]
    public class EmployeeController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: Employee
        public PartialViewResult Index()
        {
            if (Session["EmployeeId"] != null)
            {
                var lstEmployee = db.sp_GetAllEmployeeByDepartment();
                ViewBag.lstEmployeeByDepartment = lstEmployee;
                ViewBag.Department = db.Departments.Where(x => x.DepartmentStatus == 1).ToList();
                ViewBag.Role = db.Roles.Where(x => x.RoleStatus == 1).ToList();
                return PartialView();
            }
            else
            {
                return PartialView();
            }

        }
        public ActionResult CreateEmployee()
        {
            try
            {
                HttpFileCollectionBase files = Request.Files;
                var form = Request.Form;
                var EmployeeFullname = form.Get("EmployeeFullname");
                var EmployeeBirthday = form.Get("EmployeeBirthday");
                var EmployeeIdCard = form.Get("EmployeeIdCard");
                var EmployeeGender = form.Get("EmployeeGender");
                var EmployeePhone = form.Get("EmployeePhone");
                var EmployeeAddress = form.Get("EmployeeAddress");
                var EmployeeEmail = form.Get("EmployeeEmail");
                var DepartmentId = form.Get("DepartmentId");
                var RoleId = form.Get("RoleId");
                var EmployeeCode = form.Get("EmployeeCode");
                var EmployeeAccountNumber = form.Get("EmployeeAccountNumber");
                var EmployeeAccountName = form.Get("EmployeeAccountName");
                var EmployeeType = form.Get("EmployeeType");
                var EmployeeStatus = form.Get("EmployeeStatus");
                var avatar = "";
                var coverPicture = "";
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFileBase file = files[0];
                    avatar = Path.GetFileName(file.FileName);
                    var ServerSavePath = Path.Combine(Server.MapPath("~/Content/images/avatar/") + avatar);
                    file.SaveAs(ServerSavePath);
                    HttpPostedFileBase fileBia = files[1];
                    coverPicture = Path.GetFileName(fileBia.FileName);
                    var ServerSavePathBia = Path.Combine(Server.MapPath("~/Content/images/coverPicture/") + coverPicture);
                    file.SaveAs(ServerSavePathBia);
                }

                var pass = Unti.Utility.getHashedMD5("devhitech@123");
                var lstEmployee = db.Employees.ToList();
                foreach (var item in lstEmployee)
                {
                    if (item.EmployeeFullname.Equals(EmployeeFullname) || item.EmployeeIdCard.Equals(EmployeeIdCard) ||
                        item.EmployeePhone == EmployeePhone || item.EmployeeEmail.Equals(EmployeeEmail) ||
                        item.EmployeeAvatar.Equals(avatar) || item.EmployeeCoverPicture.Equals(coverPicture))
                    {
                        TempData["error"] = "Thêm Không thành công";
                        return Json("False");
                    }
                    else
                    {
                        Employee em = new Employee();
                        em.EmployeeFullname = EmployeeFullname;
                        em.EmployeeBirthday = Convert.ToDateTime(EmployeeBirthday);
                        em.EmployeeIdCard = EmployeeIdCard;
                        em.EmployeePhone = EmployeePhone;
                        em.EmployeeAddress = EmployeeAddress;
                        em.EmployeeEmail = EmployeeEmail;
                        em.EmployeePassword = pass;
                        em.EmployeeAvatar = avatar;
                        em.EmployeeCoverPicture = coverPicture;
                        em.EmployeeGender = int.Parse(EmployeeGender);
                        em.EmployeeStatus = int.Parse(EmployeeStatus);
                        em.EmployeeAccountName = EmployeeAccountName;
                        em.EmployeeAccountNumber = EmployeeAccountNumber;
                        em.EmployeeCode = EmployeeCode;
                        em.EmployeeType = EmployeeType == "1" ? true : false;
                        db.Employees.Add(em);
                        db.SaveChanges();
                        DepartmentEmployee departmentEm = new DepartmentEmployee();
                        departmentEm.DepartmentId = int.Parse(DepartmentId);
                        departmentEm.EmployeeId = em.EmployeeId;
                        departmentEm.DepartmentEmployeeStatus = 1;
                        db.DepartmentEmployees.Add(departmentEm);
                        db.SaveChanges();
                        GrantPermission gp = new GrantPermission();
                        gp.RoleId = int.Parse(RoleId);
                        gp.DepartmentEmployeeId = departmentEm.DepartmentEmployeeId;
                        gp.GrantPermissionStatus = 1;
                        db.GrantPermissions.Add(gp);
                        db.SaveChanges();
                        TempData["error"] = "Thêm mới thành công";
                        return Json("True");
                    }
                }
                return Json("True");
            }
            catch (Exception ex)
            {
                return Json("False");
                throw;
            }
        }

        public PartialViewResult loadTableEmployee()
        {
            var lstEmployee = db.sp_GetAllEmployeeByDepartment();
            ViewBag.lstEmployeeByDepartment = lstEmployee;
            return PartialView();
        }
        public PartialViewResult loadModelEditEmployee(int id)

        {
            if (id <= 0)
            {
                return PartialView();
            }
            else
            {
                ViewBag.Department = db.Departments.ToList();
                var Employee = db.sp_getEmployeeByDepartmentWhereEmployeeIds(id).SingleOrDefault();
                ViewBag.Employee = Employee;
                ViewBag.GrantPermissions = db.GrantPermissions.SingleOrDefault(x => x.DepartmentEmployeeId == Employee.DepartmentEmployeeId);
                ViewBag.Role = db.Roles.Where(x => x.RoleStatus == 1).ToList();
                return PartialView();

            }

        }
        [HttpPost]
        public ActionResult updateEmployee()
        {
            try
            {
                var form = Request.Form;
                var EmployeeId = form.Get("EmployeeId");
                var DepartmentIdOldEdit = form.Get("DepartmentIdOldEdit");
                var EmployeeFullname = form.Get("EmployeeFullname");
                var EmployeeBirthday = form.Get("EmployeeBirthday");
                var EmployeeIdCard = form.Get("EmployeeIdCard");
                var EmployeeGender = form.Get("EmployeeGender");
                var EmployeePhone = form.Get("EmployeePhone");
                var EmployeeAddress = form.Get("EmployeeAddress");
                var EmployeeEmail = form.Get("EmployeeEmail");
                var DepartmentId = form.Get("DepartmentId");
                var RoleId = form.Get("RoleId");
                var EmployeeCode = form.Get("EmployeeCode");
                var EmployeeAccountNumber = form.Get("EmployeeAccountNumber");
                var EmployeeAccountName = form.Get("EmployeeAccountName");
                var EmployeeType = form.Get("EmployeeType");
                var EmployeeStatus = form.Get("EmployeeStatus");

                Employee em = db.Employees.Find(int.Parse(EmployeeId));
                em.EmployeeEmail = EmployeeEmail;
                em.EmployeeAddress = EmployeeAddress;
                em.EmployeeAvatar = em.EmployeeAvatar;
                em.EmployeeBirthday = Convert.ToDateTime(EmployeeBirthday);
                em.EmployeeCoverPicture = em.EmployeeCoverPicture;
                em.EmployeeFullname = EmployeeFullname;
                em.EmployeeGender = int.Parse(EmployeeGender);
                em.EmployeeIdCard = EmployeeIdCard;
                em.EmployeePassword = em.EmployeePassword;
                em.EmployeePhone = EmployeePhone;
                em.EmployeeAccountName = EmployeeAccountName;
                em.EmployeeAccountNumber = EmployeeAccountNumber;
                em.EmployeeCode = EmployeeCode;
                em.EmployeeType = EmployeeType == "1" ? true : false;
                em.EmployeeStatus = int.Parse(EmployeeStatus);
                db.Entry(em).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                int idEmployee = int.Parse(EmployeeId);
                int idDepartment = int.Parse(DepartmentIdOldEdit);
                DepartmentEmployee de = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == idEmployee && x.DepartmentId == idDepartment);
                de.DepartmentId = int.Parse(DepartmentId) > 0 ? int.Parse(DepartmentId) : int.Parse(DepartmentIdOldEdit);
                de.EmployeeId = em.EmployeeId;
                de.DepartmentEmployeeStatus = 1;
                db.Entry(de).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                GrantPermission gp = db.GrantPermissions.SingleOrDefault(x => x.DepartmentEmployeeId == de.DepartmentEmployeeId);
                gp.RoleId = int.Parse(RoleId);
                gp.GrantPermissionId = de.DepartmentEmployeeId;
                gp.GrantPermissionStatus = 1;
                db.Entry(gp).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return Json("True");
            }
            catch (Exception ex)
            {
                return Json("False");
                throw;
            }

        }
        public ActionResult deleteEmployee(int id)
        {
            try
            {
                if (id != null)
                {
                    Employee e = db.Employees.Find(id);
                    e.EmployeeStatus = 2;
                    db.Entry(e).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    TempData["error"] = "Xóa thành Công";

                }
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["error"] = "Xóa không thành Công";
                return RedirectToAction("Index");
                throw;
            }
        }
        [HttpPost]
        public PartialViewResult loadListEmployeeByDepartment(int id)
        {
            try
            {
                if (id == 0)
                {
                    var lstEmployee = db.sp_GetAllEmployeeByDepartment();
                    ViewBag.lstEmployeeByDepartmentId = lstEmployee;
                    return PartialView();
                }
                else
                {
                    var lst = db.sp_getEmployeeByDepartmentWhereDepartmentId(id);
                    ViewBag.lstEmployeeByDepartmentId = lst;
                    return PartialView();
                }

            }
            catch (Exception)
            {
                return PartialView();
                throw;
            }
        }
    }
}