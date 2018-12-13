// js cho click các thư mục bên trái
$(".item-folder").click(function(){
	$(".item-folder").removeClass("active");
	$(".list-action").css("display", "none");
	if ($(this).find("i").hasClass("fa-folder-o")) {
		$(this).find("i.fa-folder-o").removeClass("fa-folder-o").addClass("fa-folder-open-o").hasClass("fa-folder-o");
		$(this).siblings(':first').css("display", "block");
		var folderId = $(this).data("id");
		if (folderId == 2) {
			$.ajax({
				url: 'http://localhost:8080/caythumuc/getsubfoder.html',
				type: 'POST',
				data: {}
			}).done(function(response){
				$(".list-folder-right").html(response);
			});
		} else {
			$.ajax({
				url: 'http://localhost:8080/caythumuc/emptyfile.html',
				type: 'POST',
				data: {}
			}).done(function(response){
				$(".list-folder-right").html(response);
			});
		}
	} else {
		$(this).find("i.fa-folder-open-o").removeClass("fa-folder-open-o").addClass("fa-folder-o").hasClass("fa-folder-open-o");
		$(this).siblings(':first').css("display", "none");
	}
	$(this).addClass("active");
});

$(".item-folder").contextmenu(function(){
	$(".item-folder").removeClass("active");
	$(this).addClass("active");
	$(".list-action").css("display", "none");
	var position = $(this).position();
	var top = position.top;
	var left = position.left;
	$(this).css("position", "relative");
	$(this).siblings(".list-action").css("display", "flex");
	$(this).siblings(".list-action").css("position", "absolute");
	$(this).siblings(".list-action").css("top", (top + 20) + "px");
	$(this).siblings(".list-action").css("left", (left + 80) + "px");
	$(this).siblings(".list-action").css("z-index", 22);
	$(this).siblings(".list-action").css("background", "#FFF");
	// alert("top : " + top + " left: " + left);
	return false;
});
// /////js cho click các thư mục bên trái

// js cho click các thư mục bên phải
$(document).ready(function(){
	$(".right-item-folder").contextmenu(function() {
		$(".right-list-action").css("display", "none");
		$(".right-item-folder").css("background", "#FFF");
		$(this).css("background", "#27ae60");
		$(this).siblings().css("display", "flex");
		
		var position = $(this).position();
		var top = position.top;
		var left = position.left;
		$(this).siblings().css("top", (top + 50) + "px");
		$(this).siblings().css("left", (top + 100) + "px");
		return false;
	});
	$(".right-item-folder").click(function() {
		$(".right-list-action").css("display", "none");
		$(".right-item-folder").css("background", "#FFF");
		$(this).css("background", "#27ae60");
	});
});
// /////js cho click các thư mục bên phải

// js xem danh sách dạng grid hoặc list
$(".view-list").click(function() {
	$(".view-grid").removeClass("view-selected");
	$(this).addClass("view-selected");
});

$(".view-grid").click(function() {
	$(".view-list").removeClass("view-selected");
	$(this).addClass("view-selected");
});
$(".right-item-folder").dblclick(function() {
	var id = $(this).data("id");
	// $("#left-folder-" + id).addClass("active");
	alert(id);
});
// /////js xem danh sách dạng grid hoặc list

