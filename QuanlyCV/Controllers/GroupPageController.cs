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
    public class GroupPageController : Controller
    {
        WorkManagermentEntities db = new WorkManagermentEntities();
        public ActionResult Index(int id)
        {
            if (Session["EmployeeId"] != null)
            {
                int idEmployee = (int)Session["EmployeeId"];
                //Group g = db.Groups.SingleOrDefault(x => x.EmployeeId == idEmployee);
                var lstPost = db.sp_getAllPostbyGroupID(id);
                ViewBag.listGroupMember = db.GroupMembers.Where(x => x.GroupMemberStatus == 1).ToList();
                ViewBag.listPost = lstPost;
                var group = db.sp_getEmployeeCreateGroup(id).Take(1);
                ViewBag.Group = group;
                ViewBag.GroupId = id;
                var lstLike = db.sp_getAllEmployeeLikePost().ToList();
                ViewBag.listLike = lstLike;
                ViewBag.EmployeeId = idEmployee;
                var lstComment = db.sp_getAllCommentByGroupId(id).ToList();
                ViewBag.lstCommentByGroup = lstComment;
                ViewBag.Employee = db.Employees.Find(idEmployee);
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
            
        }

        
        [HttpPost]
        public bool outGroup()
        {
            try
            {
                int id = (int)Session["EmployeeId"];

                GroupMember gm = db.GroupMembers.SingleOrDefault(x => x.EmployeeId == id);
                gm.GroupMemberStatus = 2;
                db.Entry(gm).State = System.Data.Entity.EntityState.Modified;
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
        public ActionResult createGroup(int GroupId,string PostContent, HttpPostedFileBase uploadGroup)
        {
            try
            {
                if (Session["EmployeeId"] == null)
                {
                    return RedirectToAction("Index", "Login");
                }
                int id = (int)Session["EmployeeId"];
                GroupMember gm = db.GroupMembers.SingleOrDefault(x => x.GroupId == GroupId && x.EmployeeId == id);
                var nowDate = DateTime.Now;
                Post p = new Post();
                p.GroupId = GroupId;
                p.GroupMemberId = gm.GroupMemberId;
                p.PostContent = PostContent;
                p.PostedTime = nowDate;
                p.PostStatus = 1;
                db.Posts.Add(p);
                db.SaveChanges();
                if (uploadGroup != null)
                {
                    PostImage pi = new PostImage();
                    pi.PostId = p.PostId;
                    var InputFileName = Path.GetFileName(uploadGroup.FileName);
                    var ServerSavePath = Path.Combine(Server.MapPath("~/Content/Uploads/Group"), InputFileName);
                    uploadGroup.SaveAs(ServerSavePath);
                    pi.PostImages = InputFileName;
                    pi.PostImageStatus = 1;
                    db.PostImages.Add(pi);
                    db.SaveChanges();
                }else
                {
                    PostImage pi = new PostImage();
                    pi.PostId = p.PostId;
                    pi.PostImages = "1";
                    pi.PostImageStatus = 1;
                    db.PostImages.Add(pi);
                    db.SaveChanges();
                }
                
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index");
                throw;
            }
        }
        [HttpPost]
        public PartialViewResult LikePost(int id)
        {
            try
            {
                int idEmployee = (int)Session["EmployeeId"];
                Like like = db.Likes.SingleOrDefault(x => x.PostId == id && x.EmployeeId == idEmployee);
                if(like != null)
                {
                    like.LikeStatus = 1;
                    db.Entry(like).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                }
                else
                {
                    Like l = new Like();
                    l.PostId = id;
                    l.LikeStatus = 1;
                    l.EmployeeId = idEmployee;
                    l.EmotionId = 1;
                    db.Likes.Add(l);
                    db.SaveChanges();
                }
                var lstLike = db.sp_getAllEmployeeLikePostByPostid(id).ToList();
                ViewBag.listLike = lstLike; 
                return PartialView();
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }
        [HttpPost]
        public PartialViewResult unLikePost(int id)
        {
            try
            {
                int idEmployee = (int)Session["EmployeeId"];
                Like like = db.Likes.SingleOrDefault(x => x.PostId == id && x.EmployeeId == idEmployee);
                like.LikeStatus = 2;
                db.Entry(like).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                var lstLike = db.sp_getAllEmployeeLikePostByPostid(id).ToList();
                ViewBag.listLike = lstLike;
                return PartialView();
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }
        [HttpPost]
        public PartialViewResult CommentPost(int id, string content)
        {
            try
            {
                int employeeId = (int)Session["EmployeeId"];
                Comment m = new Comment();
                m.CommentContent = content;
                m.ParentId = 0;
                m.CommentImage = id+content;
                m.PostId = id;
                m.EmployeeId = employeeId;
                m.CommentTime = DateTime.Now;
                m.CommentStatus = 1;
                db.Comments.Add(m);
                db.SaveChanges();
                ViewBag.listCommentPost = db.sp_getAllCommentByPostId(id).ToList();
                ViewBag.Employee = db.Employees.Find(employeeId);
                return PartialView();
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }

        public PartialViewResult SubCommentPost(int id, string content, int CommentId)
        {
            try
            {
                int employeeId = (int)Session["EmployeeId"];
                Comment m = new Comment();
                m.CommentContent = content;
                m.ParentId = CommentId;
                m.CommentImage = id + content;
                m.PostId = id;
                m.EmployeeId = employeeId;
                m.CommentTime = DateTime.Now;
                m.CommentStatus = 1;
                db.Comments.Add(m);
                db.SaveChanges();
                ViewBag.listCommentPost = db.sp_getAllCommentByPostId(id).ToList();
                int count = ViewBag.listCommentPost.Count;
                ViewBag.lstComnetPost1 = db.sp_getAllCommentByPostId(id).ToList().Take(count);
                ViewBag.Employee = db.Employees.Find(employeeId);
                return PartialView();
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }
    }
}