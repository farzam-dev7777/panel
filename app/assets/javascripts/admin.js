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
	
		$('#new_exception_request .form-submit-btn, .edit_exception_request  .form-submit-btn').attr('disabled','true')
	}
	$('select#exception_request_law_firm_category').on('change', function() {
		
		if(this.value == "PANEL"){
			$('#panel_notification').show()
			$('#new_exception_request .form-submit-btn, .edit_exception_request  .form-submit-btn').attr('disabled','true')
		}else{
		  $('#panel_notification').hide()
		  $('#new_exception_request .form-submit-btn, .edit_exception_request  .form-submit-btn').removeAttr('disabled')
		}
	});
	if($('select#exception_request_law_firm_name').val()){
		if($('select#exception_request_law_firm_name').val() != "New" ||  $('select#exception_request_law_firm_name').val() == ""){
		 $('.firmDetails').show()
			 if($('select#exception_request_law_firm_name').val()){
				 //$('select#exception_request_law_firm_id').val(this.value).prop('selected', true);
				 $.ajax({
					 url: "/admin/law_firms/get_detail",
					 method: "post",
					 data: {id : $('select#exception_request_law_firm_name').val()}
				 })
					 .done(function( data ) {
						 if(data){
							 
							 $('.firmDetails .firmName').html(data.data.name)
							 $('.firmDetails .firmEmail').html(data.data.email)
							 $('.firmDetails .firmPhone').html(data.data.phone)
							 $('.firmDetails').show()
						 }
					 });
			 }
		}
	 }
	 $('select#exception_request_law_firm_name').on('change', function() {
		 if(this.value){
			 //$('select#exception_request_law_firm_id').val(this.value).prop('selected', true);
			 $.ajax({
				 url: "/admin/law_firms/get_detail",
				 method: "post",
				 data: {id : this.value}
			 })
				 .done(function( data ) {
					 if(data){
						 
						 $('.firmDetails .firmName').html(data.data.name)
						 $('.firmDetails .firmEmail').html(data.data.email)
						 $('.firmDetails .firmPhone').html(data.data.phone)
						 $('.firmDetails').show()
					 }
				 });
		 }
		 
	 });

	//panel_request
	if($('select#panel_request_minority_owned').val() == "Yes"){
		$('.minority_owned_details').show()
	}
	$('select#panel_request_minority_owned').on('change', function() {
		if(this.value == "Yes"){
			$('.minority_owned_details').show()
		}else{
			$('.minority_owned_details').hide()
			$('#panel_request_minority_owned_details').val(" ")
		}
	});
	if($('select#panel_request_women_owned').val() == "Yes"){
		$('.women_owned_details').show()
	}
	$('select#panel_request_women_owned').on('change', function() {
		if(this.value == "Yes"){
			$('.women_owned_details').show()
		}else{
			$('.women_owned_details').hide()
			$('#panel_request_women_owned_details').val(" ")
		}
	});


	if($('select#panel_request_law_firm_category').val() == "PANEL"){
		$('#panel_notification').show()
	
		$('#new_panel_request .form-submit-btn, .edit_panel_request  .form-submit-btn').attr('disabled','true')
	}
	$('select#panel_request_law_firm_category').on('change', function() {
		
		if(this.value == "PANEL"){
			$('#panel_notification').show()
			$('#new_panel_request .form-submit-btn, .edit_panel_request  .form-submit-btn').attr('disabled','true')
		}else{
		  $('#panel_notification').hide()
		  $('#new_panel_request .form-submit-btn, .edit_panel_request  .form-submit-btn').removeAttr('disabled')
		}
	});


	if($('select#panel_request_law_firm_name').val()){
	 if($('select#panel_request_law_firm_name').val() != "New" ||  $('select#panel_request_law_firm_name').val() == ""){
		$('.firmDetails').show()
			if($('select#panel_request_law_firm_name').val()){
				//$('select#panel_request_law_firm_id').val(this.value).prop('selected', true);
				$.ajax({
					url: "/admin/law_firms/get_detail",
					method: "post",
					data: {id : $('select#panel_request_law_firm_name').val()}
				})
					.done(function( data ) {
						if(data){
							
							$('.firmDetails .firmName').html(data.data.name)
							$('.firmDetails .firmEmail').html(data.data.email)
							$('.firmDetails .firmPhone').html(data.data.phone)
							$('.firmDetails').show()
						}
					});
			}
	 }
	}
	$('select#panel_request_law_firm_name').on('change', function() {
		if(this.value){
			//$('select#panel_request_law_firm_id').val(this.value).prop('selected', true);
			$.ajax({
				url: "/admin/law_firms/get_detail",
				method: "post",
				data: {id : this.value}
			})
				.done(function( data ) {
					if(data){
						
						$('.firmDetails .firmName').html(data.data.name)
						$('.firmDetails .firmEmail').html(data.data.email)
						$('.firmDetails .firmPhone').html(data.data.phone)
						$('.firmDetails').show()
					}
				});
		}
		
	});

	$('select#review_status').chosen().change(function() {
		if(this.value == "APPROVED"){
			$(".internal_lawyers_box").show()
			
		}else{
			$(".internal_lawyers_box").hide()
			$('select#review_assigned_to').val('').trigger('chosen:updated');
		}
	});


	
	// $('#addNewFirm').click(function(){
	// 	$.ajax({
	// 		url: "/admin/law_firms/get_detail",
	// 		method: "post",
	// 		data: {id : this.value}
	// 	})
	// 		.done(function( data ) {
	// 			if(data){
					
	// 				$('.firmDetails .firmName').html(data.data.name)
	// 				$('.firmDetails .firmEmail').html(data.data.email)
	// 				$('.firmDetails .firmPhone').html(data.data.phone)
	// 				$('.firmDetails').show()
	// 			}
	// 		});
	// })

	
	
})
$('.lxp_sttaus').on('click', function(e){
	
	 if($('select#review_status').chosen().val() == "APPROVED"){
		
		swal({
			title: "Are you sure you would like to approve this, this will notify and require further approval from the selected lawyer.",
			text: "",
			type: "warning",
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: "Ok",
			cancelButtonText: "Cancel",
			closeOnConfirm: true,
			closeOnCancel: true
		},
		function(isConfirm){
			if (isConfirm) {
			 $('#new_review').submit()
			}
		});
		return false
	 }
	 
	});
$('.lxp_excepation_sttaus').on('click', function(e){

	if($('select#review_status').chosen().val() == "APPROVED"){
		PAY_TYPE = $('select#review_pay_type').chosen().val()
		// if(PAY_TYPE == "BANK_PAY"){
		// 	message = ""
		// }else{

		// }

		swal({
			title: "Are you sure you would like to approve this.",
			text: "",
			type: "warning",
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: "Ok",
			cancelButtonText: "Cancel",
			closeOnConfirm: true,
			closeOnCancel: true
		},
		function(isConfirm){
			if (isConfirm) {
			$('#new_review').submit()
			}
		});
		return false
	}
	
	});
function toast(text){
	$.toast({
    heading: 'Information',
    text: text,
    icon: 'info',
    loader: true,
    loaderBg: '#9EC600'
	})
} //#endregion

