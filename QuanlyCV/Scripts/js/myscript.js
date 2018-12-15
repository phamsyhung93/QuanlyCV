var folderSelect = 0;
// <<<<<============================== Trang index ==============================
function setContentForSlide(clName) {
	var bgColor = $(clName).css('backgroundColor');
	console.log(bgColor);
	$("#content-slider>li").css("background-color", bgColor);
}

function addNewWorkingInProgress(id) {
	$("#" + id).css("display", "block");
}

function closeChatSidebar() {
	$("#chat-sidebar").css("display", "none");
	$(".chat-sidebar-open").css("display", "flex");
	$(".text-close-sidebar-chat").text("Đóng khung chat");
}

function openChatSidebar() {
	$("#chat-sidebar").css("display", "block");
	$(".chat-sidebar-open").css("display", "none");
	$(".text-open-sidebar-chat").text("Mở khung chat");
}

$(".a-sub-content").hover(function() {
	var divHeight = $(this).children(".div-sub-content").height();
	$(this).children(".cover-sub-content").css("display", "block");
	$(".edit-sub-content").css("display","block");
	$(this).children(".cover-sub-content").css("height", (divHeight + 10) + "px");
}, function() {
	$(this).children(".cover-sub-content").css("display", "none");
	$(".edit-sub-content").css("display","none");
});
function openEditSubContent(){
	var modalEditSubContent = document.getElementById('ModalEditSubContent');
	var spanEditSubContent = document.getElementsByClassName("ModalEditSubContentclose")[0];
	modalEditSubContent.style.display = "block";
	spanEditSubContent.onclick = function() {
		modalEditSubContent.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalEditSubContent) {
			modalEditSubContent.style.display = "none";
		}
	}
}
$(".edit-sub-content").click(function() {
	var position = $(this).position();
	var top = position.top;
	var left = position.left;
	// $("#ModalDetailWork").css("visibility","hidden");
	// $(".modal-content").css("z-index",10);
	// $(this).css("position", "relative");
	// $(this).parent().siblings(".modal-edit-sub-content").children(".modal-content").css("position", "absolute");
	
	var modalEditSubContent = document.getElementById('modal-edit-sub-content');
	modalEditSubContent.style.display = "block";
	// modalEditSubContent.style.z-index = "1";
	// $(this).parent().siblings(".modal-edit-sub-content").children(".modal-content").css("margin-left", (left + 100) + "px");
	// $(this).parent().siblings(".modal-edit-sub-content").children(".modal-content").css("top", top + "px");
	window.onclick = function(event) {
		if (event.target == modalEditSubContent) {
			modalEditSubContent.style.display = "none";
		}
	}
});
$(".cover-sub-content").click(function(event) {
	$("#ModalDetailWork").removeClass('hide')
});

// <<<<<========== thêm mới công việc ==========
$(".a-add-new-job").click(function() {
	$(this).parent().siblings(".list-content").children(".add-sub-project").css("display", "block");
	$(this).parent().css("display", "none");
});
// ========== thêm mới công việc ==========>>>>>

$(".cancel-add-new").click(function() {
	$(this).parents(".add-sub-project").css("display", "none");
	$(this).parents(".list-content").siblings(".div-add-new-progress").css("display", "block");
});

$(".other-option").click(function() {

});

$(".btn-do-add").click(function() {
	var text = $(this).parent().siblings("textarea").val();
	$(this).parents(".add-sub-project").css("display", "none");
	
	// $(this).parents(".add-sub-project").siblings(".abc").append("<a href='javascript:;' class='a-sub-content'>" +
	// 												"<div class='div-sub-content'><span>" + text + "</span></div>" +
	// 												"<div class=cover-sub-content>"+
	// 											"<i class='fa fa-pencil edit-sub-content' data-id='2'></i></div></a>");
	$(this).parents(".list-content").siblings(".div-add-new-progress").css("display", "block");
	$(this).parent().siblings("textarea").val("");

	$(".a-sub-content").hover(function() {
		var divHeight = $(this).children(".div-sub-content").height();
		$(this).children(".cover-sub-content").css("display", "block");
		// $(this).children(".cover-sub-content").css("height", (divHeight + 10) + "px");
		// $(this).children(".cover-sub-content").css("top", (-divHeight - 10) + "px");
	}, function() {
		$(this).children(".cover-sub-content").css("display", "none");
	});

	$(".edit-sub-content").click(function() {
	// var a = $(this).parent().siblings(".div-sub-content").children("span").html();
	// alert(a);
	// $("#ModalDetailWork").css("visibility","hidden");

	var a = $(this).data("id");
	alert(a);

});
});

