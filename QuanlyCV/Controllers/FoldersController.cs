using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanlyCV.Controllers
{
    [AuthorizePermissions]
    public class FoldersController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        public ActionResult Index()
        {
            if(Session["EmployeeId"] != null)
            {
                int id = (int)Session["EmployeeId"];
                var listFolderByProject = db.Folders.Where(x => x.EmployeeId == id && x.FolderStatus == 1).ToList();

                return View(listFolderByProject);
            }else
            {
                return RedirectToAction("Index", "Login");
            }
            
        }
        public PartialViewResult LoadModelAddFolderByEmployee(int id)
        {
            try
            {
                Folder f = db.Folders.Find(id);
                return PartialView(f);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult addFolderByEmployee(string FolderName,int FolderId)
        {
            try
            {
                int id = (int)Session["EmployeeId"];
                Folder f = new Folder();
                f.FolderName = FolderName;
                f.EmployeeId = id;
                f.ParentId = FolderId;
                f.FolderStatus = 1;
                db.Folders.Add(f);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [HttpPost]
        public bool UpdateNameFolderByEmployee(int id,string FolderName)
        {
            try
            {
                Folder f = db.Folders.Find(id);
                f.FolderName = FolderName;
                f.FolderStatus = 1;
                db.Entry(f).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
                throw;
            }
        }
        public PartialViewResult loadListFolderByEmployee()
        {
            try
            {
                int id = (int)Session["EmployeeId"];
                var listFolderByProject = db.Folders.Where(x => x.EmployeeId == id && x.FolderStatus == 1).ToList();
                return PartialView(listFolderByProject);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [HttpPost]
        public Boolean DeleteFolderByEmployee(int id)
        {
            try
            {
                Folder f = db.Folders.Find(id);
                f.FolderStatus = 2;
                db.Entry(f).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
                throw;
            }
        }
        public PartialViewResult loadlistFileByFolderIdByEmployee(int id)
        {
            try
            {
                int idEmployee = (int)Session["EmployeeId"];
                if (id == 4)
                {
                    var lstFile = db.Files.Where(x => x.EmployeeId == idEmployee && x.FileStatus == 1).ToList();
                    ViewBag.lstFile = lstFile;
                }
                else
                {
                    var lstFile = db.Files.Where(x => x.EmployeeId == idEmployee && x.FolderId == id && x.FileStatus == 1).ToList();
                    ViewBag.lstFile = lstFile;
                }
                return PartialView();
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        public PartialViewResult loadlistFileByFolderIdByEmployeeCol6(int id)
        {
            try
            {
                int idEmployee = (int)Session["EmployeeId"];
                if (id == 4)
                {
                    var lstFile = db.Files.Where(x => x.EmployeeId == idEmployee && x.FileStatus == 1).ToList();
                    ViewBag.lstFile = lstFile;
                }
                else
                {
                    var lstFile = db.Files.Where(x => x.EmployeeId == idEmployee && x.FolderId == id && x.FileStatus == 1).ToList();
                    ViewBag.lstFile = lstFile;
                }
                return PartialView();
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        public PartialViewResult searchFile(int id, string name)
        {
            try
            {
                int idEmployee = (int)Session["EmployeeId"];
                if (id == null || id <= 0)
                {
                    ViewBag.lstFile = db.Files.Where(x => x.FileStatus == 1 && x.EmployeeId == idEmployee).ToList();
                }
                else
                {
                    if (name == "" || name == null || name.Length <= 0)
                    {
                        if(id == 4)
                        {
                            ViewBag.lstFile = db.Files.Where(x => x.FileStatus == 1 && x.EmployeeId == idEmployee).ToList();
                        }else
                        {
                            ViewBag.lstFile = db.Files.Where(x => x.FileStatus == 1 && x.EmployeeId == idEmployee && x.FolderId == id).ToList();
                        }
                    }
                    else
                    {
                        if(id == 4)
                        {
                            ViewBag.lstFile = db.Files.Where(x => x.FileName.ToLower().Contains(name.ToLower()) && x.EmployeeId == idEmployee && x.FileStatus == 1).ToList();
                        }
                        else
                        {
                            ViewBag.lstFile = db.Files.Where(x => x.FileName.ToLower().Contains(name.ToLower()) && x.FolderId == id && x.EmployeeId == idEmployee && x.FileStatus == 1).ToList();
                        }
                        
                    }
                }
               
                return PartialView();
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public PartialViewResult LoadModelAddFileByEmployee(int id)
        {
            try
            {
                Folder f = db.Folders.Find(id);
                return PartialView(f);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult addFileByFolderId()
        {
            try
            {
                int idEmployee = (int)Session["EmployeeId"];
                HttpFileCollectionBase files = Request.Files;
                var form = Request.Form;
                var id = form.Get("FolderId");
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFileBase file = files[i];
                    var InputFileName = Path.GetFileName(file.FileName);
                    var ServerSavePath = Path.Combine(Server.MapPath("~/Content/Uploads/") + InputFileName);
                    file.SaveAs(ServerSavePath);
                    Models.File f = new Models.File();
                    f.EmployeeId = idEmployee;
                    f.FolderId = int.Parse(id);
                    f.FileName = InputFileName;
                    f.FileStatus = 1;
                    db.Files.Add(f);
                    db.SaveChanges();
                }
                return Json("True");
            }
            catch (Exception ex)
            {
                return Json("False");
                throw;
            }
        }
    }
}