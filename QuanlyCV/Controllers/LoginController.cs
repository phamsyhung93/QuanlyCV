﻿using QuanlyCV.Common;
using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    public class LoginController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult login(string EmployeeEmail,string EmployeePassword)
        {
            try
            {
                var pass = Unti.Utility.getHashedMD5(EmployeePassword);
                Employee e = db.Employees.SingleOrDefault(x => x.EmployeeEmail.ToLower().Equals(EmployeeEmail.ToLower()) && x.EmployeePassword.StartsWith(pass) && x.EmployeePassword.EndsWith(pass));
                if(e != null)
                {
                    Session["EmployeeId"] = e.EmployeeId;
                    Session["EmployeeName"] = e.EmployeeFullname;
                    return RedirectToAction("Index", "Home");
                }else
                {
                    return RedirectToAction("Index");
                }
                
            }
            catch (Exception)
            {
                return RedirectToAction("Index");
                throw;
            }
        }
        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register(Employee e)
        {
            try
            {
                var pass = Unti.Utility.getHashedMD5(e.EmployeePassword);
                e.EmployeePassword = pass;
                e.EmployeeStatus = 1;
                e.EmployeeGender = 1;
                db.Employees.Add(e);
                db.SaveChanges();
                TempData["error"] = "đăng ký thành công"; 
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["error"] = "đăng không thành công";
                return View();
                throw;
            }
        }
        public ActionResult ForgotPassword()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ForgotPassword(string EmployeeEmail)
        {
            try
            {
                Employee e = db.Employees.SingleOrDefault(x => x.EmployeeEmail.ToLower().Equals(EmployeeEmail.ToLower()));
                if (e != null)
                {
                    e.EmployeePassword = Unti.Utility.getHashedMD5("1234");
                    db.Entry(e).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    string content = System.IO.File.ReadAllText(Server.MapPath("~/Template/content.html"));
                    content = content.Replace("{{CustomerName}}", e.EmployeeFullname);
                    content = content.Replace("{{Email}}", e.EmployeeEmail);

                    new MailHelper().SendMail(e.EmployeeEmail, "Password Reset", content);
                    TempData["error"] = "cập nhật lại mật khẩu thành công , bạn vào mail để nhận lại mật khẩu";
                    return RedirectToAction("Index");
                }else
                {
                    TempData["error"] = "mật khẩu không đúng hoặc chưa được đăng ký";
                    return View();
                }
               
            }
            catch (Exception ex)
            {
                
                return View();
                throw;
            }
        }
        public ActionResult logout()
        {
            try
            {
                Session["EmployeeId"] = null;
                Session["EmployeeName"] = null;
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                return RedirectToAction("Index");
                throw;
            }
        }
    }
}