//<<<<<=========================khu chua modal them moi cong viec==========
	$('select').on('change', function (e) {
	    var optionSelected = $("option:selected", this);
	    var valueSelected = this.value;
	    if(valueSelected == 'duan'){
	    	$(".duan").css("display","block");
	    	$(".cvthuong").css("display","none");
	    }else if(valueSelected == 'cvthuong'){
	    	$(".duan").css("display","none");
	    	$(".cvthuong").css("display","none");
	    }else{
	    	$(".duan").css("display","none");
	    	$(".cvthuong").css("display","none");
	    }
});
function setActiveMenuleft(e){
  $(".li-menu-left").removeClass('active');
  $(e).addClass('active');
}

$(".input1").click(function(event) {
	var form1 = document.getElementById('form1');
	$(".form1").css("display","block");
	$(".btn-bottom-textarea").css("top","300px");
	window.onclick = function(event) {
		if (event.target == form1) {
			form1.style.display = "none";
			$(".btn-bottom-textarea").css("top","260px");
		}
	}
});
function deleteTextarea(){
	$(".input1").val("");
	var form1 = document.getElementById('form1');
	form1.style.display = "none";
	$(".btn-bottom-textarea").css("top","260px");

}
// $(".input1").blur(function(event) {
// 	var form1 = document.getElementById('form1');
// 	if (event.target == form1) {
// 			form1.style.display = "block";
// 			// $(".btn-bottom-textarea").css("top","260px");
// 		}
// 	$(".form1").css("display","none");
// 	$(".btn-bottom-textarea").css("top","260px");
// });

$(".btn-show-detail-1").click(function(event) {
	$(".div-detail").css("display","block");
	$(".btn-show-detail-1").addClass('hide');
	$(".btn-show-detail-2").removeClass('hide');
});
$(".btn-show-detail-2").click(function(event) {
	$(".div-detail").css("display","none");
	$(".btn-show-detail-2").addClass('hide');
	$(".btn-show-detail-1").removeClass('hide');
});
// $(document).click(function(){
// 	alert($(".form1").is(':visible'))
// 	// if($(".form1").is(':visible')){
// 	// 	$(".form1").css("display","none");
// 	// }
// });

// <<<<<==================== khu chứa các js cho modal index ====================
// <<<<<========== modal open folder ==========
function openModalFolder() {
	var modalFolder = document.getElementById('modal-folder');
	var closeFolder = document.getElementsByClassName("close-modal-Folder")[0];
	modalFolder.style.display = "block";
	closeFolder.onclick = function() {
		modalFolder.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalFolder) {
			modalFolder.style.display = "none";
		}
	}
}
// ========== modal open folder ==========>>>>>
	
// <<<<<========== modal open discussion ==========
function openModalDiscussion() {
	var modalDiscussion = document.getElementById('modal-discussion');
	var spanDiscussion = document.getElementsByClassName("close-modal-discussion")[0];
	modalDiscussion.style.display = "block";
	spanDiscussion.onclick = function() {
		modalDiscussion.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalDiscussion) {
			modalDiscussion.style.display = "none";
		}
	}
}

function textAreaAdjust(o) {
	o.style.height = "1px";
	o.style.height = (25+o.scrollHeight)+"px";
}
// ========== modal open discussion ==========>>>>>
// ========== modal  chi tiet them cong viec =============>>>>>>
// modal can lam
function openModalCanLam(){
	var modalCanLam = document.getElementById('ModalCanLam');
	var closeModalCanLam = document.getElementsByClassName("ModalCanLamclose")[0];
	modalCanLam.style.display = "block";
	closeModalCanLam.onclick = function() {
		modalCanLam.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalCanLam) {
			modalCanLam.style.display = "none";
		}
	}
}
//modal tro giup
function openModalTroGiup(){
	var modalTroGiup = document.getElementById('ModalTroGiup');
	var closeModalTroGiup= document.getElementsByClassName("ModalTroGiupclose")[0];
	modalTroGiup.style.display = "block";
	closeModalTroGiup.onclick = function() {
		modalTroGiup.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalTroGiup) {
			modalTroGiup.style.display = "none";
		}
	}
}

