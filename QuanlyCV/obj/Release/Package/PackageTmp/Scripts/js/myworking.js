// js cho click các thư mục bên trái
$(".item-working").dblclick(function(){
	// $(".item-working").removeClass("active");
	$(".list-action").css("display", "none");
	if ($(this).find("i").hasClass("fa-folder-o")) {
		$(this).find("i.fa-folder-o").removeClass("fa-folder-o").addClass("fa-folder-open-o").hasClass("fa-folder-o");
		$(this).siblings(':first').css("display", "block");
		var workingId = $(this).data("id");
		// if (workingId == 2) {
		// 	$.ajax({
		// 		url: 'http://localhost:8080/caythumuc/getsubfoder.html',
		// 		type: 'POST',
		// 		data: {}
		// 	}).done(function(response){
		// 		$(".list-working-right").html(response);
		// 	});
		// } else {
		// 	$.ajax({
		// 		url: 'http://localhost:8080/caythumuc/emptyfile.html',
		// 		type: 'POST',
		// 		data: {}
		// 	}).done(function(response){
		// 		$(".list-working-right").html(response);
		// 	});
		// }
	} else {
		$(this).find("i.fa-folder-open-o").removeClass("fa-folder-open-o").addClass("fa-folder-o").hasClass("fa-folder-open-o");
		$(this).siblings(':first').css("display", "none");
	}
	// $(this).addClass("active");
});


$(".item-working").click(function() {
	// alert("aaaaa");
	$(".item-working").removeClass("active");
	$(this).addClass("active");
	$(".btn-add-folder").removeAttr("disabled");
	$(".btn-edit-folder").removeAttr("disabled");
	$(".btn-delete-folder").removeAttr("disabled");
});
// /////js cho click các thư mục bên trái

// js cho click các thư mục bên phải
$(document).ready(function(){
	$(".right-item-working").click(function() {
		// $(this).css("background", "#27ae60");
	});
});
// /////js cho click các thư mục bên phải


