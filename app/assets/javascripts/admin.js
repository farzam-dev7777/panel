$(document).ready(function(){

  $('.datetimepicker').datetimepicker();

	// Create a new todo task
	$("#todo-task-form").submit(function(e){
		e.preventDefault();
		$.ajax({
		  url: "/todo_tasks/",
		  method: "post",
		  data: $("#todo-task-form").serialize()
		})
		  .done(function( data ) {
		  	if(data){
		  		toast('A task has been created');
		  	}
		  });

	})

	//exception_request
	if($('select#exception_request_minority_owned').val() == "Yes"){
		$('.minority_owned_details').show()
	}
	$('select#exception_request_minority_owned').on('change', function() {
		if(this.value == "Yes"){
			$('.minority_owned_details').show()
		}else{
			$('.minority_owned_details').hide()
			$('#exception_request_minority_owned_details').val(" ")
		}
	});
	if($('select#exception_request_women_owned').val() == "Yes"){
		$('.women_owned_details').show()
	}
	$('select#exception_request_women_owned').on('change', function() {
		if(this.value == "Yes"){
			$('.women_owned_details').show()
		}else{
			$('.women_owned_details').hide()
			$('#exception_request_women_owned_details').val(" ")
		}
	});
	if($('select#exception_request_law_firm_category').val() == "PANEL"){
		$('#panel_notification').show()
		$('#new_exception_request .form-submit-btn ').attr('disabled','true')
	}
	$('select#exception_request_law_firm_category').on('change', function() {
		if(this.value == "PANEL"){
			$('#panel_notification').show()
			$('#new_exception_request .form-submit-btn ').attr('disabled','true')
		}else{
		  $('#panel_notification').hide()
		  $('#new_exception_request .form-submit-btn ').removeAttr('disabled')
		}
	});

})

function toast(text){
	$.toast({
    heading: 'Information',
    text: text,
    icon: 'info',
    loader: true,
    loaderBg: '#9EC600'
	})
} //#endregion