function openModalDinhKem(){
	var modalDinhKem = document.getElementById('ModalDinhKem');
	var closeModalDinhKem= document.getElementsByClassName("ModalDinhKemclose")[0];
	modalDinhKem.style.display = "block";
	closeModalDinhKem.onclick = function() {
		modalDinhKem.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalDinhKem) {
			modalDinhKem.style.display = "none";
		}
	}
}
function openModalTag(){
	var modalTag = document.getElementById('ModalTag');
	var closeModalTag= document.getElementsByClassName("ModalTagclose")[0];
	modalTag.style.display = "block";
	closeModalTag.onclick = function() {
		modalTag.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalTag) {
			modalTag.style.display = "none";
		}
	}
}
function openModalBieuTuong(){
	var modalBieuTuong = document.getElementById('ModalBieuTuong');
	var closeModalBieuTuong= document.getElementsByClassName("ModalBieuTuongclose")[0];
	modalBieuTuong.style.display = "block";
	closeModalBieuTuong.onclick = function() {
		modalBieuTuong.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalBieuTuong) {
			modalBieuTuong.style.display = "none";
		}
	}
}
function openModalThemBang(){
	var modalThemBang = document.getElementById('ModalThemBang');
	var closeModalThemBang= document.getElementsByClassName("ModalThemBangclose")[0];
	modalThemBang.style.display = "block";
	closeModalThemBang.onclick = function() {
		modalThemBang.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalThemBang) {
			modalThemBang.style.display = "none";
		}
	}
}
function openModalThanhVien(){
	var modalThanhVien = document.getElementById('ModalThanhVien');
	var closeModalThanhVien= document.getElementsByClassName("ModalThanhVienclose")[0];
	modalThanhVien.style.display = "block";
	closeModalThanhVien.onclick = function() {
		modalThanhVien.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalThanhVien) {
			modalThanhVien.style.display = "none";
		}
	}
}
$(".li-thanh-vien").click(function(event) {
	var check =  document.getElementById("img-check-thanhvien");
	if(check.style.display === 'none'){
		 check.style.display = 'block';
	}else{
		check.style.display = 'none';
	}
});
function openModalNhan(){
	var modalNhan = document.getElementById('ModalNhan');
	var closeModalNhan= document.getElementsByClassName("ModalNhanclose")[0];
	modalNhan.style.display = "block";
	closeModalNhan.onclick = function() {
		modalNhan.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalNhan) {
			modalNhan.style.display = "none";
		}
	}
}
 function activeNhan(e) {
	$(".li-nhan").removeClass('active');
	$(e).addClass('active');

};
function openModalViecCanLam(){
	var modalViecCanLam = document.getElementById('ModalViecCanLam');
	var closeModalViecCanLam= document.getElementsByClassName("ModalViecCanLamclose")[0];
	modalViecCanLam.style.display = "block";
	closeModalViecCanLam.onclick = function() {
		modalViecCanLam.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalViecCanLam) {
			modalViecCanLam.style.display = "none";
		}
	}
}
function openModalNgayHetHan(){
	var modalNgayHetHan = document.getElementById('ModalNgayHetHan');
	var closeModalNgayHetHan= document.getElementsByClassName("ModalNgayHetHanclose")[0];
	modalNgayHetHan.style.display = "block";
	closeModalNgayHetHan.onclick = function() {
		modalNgayHetHan.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalNgayHetHan) {
			modalNgayHetHan.style.display = "none";
		}
	}
}
function openModalSaoChep(){
	var modalSaoChep = document.getElementById('ModalSaoChep');
	var closeModalSaoChep= document.getElementsByClassName("ModalSaoChepclose")[0];
	modalSaoChep.style.display = "block";
	closeModalSaoChep.onclick = function() {
		modalSaoChep.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalSaoChep) {
			modalSaoChep.style.display = "none";
		}
	}
}
$(".li-theo-doi").click(function(event) {
	var check =  document.getElementById("img-theo-doi");
	if(check.style.display === 'none'){
		 check.style.display = 'block';
	}else{
		check.style.display = 'none';
	}
});
$(".li-luu-tru").click(function(event) {
	var div =  document.getElementById("li-xoa");
	if(div.style.visibility === 'hidden'){
		 div.style.visibility = 'visible';
	}else{
		div.style.visibility = 'hidden';
	}
});
function openModalAddFolder(){
	var modalAddFolder = document.getElementById('ModalAddFolder');
	var closeModalAddFolder= document.getElementsByClassName("ModalAddFolderclose")[0];
	modalAddFolder.style.display = "block";
	closeModalAddFolder.onclick = function() {
		modalAddFolder.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalAddFolder) {
			modalAddFolder.style.display = "none";
		}
	}
}

