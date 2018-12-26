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
    public class TimeLineController : Controller
    {
        private WorkManagermentEntities db = new WorkManagermentEntities();
        public ActionResult Index()
        {
            if (Session["EmployeeId"] == null)
            {
                return RedirectToAction("Index", "Login");
            }
            int employeeId = (int)Session["EmployeeId"];
            TimeLine t = db.TimeLines.SingleOrDefault(x => x.EmployeeId == employeeId);
            ViewBag.TimeLineDetail = db.sp_GetAllTimeLineDetail(employeeId).ToList();
            var  n = db.Notes.Where(x => x.EmployeeId == employeeId).ToList();
            ViewBag.NoteEmployee = n;
            var tl = db.sp_getEmployeeByTimeLine(employeeId).ToList();
            ViewBag.Timeline = tl;
            var like = db.sp_getAllEmployeeLikeTimeLineDetail().ToList();
            ViewBag.LikeTimeline = like;
            ViewBag.EmployeeId = employeeId;
            var lstComment = db.sp_getAllCommentByTimeLineId(t.TimeLineId).ToList();
            ViewBag.lstCommentByGroup = lstComment;
            ViewBag.Employee = db.Employees.Find(employeeId);
            return View();
        }

        [HttpPost]
        public ActionResult Create(TimeLineDetailModel timeLineDetailModel, HttpPostedFileBase TimeLineImage)
        {
            if (Session["EmployeeId"] == null)
            {
                return RedirectToAction("Index", "Login");
            }
            int timeLineId = (int)Session["EmployeeId"];
            var nowDate = DateTime.Now;
            TimeLineDetail timeLineDetail = new TimeLineDetail();
            timeLineDetail.TimeLineDetailContent = timeLineDetailModel.TimeLineDetailContent;
            timeLineDetail.TimeLineDetailPostedTime = nowDate;
            timeLineDetail.TimeLineId = timeLineId;
            timeLineDetail.TimeLineDetailType = timeLineDetailModel.TimeLineDetailType;
            timeLineDetail.TimeLineDetailStatus = 1;
            db.TimeLineDetails.Add(timeLineDetail);

            //foreach (HttpPostedFileBase file in TimeLineImage)
            //{  
            if (TimeLineImage != null)
            {
                TimeLineImage timeLineImage = new TimeLineImage();
                timeLineImage.TimeLineDetailId = timeLineDetail.TimeLineDetailId;
                var InputFileName = Path.GetFileName(TimeLineImage.FileName);
                var ServerSavePath = Path.Combine(Server.MapPath("~/Content/Uploads/timelines"), InputFileName);
                TimeLineImage.SaveAs(ServerSavePath);
                timeLineImage.TimeLineImages = InputFileName;
                timeLineImage.TimeLineImageStatus = 1;
                db.TimeLineImages.Add(timeLineImage);
                db.SaveChanges();
            }else
            {
                TimeLineImage timeLineImage = new TimeLineImage();
                timeLineImage.TimeLineDetailId = timeLineDetail.TimeLineDetailId;
                timeLineImage.TimeLineImages = "1";
                timeLineImage.TimeLineImageStatus = 1;
                db.TimeLineImages.Add(timeLineImage);
                db.SaveChanges();
            }
            //}
            return RedirectToAction("Index");
        }
        [HttpPost]
        public bool updateTimelineDescription(string content)
        {
            try
            {
                int employeeId = (int)Session["EmployeeId"];
                TimeLine tl = db.TimeLines.SingleOrDefault(x => x.EmployeeId == employeeId);
                tl.TimeLineDescription = content;
                db.Entry(tl).State = System.Data.Entity.EntityState.Modified;
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
        public PartialViewResult LikeTimeLineDetail(int id)
        {
            try
            {
                int idEmployee = (int)Session["EmployeeId"];
                Like like = db.Likes.SingleOrDefault(x => x.TimeLineDetailId == id && x.EmployeeId == idEmployee);
                if(like != null)
                {
                    like.LikeStatus = 1;
                    db.Entry(like).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                }
                else
                {
                    Like l = new Like();
                    l.TimeLineDetailId = id;
                    l.LikeStatus = 1;
                    l.EmployeeId = idEmployee;
                    l.EmotionId = 1;
                    db.Likes.Add(l);
                    db.SaveChanges();
                }
                var lstLike = db.sp_getAllEmployeeLikeTimeLineDetailByDetailId(id).ToList();
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
        public PartialViewResult unLikeTimeDetail(int id)
        {
            try
            {
                int idEmployee = (int)Session["EmployeeId"];
                Like like = db.Likes.SingleOrDefault(x => x.TimeLineDetailId == id && x.EmployeeId == idEmployee);
                like.LikeStatus = 2;
                db.Entry(like).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                var lstLike = db.sp_getAllEmployeeLikeTimeLineDetailByDetailId(id).ToList();
                ViewBag.listLike = lstLike;
                return PartialView();
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }
        public PartialViewResult CommentTimeLineDetail(int id ,string content)
        {
            try
            {
                int employeeId = (int)Session["EmployeeId"];
                Comment m = new Comment();
                m.CommentContent = content;
                m.ParentId = 0;
                m.CommentImage = id + content;
                m.TimeLineDetailId = id;
                m.EmployeeId = employeeId;
                m.CommentTime = DateTime.Now;
                m.CommentStatus = 1;
                db.Comments.Add(m);
                db.SaveChanges();
                ViewBag.listCommentlstTimeLineDetail = db.sp_getAllCommentByTimelineDetailId(id).ToList();
                ViewBag.Employee = db.Employees.Find(employeeId);
                return PartialView();
            }
            catch (Exception ex)
            {
                return PartialView();
                throw;
            }
        }
        public PartialViewResult SubCommentTimeLineDetail(int id, string content, int CommentId)
        {
            try
            {
                int employeeId = (int)Session["EmployeeId"];
                Comment m = new Comment();
                m.CommentContent = content;
                m.ParentId = CommentId;
                m.CommentImage = id + content;
                m.TimeLineDetailId = id;
                m.EmployeeId = employeeId;
                m.CommentTime = DateTime.Now;
                m.CommentStatus = 1;
                db.Comments.Add(m);
                db.SaveChanges();
                ViewBag.listCommentlstTimeLineDetail = db.sp_getAllCommentByTimelineDetailId(id).ToList();
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