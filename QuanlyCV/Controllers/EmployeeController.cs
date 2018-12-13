using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    public class EmployeeController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: Employee
        public ActionResult Index()
        {
            if(Session["EmployeeId"] != null)
            {
                var lstEmployee = db.sp_GetAllEmployeeByDepartment();
                ViewBag.lstEmployeeByDepartment = lstEmployee;
                ViewBag.Department = db.Departments.Where(x => x.DepartmentStatus == 1).ToList();
                return View();
            }else
            {
                return RedirectToAction("Index");
            }
            
        }
        public ActionResult CreateEmployee(HttpPostedFileBase EmployeeAvatarFile, HttpPostedFileBase EmployeeCoverPictureFile, Employee e,int DepartmentId)
        {
            try
            {
                var pass = Unti.Utility.getHashedMD5("1234");
                string avatarFile = Path.Combine(Server.MapPath("~/Content/images/avatar/"), Path.GetFileName(EmployeeAvatarFile.FileName));
                EmployeeAvatarFile.SaveAs(avatarFile);
                var avatar = EmployeeAvatarFile.FileName;
                string coverPictureFile = Path.Combine(Server.MapPath("~/Content/images/coverPicture/"), Path.GetFileName(EmployeeCoverPictureFile.FileName));
                EmployeeCoverPictureFile.SaveAs(coverPictureFile);
                var coverPicture = EmployeeCoverPictureFile.FileName;
                var lstEmployee = db.Employees.ToList();
                foreach (var item in lstEmployee)
                {
                    if (item.EmployeeFullname.Equals(e.EmployeeFullname) || item.EmployeeIdCard.Equals(e.EmployeeIdCard) || item.EmployeePhone == e.EmployeePhone || item.EmployeeEmail.Equals(e.EmployeeEmail) || item.EmployeeAvatar.Equals(avatar) || item.EmployeeCoverPicture.Equals(coverPicture))
                    {
                        TempData["error"] = "Thêm Không thành công";
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        Employee em = new Employee();
                        em.EmployeeFullname = e.EmployeeFullname;
                        em.EmployeeBirthday = e.EmployeeBirthday;
                        em.EmployeeIdCard = e.EmployeeIdCard;
                        em.EmployeePhone = e.EmployeePhone;
                        em.EmployeeAddress = e.EmployeeAddress;
                        em.EmployeeEmail = e.EmployeeEmail;
                        em.EmployeePassword = pass;
                        em.EmployeeAvatar = avatar;
                        em.EmployeeCoverPicture = coverPicture;
                        em.EmployeeGender = e.EmployeeGender;
                        em.EmployeeStatus = e.EmployeeStatus;
                        db.Employees.Add(em);
                        db.SaveChanges();
                        DepartmentEmployee departmentEm = new DepartmentEmployee();
                        departmentEm.DepartmentId = DepartmentId;
                        departmentEm.EmployeeId = em.EmployeeId;
                        departmentEm.DepartmentEmployeeStatus = 1;
                        db.DepartmentEmployees.Add(departmentEm);
                        db.SaveChanges();
                        TempData["error"] = "Thêm mới thành công";
                        return RedirectToAction("Index");
                    }
                }
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public PartialViewResult loadModelEditEmployee(int id)

        {
            if(id <= 0 )
            {
                return PartialView();
            }
            else
            {
                ViewBag.Department = db.Departments.ToList();
                ViewBag.Employee = db.sp_getEmployeeByDepartmentWhereEmployeeIds(id).SingleOrDefault();
                return PartialView();
                
            }
            
        }
        [HttpPost]
        public ActionResult updateEmployee(HttpPostedFileBase EmployeeAvatarFile, HttpPostedFileBase EmployeeCoverPictureFile,Employee e,int DepartmentId,int DepartmentIdOld)
        {
            try
            {
                

                if(EmployeeAvatarFile == null && EmployeeCoverPictureFile == null)
                {
                    Employee em = db.Employees.Find(e.EmployeeId);
                    em.EmployeeEmail = e.EmployeeEmail;
                    em.EmployeeAddress = e.EmployeeAddress;
                    em.EmployeeAvatar = em.EmployeeAvatar;
                    em.EmployeeBirthday = e.EmployeeBirthday;
                    em.EmployeeCoverPicture = em.EmployeeCoverPicture;
                    em.EmployeeFullname = e.EmployeeFullname;
                    em.EmployeeGender = e.EmployeeGender;
                    em.EmployeeIdCard = e.EmployeeIdCard;
                    em.EmployeePassword = em.EmployeePassword;
                    em.EmployeePhone = e.EmployeePhone;
                    em.EmployeeStatus = e.EmployeeStatus;
                    db.Entry(em).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    DepartmentEmployee de = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == em.EmployeeId && x.DepartmentId == DepartmentIdOld);
                    de.DepartmentId = DepartmentId;
                    de.EmployeeId = em.EmployeeId;
                    de.DepartmentEmployeeStatus = 1;
                    db.Entry(de).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    TempData["error"] = "cập nhật thành công";
                }
                else
                {
                    if (EmployeeCoverPictureFile == null)
                    {
                        string avatarFile = Path.Combine(Server.MapPath("~/Content/images/avatar/"), Path.GetFileName(EmployeeAvatarFile.FileName));
                        EmployeeAvatarFile.SaveAs(avatarFile);
                        var avatar = EmployeeAvatarFile.FileName;
                        Employee em = db.Employees.Find(e.EmployeeId);
                        em.EmployeeEmail = e.EmployeeEmail;
                        em.EmployeeAddress = e.EmployeeAddress;
                        em.EmployeeAvatar = avatar;
                        em.EmployeeBirthday = e.EmployeeBirthday;
                        em.EmployeeCoverPicture = em.EmployeeCoverPicture;
                        em.EmployeeFullname = e.EmployeeFullname;
                        em.EmployeeGender = e.EmployeeGender;
                        em.EmployeeIdCard = e.EmployeeIdCard;
                        em.EmployeePassword = em.EmployeePassword;
                        em.EmployeePhone = e.EmployeePhone;
                        em.EmployeeStatus = e.EmployeeStatus;
                        db.Entry(em).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        DepartmentEmployee de = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == em.EmployeeId && x.DepartmentId == DepartmentIdOld);
                        de.DepartmentId = DepartmentId;
                        de.EmployeeId = em.EmployeeId;
                        de.DepartmentEmployeeStatus = 1;
                        db.Entry(de).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        TempData["error"] = "cập nhật thành công";
                    }
                    else if (EmployeeAvatarFile == null)
                    {
                        string coverPictureFile = Path.Combine(Server.MapPath("~/Content/images/coverPicture/"), Path.GetFileName(EmployeeCoverPictureFile.FileName));
                        EmployeeCoverPictureFile.SaveAs(coverPictureFile);
                        var coverPicture = EmployeeCoverPictureFile.FileName;
                        Employee em = db.Employees.Find(e.EmployeeId);
                        em.EmployeeEmail = e.EmployeeEmail;
                        em.EmployeeAddress = e.EmployeeAddress;
                        em.EmployeeAvatar = em.EmployeeAvatar;
                        em.EmployeeBirthday = e.EmployeeBirthday;
                        em.EmployeeCoverPicture = coverPicture;
                        em.EmployeeFullname = e.EmployeeFullname;
                        em.EmployeeGender = e.EmployeeGender;
                        em.EmployeeIdCard = e.EmployeeIdCard;
                        em.EmployeePassword = em.EmployeePassword;
                        em.EmployeePhone = e.EmployeePhone;
                        em.EmployeeStatus = e.EmployeeStatus;
                        db.Entry(em).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        DepartmentEmployee de = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == em.EmployeeId && x.DepartmentId == DepartmentIdOld);
                        de.DepartmentId = DepartmentId;
                        de.EmployeeId = em.EmployeeId;
                        de.DepartmentEmployeeStatus = 1;
                        db.Entry(de).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        TempData["error"] = "cập nhật thành công";
                    }
                    else
                    {
                        string avatarFile = Path.Combine(Server.MapPath("~/Content/images/avatar/"), Path.GetFileName(EmployeeAvatarFile.FileName));
                        EmployeeAvatarFile.SaveAs(avatarFile);
                        var avatar = EmployeeAvatarFile.FileName;
                        string coverPictureFile = Path.Combine(Server.MapPath("~/Content/images/coverPicture/"), Path.GetFileName(EmployeeCoverPictureFile.FileName));
                        EmployeeCoverPictureFile.SaveAs(coverPictureFile);
                        var coverPicture = EmployeeCoverPictureFile.FileName;
                        Employee em = db.Employees.Find(e.EmployeeId);
                        em.EmployeeEmail = e.EmployeeEmail;
                        em.EmployeeAddress = e.EmployeeAddress;
                        em.EmployeeAvatar = avatar;
                        em.EmployeeBirthday = e.EmployeeBirthday;
                        em.EmployeeCoverPicture = coverPicture;
                        em.EmployeeFullname = e.EmployeeFullname;
                        em.EmployeeGender = e.EmployeeGender;
                        em.EmployeeIdCard = e.EmployeeIdCard;
                        em.EmployeePassword = em.EmployeePassword;
                        em.EmployeePhone = e.EmployeePhone;
                        em.EmployeeStatus = e.EmployeeStatus;
                        db.Entry(em).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        DepartmentEmployee de = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == em.EmployeeId && x.DepartmentId == DepartmentIdOld);
                        de.DepartmentId = DepartmentId;
                        de.EmployeeId = em.EmployeeId;
                        de.DepartmentEmployeeStatus = 1;
                        db.Entry(de).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        TempData["error"] = "cập nhật thành công";
                    }
                }
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["error"] = "cập nhật không thành công";
                return RedirectToAction("Index");
                throw;
            }
            
        }
        public ActionResult deleteEmployee(int id)
        {
            try
            {
                if(id != null)
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
                if(id == 0)
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