function openModalSuaNhan(){
	var modalSuaNhan = document.getElementById('ModalSuaNhan');
	var closeModalSuaNhan= document.getElementsByClassName("ModalSuaNhanclose")[0];
	var modalNhan = document.getElementById('ModalNhan');
	modalSuaNhan.style.display = "block";
	modalNhan.style.display = "none";
	closeModalSuaNhan.onclick = function() {
		modalSuaNhan.style.display = "none";
		modalNhan.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalSuaNhan) {
			modalSuaNhan.style.display = "none";
		}
	}
}
function showModelNhan(){
	var modalSuaNhan = document.getElementById('ModalSuaNhan');
	var modalThemNhan = document.getElementById('ModalThemNhan');
	var modalNhan = document.getElementById('ModalNhan');
	modalNhan.style.display = "block";
	modalSuaNhan.style.display = "none";
	modalThemNhan.style.display = "none";
}

function setActiveEditColor(e){
	$(".divColor").removeClass('active');
	$(e).addClass('active');
}
function openModalThemNhan(){
	var modalThemNhan = document.getElementById('ModalThemNhan');
	var closeModalThemNhan= document.getElementsByClassName("ModalThemNhanclose")[0];
	var modalNhan = document.getElementById('ModalNhan');
	modalThemNhan.style.display = "block";
	modalNhan.style.display = "none";
	closeModalThemNhan.onclick = function() {
		modalThemNhan.style.display = "none";
		modalNhan.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalThemNhan) {
			modalThemNhan.style.display = "none";
		}
	}
}
	function setActiveMenuleft(e){
  $(".li-menu-left").removeClass('active');
  $(e).addClass('active');
}
	//
	function openComment(){
		 $(".wrapper-input-comment").css("visibility","visible");
	}
function openModalAddPlan(){
	var modalAddPlan= document.getElementById('modalAddPlan');
	var closeModalAddPlan= document.getElementsByClassName("closeModalAddPlan")[0];
	modalAddPlan.style.display = "block";
	closeModalAddPlan.onclick = function() {
		modalAddPlan.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalAddPlan) {
			modalAddPlan.style.display = "none";
		}
	}
}
function openModalNoiDung(){
	var modalNoiDung= document.getElementById('modalNoiDung');
	var closeModalNoiDung= document.getElementsByClassName("closeModalNoiDung")[0];
	modalNoiDung.style.display = "block";
	closeModalNoiDung.onclick = function() {
		modalNoiDung.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalNoiDung) {
			modalNoiDung.style.display = "none";
		}
	}
}
function openModalLienHe(){
	var modalLienHe= document.getElementById('modalLienHe');
	var closeModalLienHe= document.getElementsByClassName("closeModalLienHe")[0];
	modalLienHe.style.display = "block";
	closeModalLienHe.onclick = function() {
		modalLienHe.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalLienHe) {
			modalLienHe.style.display = "none";
		}
	}
}
function openModalNguoiLam(){
	var modalNguoiLam= document.getElementById('modalNguoiLam');
	var closeModalNguoiLam= document.getElementsByClassName("closeModalNguoiLam")[0];
	modalNguoiLam.style.display = "block";
	closeModalNguoiLam.onclick = function() {
		modalNguoiLam.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalNguoiLam) {
			modalNguoiLam.style.display = "none";
		}
	}
}
function openModalTrangThai(){
	var modalTrangThai= document.getElementById('modalTrangThai');
	var closeModalTrangThai= document.getElementsByClassName("closeModalTrangThai")[0];
	modalTrangThai.style.display = "block";
	closeModalTrangThai.onclick = function() {
		modalTrangThai.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalTrangThai) {
			modalTrangThai.style.display = "none";
		}
	}
}
function openModalGhiChu(){
	var modalGhiChu= document.getElementById('modalGhiChu');
	var closeModalGhiChu= document.getElementsByClassName("closeModalGhiChu")[0];
	modalGhiChu.style.display = "block";
	closeModalGhiChu.onclick = function() {
		modalGhiChu.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalGhiChu) {
			modalGhiChu.style.display = "none";
		}
	}
}
function openModalDetailWork(){
	var modalDetailWork= document.getElementById('modalDetailWork');
	var closeModalDetailWork= document.getElementsByClassName("closeModalDetailWork")[0];
	modalDetailWork.style.display = "block";
	closeModalDetailWork.onclick = function() {
		modalDetailWork.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalDetailWork) {
			modalDetailWork.style.display = "none";
		}
	}
}

