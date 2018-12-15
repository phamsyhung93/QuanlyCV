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
    public class InfomationController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: Infomation
        public ActionResult Index()
        {
            try
            {
                if(Session["EmployeeId"] != null)
                {
                    Employee e = db.Employees.Find(Session["EmployeeId"]);
                    ViewBag.Emloyee = e;
                    return View();
                }
                else
                {
                    return RedirectToAction("Index");
                }
                
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult UpdateInfomation(HttpPostedFileBase EmployeeAvatar, HttpPostedFileBase EmployeeCoverPicture,Employee e)
        {
            try
            {
                if(EmployeeAvatar!= null  && EmployeeCoverPicture != null)
                {
                    string avatarFile = Path.Combine(Server.MapPath("~/Content/images/avatar/"), Path.GetFileName(EmployeeAvatar.FileName));
                    EmployeeAvatar.SaveAs(avatarFile);
                    var avatar = EmployeeAvatar.FileName;
                    string coverPictureFile = Path.Combine(Server.MapPath("~/Content/images/coverPicture/"), Path.GetFileName(EmployeeCoverPicture.FileName));
                    EmployeeCoverPicture.SaveAs(coverPictureFile);
                    var coverPicture = EmployeeCoverPicture.FileName;
                    Employee em = db.Employees.Find(e.EmployeeId);
                    em.EmployeeFullname = e.EmployeeFullname;
                    em.EmployeeBirthday = e.EmployeeBirthday;
                    em.EmployeeIdCard = e.EmployeeIdCard;
                    em.EmployeePhone = e.EmployeePhone;
                    em.EmployeeAddress = e.EmployeeAddress;
                    em.EmployeeEmail = e.EmployeeEmail;
                    em.EmployeePassword = em.EmployeePassword;
                    em.EmployeeAvatar = avatar;
                    em.EmployeeCoverPicture = coverPicture;
                    em.EmployeeStatus = 1;
                    db.Entry(em).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    TempData["error"] = "cập nhật thành công";
                    return RedirectToAction("Index");
                }else
                {
                    if(EmployeeAvatar != null)
                    {
                        string avatarFile = Path.Combine(Server.MapPath("~/Content/images/avatar/"), Path.GetFileName(EmployeeAvatar.FileName));
                        EmployeeAvatar.SaveAs(avatarFile);
                        var avatar = EmployeeAvatar.FileName;
                        Employee em = db.Employees.Find(e.EmployeeId);
                        em.EmployeeFullname = e.EmployeeFullname;
                        em.EmployeeBirthday = e.EmployeeBirthday;
                        em.EmployeeIdCard = e.EmployeeIdCard;
                        em.EmployeePhone = e.EmployeePhone;
                        em.EmployeeAddress = e.EmployeeAddress;
                        em.EmployeeEmail = e.EmployeeEmail;
                        em.EmployeePassword = em.EmployeePassword;
                        em.EmployeeAvatar = avatar;
                        em.EmployeeCoverPicture = em.EmployeeCoverPicture;
                        em.EmployeeStatus = 1;
                        db.Entry(em).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        TempData["error"] = "cập nhật thành công";
                        return RedirectToAction("Index");
                    }
                    else if(EmployeeCoverPicture != null)
                    {
                        string coverPictureFile = Path.Combine(Server.MapPath("~/Content/images/coverPicture/"), Path.GetFileName(EmployeeCoverPicture.FileName));
                        EmployeeCoverPicture.SaveAs(coverPictureFile);
                        var coverPicture = EmployeeCoverPicture.FileName;
                        Employee em = db.Employees.Find(e.EmployeeId);
                        em.EmployeeFullname = e.EmployeeFullname;
                        em.EmployeeBirthday = e.EmployeeBirthday;
                        em.EmployeeIdCard = e.EmployeeIdCard;
                        em.EmployeePhone = e.EmployeePhone;
                        em.EmployeeAddress = e.EmployeeAddress;
                        em.EmployeeEmail = e.EmployeeEmail;
                        em.EmployeePassword = em.EmployeePassword;
                        em.EmployeeAvatar = em.EmployeeAvatar;
                        em.EmployeeCoverPicture = coverPicture;
                        em.EmployeeStatus = 1;
                        db.Entry(em).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        TempData["error"] = "cập nhật thành công";
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        Employee em = db.Employees.Find(e.EmployeeId);
                        em.EmployeeFullname = e.EmployeeFullname;
                        em.EmployeeBirthday = e.EmployeeBirthday;
                        em.EmployeeIdCard = e.EmployeeIdCard;
                        em.EmployeePhone = e.EmployeePhone;
                        em.EmployeeAddress = e.EmployeeAddress;
                        em.EmployeeEmail = e.EmployeeEmail;
                        em.EmployeePassword = em.EmployeePassword;
                        em.EmployeeAvatar = em.EmployeeAvatar;
                        em.EmployeeCoverPicture = em.EmployeeCoverPicture;
                        em.EmployeeStatus = 1;
                        db.Entry(em).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        TempData["error"] = "cập nhật thành công";
                        return RedirectToAction("Index");
                    }
                }
               
            }
            catch (Exception)
            {
                return View();
                throw;
            }
        }
        public ActionResult ViewChangePassword()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ChangePassword(string EmployeePassword,string newpassword,string repeatpassword,int EmployeeId)
        {
            try
            {
                Employee e = db.Employees.Find(EmployeeId);
                if (e != null)
                {
                    var pass = Unti.Utility.getHashedMD5(EmployeePassword);
                    if (e.EmployeePassword.Equals(pass))
                    {
                        if (newpassword.Equals(repeatpassword))
                        {
                            var passNew = Unti.Utility.getHashedMD5(newpassword);
                            e.EmployeePassword = passNew;
                            db.Entry(e).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                            TempData["error"] = "đổi mật khẩu thành công";
                            return View();
                        }
                        else
                        {
                            TempData["error"] = "mật khẩu mới không khớp";
                            return View();
                        }
                    }else
                    {
                        TempData["error"] = "mật khẩu cũ không đúng";
                        return View();
                    }
                }else
                {
                    return RedirectToAction("Index", "Login");
                }
               
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}