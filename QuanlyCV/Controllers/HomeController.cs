using Newtonsoft.Json.Linq;
using QuanlyCV.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace QuanlyCV.Controllers
{
    public class HomeController : Controller
    {

        WorkManagermentEntities db = new WorkManagermentEntities();
        public ActionResult Index()
        {
            try
            {
                if (Session["EmployeeId"] != null)
                {
                    int id = (int)Session["EmployeeId"];
                    DepartmentEmployee de = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == id);
                    GrantPermission gp = db.GrantPermissions.SingleOrDefault(x => x.DepartmentEmployeeId == de.DepartmentEmployeeId);
                    var pm = db.ProjectMembers.Where(x => x.GrantPermissionId == gp.GrantPermissionId).ToList();
                    ViewBag.ProjectMembers = pm;
                    var lstProject = db.Projects.Where(x => x.ProjectStatus == 1).ToList();
                    var lstDepartments = db.Departments.Where(x => x.DepartmentStatus == 1).ToList();
                    ViewBag.listProject = lstProject;
                    ViewBag.listDepartment = lstDepartments;
                    var lstProjectByProjectType = db.sp_GetAllYEARByProjectType();
                    ViewBag.lstProjectBYProjectType = lstProjectByProjectType;
                    var lstEmployee = db.sp_GetAllEmployeeByDepartment().ToList();
                    ViewBag.lstEmployeeByDepartmentId = lstEmployee;
                    return View();
                }
                else
                {
                    return RedirectToAction("Index", "Login");

                }
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public PartialViewResult loadlistProject(int id, int? year)
        {
            try
            {
                int idEmployee = (int)Session["EmployeeId"];
                DepartmentEmployee de = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == idEmployee);
                GrantPermission gp = db.GrantPermissions.SingleOrDefault(x => x.DepartmentEmployeeId == de.DepartmentEmployeeId);
                var pm = db.ProjectMembers.Where(x => x.GrantPermissionId == gp.GrantPermissionId).ToList();
                ViewBag.ProjectMembers = pm;
                if (id == 1)
                {
                    var lstProject = db.Projects.Where(x => x.ProjectStatus == 1 && x.ProjectTypeId == 1).ToList();
                    ViewBag.listProject = lstProject;
                    return PartialView();
                }
                else
                {
                    
                    var lstProject = db.Projects.Where(x => x.ProjectStatus == 1 && x.ProjectTypeId == 2 && x.StartTime.Year == year).ToList();
                    ViewBag.listProject = lstProject;
                    return PartialView();
                }

            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }
        [HttpPost]
        public ActionResult CreateProject(string ProjectName, string ProjectDescription, int ProjectTypeId, DateTime StartTime, DateTime EndTime, int ProjectStatus, int[] DepartmentId, int[] EmployeeId)
        {
            try
            {
                Project p = new Project();
                p.ProjectName = ProjectName;
                p.ProjectDescription = ProjectDescription;
                p.ProjectTypeId = ProjectTypeId;
                p.StartTime = StartTime;
                p.EndTime = EndTime;
                p.ProjectStatus = ProjectStatus;
                db.Projects.Add(p);
                db.SaveChanges();
                int id = 0;
                for (int i = 0; i < EmployeeId.Length; i++)
                {
                    id = EmployeeId[i];
                    DepartmentEmployee dp = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == id);
                    GrantPermission gp = db.GrantPermissions.SingleOrDefault(x => x.DepartmentEmployeeId == dp.DepartmentEmployeeId);
                    ProjectMember pm = new ProjectMember();
                    pm.ProjectId = p.ProjectId;
                    pm.GrantPermissionId = gp.GrantPermissionId;
                    pm.ProjectMemberStatus = 1;
                    db.ProjectMembers.Add(pm);
                }
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index");
                throw;
            }
        }

        public PartialViewResult loadProgressWorking(int ProjectId)
        {
            try
            {
                int id = (int)Session["EmployeeId"];
                ViewBag.Employee = db.Employees.SingleOrDefault(x => x.EmployeeId == id && x.EmployeeStatus == 1);
                var listProjctDiscussionsByProjectId = db.sp_getAllProjectDiscussionsByProjectId(ProjectId);
                ViewBag.lstProjectDiscussionsByProjectId = listProjctDiscussionsByProjectId;
                ViewBag.ProjectId = ProjectId;
                var listFolderByProject = db.Folders.Where(x => x.ProjectId == ProjectId && x.FolderStatus == 1).ToList();
                ViewBag.lstFolderByProject = listFolderByProject;
                DepartmentEmployee d = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == id);
                List<Form> f = db.Forms.Where(x => x.DepartmentId == d.DepartmentId).ToList();
                ViewBag.Form = f;
                return PartialView();
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [HttpGet]
        public JsonResult EmpDetails()
        {
            int id = (int)Session["EmployeeId"];
            DepartmentEmployee d = db.DepartmentEmployees.SingleOrDefault(x => x.EmployeeId == id);
            List<Form> f = db.Forms.Where(x => x.DepartmentId == d.DepartmentId).ToList();
            List<string> nameFrom = new List<string>();
            //List<FormContent> formContent;
            
            //for (int i = 0; i < f.Count; i++)
            //{
            //    nameFrom.Add(f[i].FormContent.ToString());
            //    JavaScriptSerializer js = new JavaScriptSerializer();
            //    //formContent = js.Deserialize<FormContent[]>(name);
            //    //ViewBag.FormContent = formContent;
            //}
            //string combindedString = string.Join(",", nameFrom.ToArray());
            //JObject json = JObject.Parse(combindedString);

            //ViewBag.FormName = json;
            //ViewBag.Form = f;
            //Creating List
            //    List<Employee> ObjEmp = new List<Employee>()
            //    {
            ////Adding records to list
            //new Employee {Id=1,Name="Vithal Wadje",City="Latur",Address="Kabansangvi" },
            //new Employee {Id=2,Name="Sudhir Wadje",City="Mumbai",Address="Kurla" }
            //    };
            //return list as Json
            //return Json(formContent, JsonRequestBehavior.AllowGet);
            return Json("True");
        }
        [HttpPost]
        public bool insertProjectDiscussions(string DiscussionContent)
        {
            try
            {
                int id = (int)Session["EmployeeId"];
                MemberDiscussion md = db.MemberDiscussions.SingleOrDefault(x => x.EmployeeId == id);
                ProjectDiscussion pd = new ProjectDiscussion();
                pd.MemberDiscussionId = md.MemberDiscussionId;
                pd.DiscussionContent = DiscussionContent;
                pd.ProjectDiscussionStatus = 1;
                db.ProjectDiscussions.Add(pd);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
                throw;
            }
        }
        public PartialViewResult loadContentChat()
        {
            try
            {
                int id = (int)Session["EmployeeId"];
                MemberDiscussion md = db.MemberDiscussions.SingleOrDefault(x => x.EmployeeId == id);
                var listProjctDiscussionsByProjectId = db.sp_getAllProjectDiscussionsByProjectId(md.ProjectId);
                ViewBag.lstProjectDiscussionsByProjectId = listProjctDiscussionsByProjectId;
                return PartialView();
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }
        public PartialViewResult loadModelAddFolder(int id,int ProjectId)
        {
            try
            {
                Folder f = db.Folders.Find(id);
                ViewBag.projectId = ProjectId;
                return PartialView(f);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [HttpPost]
        public Boolean CreateFolderByProject(string FolderName,int FolderId,int ProjectId)
        {
            try
            {
                Folder f = new Folder();
                f.FolderName = FolderName;
                f.ParentId = FolderId;
                f.ProjectId = ProjectId;
                f.FolderStatus = 1;
                db.Folders.Add(f);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
                throw;
            }
        }
        public PartialViewResult loadListFolderByProjectId(int id)
        {
            try
            {
                ViewBag.ProjectId = id;
                var listFolderByProject = db.Folders.Where(x => x.ProjectId == id && x.FolderStatus == 1).ToList();
                ViewBag.lstFolderByProject = listFolderByProject;
                return PartialView();
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public bool DeleteFolder(int id)
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
        [HttpPost]
        public Boolean UpdateNameFolder(int id , string FolderName, int ProjectId)
        {
            try
            {
                Folder f = db.Folders.Find(id);
                f.FolderName = FolderName;
                f.ProjectId = ProjectId;
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

        public PartialViewResult loadlistFileByFolderId(int id,int ProjectId)
        {
            try
            {
                if(id == 1)
                {
                    ViewBag.lstFile = db.Files.Where(x => x.FileStatus == 1 && x.ProjectId == ProjectId).ToList();
                }else
                {
                    ViewBag.lstFile = db.Files.Where(x => x.FolderId == id && x.ProjectId == ProjectId && x.FileStatus == 1).ToList();
                }
                

                return PartialView();
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }
        public PartialViewResult loadlistFileByFolderIdCol6(int id, int ProjectId)
        {
            try
            {
                if (id == 1)
                {
                    ViewBag.lstFile = db.Files.Where(x => x.FileStatus == 1).ToList();
                }
                else
                {
                    ViewBag.lstFile = db.Files.Where(x => x.FolderId == id && x.ProjectId == ProjectId && x.FileStatus == 1).ToList();
                }


                return PartialView();
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }

        public PartialViewResult searchFileByProject(int id, string name, int idProject)
        {
            try
            {
                int idEmployee = (int)Session["EmployeeId"];
                if (id == null || id <= 0)
                {
                    ViewBag.lstFile = db.Files.Where(x => x.FileStatus == 1 && x.ProjectId == idProject).ToList();
                }
                else
                {
                    if (name == "" || name == null || name.Length <= 0)
                    {
                        if (id == 1)
                        {
                            ViewBag.lstFile = db.Files.Where(x => x.FileStatus == 1 && x.ProjectId == idProject).ToList();
                        }
                        else
                        {
                            ViewBag.lstFile = db.Files.Where(x => x.FileStatus == 1 && x.ProjectId == idProject && x.FolderId == id).ToList();
                        }
                    }
                    else
                    {
                        if(id == 1)
                        {
                            ViewBag.lstFile = db.Files.Where(x => x.FileName.ToLower().Contains(name.ToLower()) && x.ProjectId == idProject && x.FileStatus == 1).ToList();
                        }
                        else
                        {
                            ViewBag.lstFile = db.Files.Where(x => x.FileName.ToLower().Contains(name.ToLower()) && x.FolderId == id && x.ProjectId == idProject && x.FileStatus == 1).ToList();
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

        public PartialViewResult LoadModelAddFileByProject(int id,int ProjectId)
        {
            try
            {
                Folder f = db.Folders.Find(id);
                ViewBag.ProjectId = ProjectId;
                return PartialView(f);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [HttpPost]
        public ActionResult addFileByFolderIdByProject()
        {
            try
            {
                HttpFileCollectionBase files = Request.Files;
                var form = Request.Form;
                var id = form.Get("FolderId");
                var projectid = form.Get("ProjectId");
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFileBase file = files[i];
                    var InputFileName = Path.GetFileName(file.FileName);
                    var ServerSavePath = Path.Combine(Server.MapPath("~/Content/Uploads/") + InputFileName);
                    file.SaveAs(ServerSavePath);
                    Models.File f = new Models.File();
                    f.FolderId = int.Parse(id);
                    f.ProjectId = int.Parse(projectid);
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

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult Error()
        {
            return View();
        }
    }
}