function openModalAddEmloyee(){
	var modalAddEmployee= document.getElementById('modalAddEmployee');
	var closeModalAddEmployee= document.getElementsByClassName("closeModalAddEmployee")[0];
	modalAddEmployee.style.display = "block";
	closeModalAddEmployee.onclick = function() {
		modalAddEmployee.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalAddEmployee) {
			modalAddEmployee.style.display = "none";
		}
	}
}

function openModalAddEmployeeDepartment(){
	var modalAddEmployeeDepartment= document.getElementById('modalAddEmployeeDepartment');
	var closeModalAddEmployeeDepartment= document.getElementsByClassName("closeModalAddEmployeeDepartment")[0];
	modalAddEmployeeDepartment.style.display = "block";
	closeModalAddEmployeeDepartment.onclick = function() {
		modalAddEmployeeDepartment.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalAddEmployeeDepartment) {
			modalAddEmployeeDepartment.style.display = "none";
		}
	}
}
function openModalEditEmployeeDepartment(){
	var modalEditEmployeeDepartment= document.getElementById('modalEditEmployeeDepartment');
	var closeModalEditEmployeeDepartment= document.getElementsByClassName("closeModalEditEmployeeDepartment")[0];
	modalEditEmployeeDepartment.style.display = "block";
	closeModalEditEmployeeDepartment.onclick = function() {
		modalEditEmployeeDepartment.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalEditEmployeeDepartment) {
			modalEditEmployeeDepartment.style.display = "none";
		}
	}
}
function openModalAddManagementZone(){
	var modalAddManagementZone= document.getElementById('modalAddManagementZone');
	var closeModalAddManagementZone= document.getElementsByClassName("closeModalAddManagementZone")[0];
	modalAddManagementZone.style.display = "block";
	closeModalAddManagementZone.onclick = function() {
		modalAddManagementZone.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalAddManagementZone) {
			modalAddManagementZone.style.display = "none";
		}
	}
}
function openModalEditManagementZone(){
	var modalEditManagementZone= document.getElementById('modalEditManagementZone');
	var closeModalEditManagementZone= document.getElementsByClassName("closeModalEditManagementZone")[0];
	modalEditManagementZone.style.display = "block";
	closeModalEditManagementZone.onclick = function() {
		modalEditManagementZone.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalEditManagementZone) {
			modalEditManagementZone.style.display = "none";
		}
	}
}
function openModalAddPermissions(){
	var modalAddPermissions= document.getElementById('modalAddPermissions');
	var closeModalAddPermissions= document.getElementsByClassName("closeModalAddPermissions")[0];
	modalAddPermissions.style.display = "block";
	closeModalAddPermissions.onclick = function() {
		modalAddPermissions.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalAddPermissions) {
			modalAddPermissions.style.display = "none";
		}
	}
}
function openModalEditPermission(){
	var modalEditPermissions= document.getElementById('modalEditPermissions');
	var closeModalEditPermissions= document.getElementsByClassName("closeModalEditPermissions")[0];
	modalEditPermissions.style.display = "block";
	closeModalEditPermissions.onclick = function() {
		modalEditPermissions.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalEditPermissions) {
			modalEditPermissions.style.display = "none";
		}
	}
}
function openModalSetPermissions(){
	var modaSettPermissions= document.getElementById('modalSetPermissions');
	var closeModalSetPermissions= document.getElementsByClassName("closeModalSetPermissions")[0];
	modalSetPermissions.style.display = "block";
	closeModalSetPermissions.onclick = function() {
		modalSetPermissions.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalSetPermissions) {
			modalSetPermissions.style.display = "none";
		}
	}
	
}
function openModalGrantPermissions(){
	var modalGranttPermissions= document.getElementById('modalGrantPermissions');
	var closeModalGrantPermissions= document.getElementsByClassName("closeModalGrantPermissions")[0];
	modalGrantPermissions.style.display = "block";
	closeModalGrantPermissions.onclick = function() {
		modalGrantPermissions.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalGrantPermissions) {
			modalGrantPermissions.style.display = "none";
		}
	}
}
function openModalAddFolderWork(){
	var modalAddFolderWork= document.getElementById('modalAddFolderWork');
	var closeModalAddFolderWork= document.getElementsByClassName("closeModalAddFolderWork")[0];
	modalAddFolderWork.style.display = "block";
	closeModalAddFolderWork.onclick = function() {
		modalAddFolderWork.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalAddFolderWork) {
			modalAddFolderWork.style.display = "none";
		}
	}
}

function openModalAddFormMau(){
	var modalAddFormMau= document.getElementById('modalAddFormMau');
	var closeModalAddFormMau= document.getElementsByClassName("closeModalAddFormMau")[0];
	modalAddFormMau.style.display = "block";
	closeModalAddFormMau.onclick = function() {
		modalAddFormMau.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalAddFormMau) {
			modalAddFormMau.style.display = "none";
		}
	}
}
function openModalEditFormMau(){
	var modalEditFormMau= document.getElementById('modalEditFormMau');
	var closeModalEditFormMau= document.getElementsByClassName("closeModalEditFormMau")[0];
	modalEditFormMau.style.display = "block";
	closeModalEditFormMau.onclick = function() {
		modalEditFormMau.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalEditFormMau) {
			modalEditFormMau.style.display = "none";
		}
	}
}
//	========= end model-==========????
// <<<<<========== modal list project ==========
function openModalListProject() {
    var modalListProject = document.getElementById('modal-list-project');
    var spanModalListProject = document.getElementsByClassName("close-modal-list-project")[0];
    modalListProject.style.display = "block";
    spanModalListProject.onclick = function () {
        modalListProject.style.display = "none";
    }
    window.onclick = function (event) {
        if (event.target == modalListProject) {
            modalListProject.style.display = "none";
        }
    }
}

$(".btn-edit-folder").click(function(event) {
	$(".enable-edit").attr("disabled", true);
	$(".enable-edit").removeClass('enable-edit');
	$(".active").children('input').addClass('enable-edit');
	$(".enable-edit").removeAttr('disabled');
});

// ========== modal list project ==========>>>>>
// modal thuc muc
$(".btn-edit-folder1").click(function(event) {
	$(".enable-edit").attr("disabled", true);
	$(".enable-edit").removeClass('enable-edit');
	$(".active").children('input').addClass('enable-edit');
	$(".enable-edit").removeAttr('disabled');
});


// ==================== khu chứa các js cho modal index ====================>>>>>
// ============================== Trang index ==============================>>>>>

// trang phân chia công việc
$(window).load(function() {
	var windowWidth = $(window).width();
	if (window.window >= 992) {
		var leftWidth = $(".split-project-left").width();
		var listEmWidth = windowWidth - leftWidth - 80;
		var numberItem = Math.floor(listEmWidth/110);
		$(".list-selected-employee").css("grid-template-columns", "repeat(" + numberItem + ", 1fr)");
	} else {
		var rightWidth = $(".split-project-right").width();
		var numberItem = Math.floor(rightWidth/110);
		$(".list-selected-employee").css("grid-template-columns", "repeat(" + numberItem + ", 1fr)");
	}
});

$(window).resize(function() {
	var windowWidth = $(window).width();
	if (window.window >= 992) {
		var leftWidth = $(".split-project-left").width();
		var listEmWidth = windowWidth - leftWidth - 80;
		var numberItem = Math.floor(listEmWidth/150);
		console.log(numberItem);
		$(".list-selected-employee").css("grid-template-columns", "repeat(" + numberItem + ", 1fr)");
	} else {
		var rightWidth = $(".split-project-right").width();
		var numberItem = Math.floor(rightWidth/110);
		console.log(numberItem);
		$(".list-selected-employee").css("grid-template-columns", "repeat(" + numberItem + ", 1fr)");
	}
});

function openModalSelectEmployee() {
	var modalAddMember = document.getElementById('modal-add-member');
	var spanModalAddMember = document.getElementsByClassName("close-modal-add-member")[0];
	modalAddMember.style.display = "block";
	spanModalAddMember.onclick = function() {
		modalAddMember.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalFolder) {
			modalAddMember.style.display = "none";
		}
	}
}

$(".step-name").click(function() {
	$(".step-name").css("background", "transparent");
	$(this).css("background", "#FF0");
});

function openModalSelectForm() {
	var modalSelectForm = document.getElementById('modal-select-form');
	var spanModalSelectForm = document.getElementsByClassName("close-modal-select-form")[0];
	modalSelectForm.style.display = "block";
	spanModalSelectForm.onclick = function() {
		modalSelectForm.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modalSelectForm) {
			modalSelectForm.style.display = "none";
		}
	}
}

$(".btn-option").click(function() {
	$(".list-option").css("display", "none");
	if ($(this).find("i").hasClass("fa-chevron-right")) {
		var positionListAction = $(this).position();
		var topListAction = positionListAction.top;
		var leftListAction = positionListAction.left;
		$(".btn-option").find("i").removeClass("fa-chevron-left");
		$(".btn-option").find("i").addClass("fa-chevron-right");

		$(this).siblings(".list-option").css("display", "block");
		$(this).siblings(".list-option").css("top", topListAction + "px");
		$(this).siblings(".list-option").css("left", (leftListAction + 30) + "px");
		$(this).find("i").removeClass("fa-chevron-right");
		$(this).find("i").addClass("fa-chevron-left");
	} else {
		$(this).siblings(".list-option").css("display", "none");
		$(this).find("i").removeClass("fa-chevron-left");
		$(this).find("i").addClass("fa-chevron-right");
	}
});

$(".action-1").click(function() {
	$(".sub-move-job").css("display", "none");

	if ($(this).find(".sub-action").hasClass("fa-chevron-right")) {

		$(".action-1").find(".sub-action").removeClass("fa-chevron-left");
		$(".action-1").find(".sub-action").addClass("fa-chevron-right");
		var positionSubListAction = $(this).position();
		var topSubListAction = positionSubListAction.top;
		var leftSubListAction = positionSubListAction.left;
		$(this).find(".sub-action").addClass("fa-chevron-left");
		$(this).find(".sub-action").removeClass("fa-chevron-right");

		$(this).siblings(".sub-move-job").css("display", "flex");
		$(this).siblings(".sub-move-job").css("top", topSubListAction + "px");
		$(this).siblings(".sub-move-job").css("left", (leftSubListAction + 190) + "px");
	} else {
		$(this).find(".sub-action").addClass("fa-chevron-right");
		$(this).find(".sub-action").removeClass("fa-chevron-left");
		$(this).siblings(".sub-move-job").css("display", "none");
	}
});

$(".do-move-job").click(function() {
	confirm("Di chuyển bước này sẽ tạo ra một quy trình mới");
	$(".sub-move-job").css("display", "none");
	$(".list-option").css("display", "none");
});

// /////trang phân chia công việc
function blockInputLevel2(){
	$(".input-discussion-level-2").css("display","block");
}
$(".form-demo").click(function () {
    $(this).children("input").prop("checked", true);
});