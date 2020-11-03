$(document).ready(function(){

	// All forms stop submitting on enter - as per client requirement
	$('form').on('keyup keypress', function(e) {
		var keyCode = e.keyCode || e.which;
		if (keyCode === 13) { 
			e.preventDefault();
			return false;
		}
	})

$('#login-form').each(function() {
		$(this).find('input').keypress(function(e) {
				// Enter pressed?
				if(e.which == 10 || e.which == 13) {
						this.form.submit();
				}
		});

});

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

	if($('select#exception_request_niche_preferred_external_counsel_panel_law_firms').val() == "Yes"){
		$('.niche_preferred_external_details').show()
	}
	$('select#exception_request_niche_preferred_external_counsel_panel_law_firms').on('change', function() {
		if(this.value == "true"){
			$('.niche_preferred_external_details').show()
		}else{
			$('.niche_preferred_external_details').hide()
			$('#exception_request_niche_expertise').val(" ")
		}
	});

	if($('select#exception_request_required_unique_geography').val() == "Yes"){
		$('.required_unique_geography_details').show()
	}
	$('select#exception_request_required_unique_geography').on('change', function() {
		if(this.value == "true"){
			$('.required_unique_geography_details').show()
		}else{
			$('.required_unique_geography_details').hide()
			$('#exception_request_geographic_location').val(" ")
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
								$("#exception_request_law_firm_id").val(data.data.id);
								$('.firmDetails .firmName').html(data.data.name)
								$('.firmDetails .firmCat').html(data.data.law_firm_category)
								$('.firmDetails .firmPhone').html(data.data.phone)
								$('.firmDetails').show()
						 }
					 });
			 }
		}
	 }
	 
	 $('select#exception_request_law_firm_name').on('change', function() {
		 
		if(this.value){
			window.location.href = "select_law_firm/"+this.value;

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


	// if($('select#panel_request_law_firm_category').val() == "PANEL"){
	// 	$('#panel_notification').show()
	
	// 	$('#new_panel_request .form-submit-btn, .edit_panel_request  .form-submit-btn').attr('disabled','true')
	// }
	// $('select#panel_request_law_firm_category').on('change', function() {
		
	// 	if(this.value == "PANEL"){
	// 		$('#panel_notification').show()
	// 		$('#new_panel_request .form-submit-btn, .edit_panel_request  .form-submit-btn').attr('disabled','true')
	// 	}else{
	// 	  $('#panel_notification').hide()
	// 	  $('#new_panel_request .form-submit-btn, .edit_panel_request  .form-submit-btn').removeAttr('disabled')
	// 	}
	// });


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
						$('.firmDetails .firmName').html(data.data.name);
						$('.firmDetails .firmEmail').html(data.data.email);
						$('.firmDetails .firmPhone').html(data.data.phone);
						$('.firmDetails').show()
					}
				});
		}
		
	});
	// Exceptation Request approval Processs 
	$('.exceptationRequestProcesss select#review_status').chosen().change(function() {
		if(this.value == "REQUEST_TO_INPUT") {
			$(".exceptationRequestProcesss  .internal_lawyers_box").show()
			
		}else{
			$(".exceptationRequestProcesss .internal_lawyers_box").hide()
			$('.exceptationRequestProcesss select#review_assigned_to_id').val('').trigger('chosen:updated');
		}
	});
	// conflict Waiver approval Processs
	$('.conflictWaiverProcesss select#review_status').chosen().change(function() {
		if(this.value == "ASSIGN_TO_LAWYER"){
			$(".conflictWaiverProcesss  .internal_lawyers_box").show()
			
		}else{
			$(".conflictWaiverProcesss .internal_lawyers_box").hide()
			$('.conflictWaiverProcesss select#review_assigned_to_id').val('').trigger('chosen:updated');
		}

		if(this.value == "ALREADY_COVERED"){
			$(".conflictWaiverProcesss  .retainer_cover_box").show()
			
		}else{
			$(".conflictWaiverProcesss .retainer_cover_box").hide()
			$('.conflictWaiverProcesss select#review_retainer_cover').val('').trigger('chosen:updated');
		}
	});



	$('select#user_role').chosen().change(function() {
		if(this.value == "lob"){
			$('.lob_details').show()	
		}else{
			$('.lob_details').hide()
			$('#user_line_of_business').value("")
			$('#user_lob_contact_name').value("")
		}
	});

	
	$('#user_send_password_reset_link').change(function() {
		if($(this).is(":checked")) {
			 $(".hide_password_option").hide()
		}else{
			 $(".hide_password_option").show()
		}        
	});

	if($('select#user_role').val() == "lob"){
		$('.lob_details').show()	
	}
	
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
	 if($('select#review_status').chosen().val() == "REQUEST_TO_INPUT"){
			laywerId = $('select#review_assigned_to_id').chosen().val()
			if(!laywerId) {
				swal({
					title: "oops!",
					text: "Please select lawyer"
				});
				return false;
			}
			$('#new_review').submit()
		// swal({
		// 	title: "Are you sure you would like to approve this, this will notify and require further approval from the selected lawyer.",
		// 	text: "",
		// 	type: "warning",
		// 	showCancelButton: true,
		// 	confirmButtonColor: "#DD6B55",
		// 	confirmButtonText: "Ok",
		// 	cancelButtonText: "Cancel",
		// 	closeOnConfirm: true,
		// 	closeOnCancel: true
		// },
		// function(isConfirm){
		// 	if (isConfirm) {
			
		// 	}
		// });
		return false
	 }
	 
	if($('select#review_status').chosen().val() == "PANEL_RETAINER"){
		message = "Confirmation: Send Retainer Agreement to Law Firm"

		swal({
			title: message,
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
// $('.lxp_excepation_sttaus').on('click', function(e){

// 	if($('select#review_status').chosen().val() == "APPROVED"){
// 		PAY_TYPE = $('select#review_pay_type').chosen().val()
// 		if(PAY_TYPE == "BANK_PAY"){
// 			message = "Confirm To Emails Retainer and Forms to Law firm to fill/sign ?"
// 		}else{
// 			message = "Confirm To Emails Retainer to LOB to sign"
// 		}

// 		swal({
// 			title: message,
// 			text: "",
// 			type: "warning",
// 			showCancelButton: true,
// 			confirmButtonColor: "#DD6B55",
// 			confirmButtonText: "Ok",
// 			cancelButtonText: "Cancel",
// 			closeOnConfirm: true,
// 			closeOnCancel: true
// 		},
// 		function(isConfirm){
// 			if (isConfirm) {
// 			$('#new_review').submit()
// 			}
// 		});
// 		return false
// 	}
	
// 	});
	
function toast(text){
	$.toast({
    heading: 'Information',
    text: text,
    icon: 'info',
    loader: true,
    loaderBg: '#9EC600'
	})
} //#endregion


 


//engage_non_panel_firm Search

$('.engageForm select#law_firm_matter_types').on('change', function() {
	if(this.value){
		
		$.ajax({
			url: "/lob/exception_requests/get_sub_matter_types",
			method: "post",
			data: {id : this.value}
		})
			.done(function( data ) {
				if(data){
					$('.sub_matter_type_box').show()
					var options = "<option value=''> Select Sub Matter Type</option>";
					for (var i=0; i < data.data.length; i++){
						options += "<option value="+data.data[i].id+">"+data.data[i].sub_matter_type+"</option>";
					};
					$('#law_firm_sub_matter_types').html(options);
					$("#law_firm_sub_matter_types").trigger("chosen:updated");       // updates chosen
					return false;    
				}
			});
	}
	
});

$('.engageForm select#law_firm_countries').on('change', function() {
	if(this.value){
		
		$.ajax({
			url: "/lob/exception_requests/get_state",
			method: "post",
			data: {id : this.value}
		})
			.done(function( data ) {
				if(data){
					$('.state_type_box').show()
					var options = "<option value=''> Select State/Province</option>";
					for (var i=0; i < data.data.length; i++){
						options += "<option value="+data.data[i].id+">"+data.data[i].name+"</option>";
					};
					$('#law_firm_states').html(options);
					$("#law_firm_states").trigger("chosen:updated");       // updates chosen
					return false;    
				}
			});
	}
	
});


$('.engageForm select#law_firm_matter_type_ids').on('change', function() {
	if(this.value){
		
		$.ajax({
			url: "/lob/exception_requests/get_sub_matter_types",
			method: "post",
			data: {id : $('select#law_firm_matter_type_ids').val()}
		})
			.done(function( data ) {
				if(data){
					$('.sub_matter_type_box').show()
					var options = "<option value=''> Select Sub Matter Type</option>";
					for (var i=0; i < data.data.length; i++){
						options += "<option value="+data.data[i].id+">"+data.data[i].sub_matter_type+"</option>";
					};
					$('#law_firm_sub_matter_type_ids').html(options);
					$("#law_firm_sub_matter_type_ids").trigger("chosen:updated");       // updates chosen
					return false;    
				}
			});
	}
});


$('.engageForm select#law_firm_country_ids').on('change', function() {
	if(this.value){
		
		$.ajax({
			url: "/lob/exception_requests/get_state",
			method: "post",
			data: {id : $('select#law_firm_country_ids').val()}
		})
			.done(function( data ) {
				if(data){
					$('.state_type_box').show()
					var options = "<option value=''> Select State/Province</option>";
					for (var i=0; i < data.data.length; i++){
						options += "<option value="+data.data[i].id+">"+data.data[i].name+"</option>";
					};
					$('#law_firm_states_ids').html(options);
					$("#law_firm_states_ids").trigger("chosen:updated");       // updates chosen
					return false;    
				}
			});
	}
	
});


$('.searchLawFirm').on('click', function() {
	matter_type = $('select#law_firm_matter_types').chosen().val()
	sub_matter_type = $('select#law_firm_sub_matter_types').chosen().val()
	jurisdiction_type = $('select#law_firm_jurisdiction_types').chosen().val()
	country = $('select#law_firm_countries').chosen().val()
	state = $('select#law_firm_states').chosen().val()
	if(!matter_type) {
		swal({
			title: "oops!",
			text: "Please select matter type"
		});
		return false;
	}
	if(!country) {
		swal({
			title: "oops!",
			text: "Please select country"
		});
		return false;
	}
	if(!state) {
		swal({
			title: "oops!",
			text: "Please select state"
		});
		return false;
	}
	if(matter_type > 0  || sub_matter_type > 0 || jurisdiction_type > 0 || country > 0 || state > 0){
		$('input#exception_request_matter_types_search').val(matter_type)
		$('input#exception_request_sub_matter_types_search').val(sub_matter_type)
		$('input#exception_request_jurisdiction_types_search').val(jurisdiction_type)
		$('input#exception_request_countries_search').val(country)
		$('input#exception_request_states_search').val(state)
		$.ajax({
			url: "/lob/exception_requests/get_law_firm_list",
			method: "post",
			data: {
				matter_type : matter_type,
				sub_matter_type : sub_matter_type,
				jurisdiction_type : jurisdiction_type,
				country : country,
				state : state
			}
		})
			.done(function( data ) {
				var html = "<table>";
				if(data.data.length > 0 ){
						for (var i=0; i < data.data.length; i++){
							html += 
							`<tr id=lawFirm_${data.data[i].id}>
									<td><input name="exception_request[law_firm_id]" type="radio" value="${data.data[i].id}" /></td>
									<td>${data.data[i].name}</td>
									<td>${data.data[i].email}</td>
									<td>${data.data[i].phone}(${data.data[i].phone})</td>
								</tr>`;	
							//options += "<option value="+data.data[i].id+">"+data.data[i].sub_matter_type+"</option>";
						};
						html += "</table>";		
						$('.law_firm_list table#dt_basic').find('tbody').html(html)
						$('.law_firm_list').show()
						$('.hide_next_btn_non_panel').hide()
				}else{
					//html += "<tr><td>No Law Firm Match Your criteria<td></tr>";		
					//html += "</table>";		
					//$('.law_firm_list table#dt_basic').find('tbody').html(html)
					//$('.law_firm_list').show()
					$('input[name="exception_request[law_firm_id]"]').attr('checked',false);
					$("#exception_request_is_work_no").prop('checked', true);
					$('#new_exception_request').submit()
				}
				
			});
	}else{
		swal({
			title: "Oops!",
			text: "Please select atleast one option"
		});
	}
	return false
});

$('input[name="exception_request[is_work]"]').on('click', function() {
	is_work_value = $(this).val()
	if(is_work_value === "No"){
		$('.engage_non_panel_firm_notes').show()
		$('.engage_non_panel_firm_btn').val('Next')
		$('.engage_non_panel_firm_btn').attr('data-disable-with', 'Next')
		
		$('.engage_non_panel_firm_btn').removeClass('hide')
	}else{
		$('.engage_non_panel_firm_notes').hide()
		$('.engage_non_panel_firm_btn').val('Confirm')
		$('.engage_non_panel_firm_btn').attr('data-disable-with', 'Submit Requests')
		$('.engage_non_panel_firm_btn').removeClass('hide')
	}


});

$('.engage_non_panel_firm_btn').on('click', function() {
	law_firm_id = $('input[name="exception_request[law_firm_id]"]:checked').val()
	is_work = $('input[name="exception_request[is_work]"]:checked').val()
	
	if(is_work === "Yes"){
		if(law_firm_id){
			return true
		}else{
			swal({
				title: "oops!",
				text: "Please select any one law firm"
			});
			return false
		}
	}else if(is_work === "No"){
		$('input[name="exception_request[law_firm_id]"]').attr('checked',false);
		return true
	}else{
		swal({
			title: "Could One of these Law Firms do the work?",
			text: "Please select atleast one option"
		});
		return false
	}
	
});



//$(".simple_form.edit_exception_request").validator();
// $(function() {
// 	var $tabs = $('#tabs-exception').tabs();
// 	$(".ui-tabs-panel").each(function(i){
// 	  var totalSize = $(".ui-tabs-panel").size() - 1;
// 	  if (i != totalSize) {
// 	      next = i + 2;
//    		  $(this).append("<a href='#' class='next-tab mover' rel='" + next + "'>Next Page &#187;</a>");
// 	  }
// 	  if (i != 0) {
// 	      prev = i;
//    		  $(this).append("<a href='#' class='prev-tab mover' rel='" + prev + "'>&#171; Prev Page</a>");
// 	  }
// 	});
// 	$('.next-tab, .prev-tab').click(function() { 
// 				$tabs.tabs('select', $(this).attr("rel"));
// 				return false;
// 		});
// });

$('select#matter_intake_bmo_lawyer_name').on('change', function() {
	var id = $('option:selected', this).attr('data-id')
	$('#matter_intake_lawyer_id').val(id);
});

// hide on load
if($('select#matter_intake_work_area').val() === "Regulatory") {
	$('.work_area_reportable').show()
} else {
	$('.work_area_reportable').hide()
}

// Litigation reportable always show
$('.work_area_reportable_litigation').show()

$('select#matter_intake_work_area').on('change', function() {
	// var form_type = $('#matter_intake_form_type').val();
	// if(form_type === "general" || form_type === "litigation") {
		var work_area = this.value;
		if(work_area === "Regulatory") {
			$('.work_area_reportable').show()
		} else {
			$('.work_area_reportable').hide()
		}
		// Litigation reportable always show
		$('.work_area_reportable_litigation').show()
	// }
})

$(document).ready(function() {
	var matter_intake_firm_type = $('select#matter_intake_firm_type > option:selected').val();
	var matter_intake_type_of_price = $('select#matter_intake_type_of_price > option:selected').val();

	// Handle on load case
	if(matter_intake_firm_type === "Panel") {
		$('.panel_firm').show()
		$('.non_panel_firm').hide()
	} else if(matter_intake_firm_type === "Non-Panel") {
		$('.panel_firm').hide()
		$('.non_panel_firm').show()
	} else if (matter_intake_firm_type === "Panel & Non-Panel Firms") {
		$('.panel_firm').show()
		$('.non_panel_firm').show()
	} else {
		$('.panel_firm').hide()
		$('.non_panel_firm').hide()
	}
	
	$('select#matter_intake_firm_type').on('change', function() {
		var selectedValue = this.value;
		if(selectedValue === "Panel") {
			$('.panel_firm').show()
			$('.non_panel_firm').hide()
		} else if(selectedValue === "Non-Panel") {
			$('.panel_firm').hide()
			$('.non_panel_firm').show()
		} else if (selectedValue === "Panel & Non-Panel Firms") {
			$('.panel_firm').show()
			$('.non_panel_firm').show()
		} else {
			$('.panel_firm').hide()
			$('.non_panel_firm').hide()
		}
	});

	// Handle on Load
	var type_of_price = ["Hourly Billing", "Work done at no cost"];

	if(matter_intake_type_of_price != "" && !type_of_price.includes(matter_intake_type_of_price)) {
		$('.alternative_fee').show();
		$('#matter_intake_is_alternative_fee_arrangement').val("Yes")
		$("#matter_intake_is_alternative_fee_arrangement").trigger("chosen:updated")
	} else {
		$('.alternative_fee').hide();
		$('#matter_intake_is_alternative_fee_arrangement').val("No")
		$('#matter_intake_afa_details').val('')
		$("#matter_intake_is_alternative_fee_arrangement").trigger("chosen:updated")
	}

	$('select#matter_intake_type_of_price').on('change', function() {
		var selectedValue = this.value;
		if(!type_of_price.includes(selectedValue)) {
			$('.alternative_fee').show();
			$('#matter_intake_is_alternative_fee_arrangement').val("Yes")
			$("#matter_intake_is_alternative_fee_arrangement").trigger("chosen:updated")
		} else {
			$('.alternative_fee').hide();
			$('#matter_intake_afa_details').val('')
			$('#matter_intake_is_alternative_fee_arrangement').val("No")
			$("#matter_intake_is_alternative_fee_arrangement").trigger("chosen:updated")
		}
	});
})

// Handle matter_intake_afa_details on matter_intake_is_alternative_fee_arrangement Change / load
if($('#matter_intake_is_alternative_fee_arrangement').val()){
	if($('#matter_intake_is_alternative_fee_arrangement').val() === "Yes") {
		$('.matter_intake_afa_details').parent().show();
	} else {
		$('.matter_intake_afa_details').parent().hide();
		$('#matter_intake_afa_details').val('')
	}
}
$('select#matter_intake_is_alternative_fee_arrangement').on('change', function() {
	if(this.value === "Yes") {
		$('.matter_intake_afa_details').parent().show();
	} else {
		$('.matter_intake_afa_details').parent().hide();
		$('#matter_intake_afa_details').val('')
	}
});
 
$(".next-btn-exception").click(function () {
	if($(this).attr('data-current-tab') === "Confirm-the-reason") {
		var reasonArray = []
		$(".exception_request_reason input.check_boxes:checked").each(function(){
			reasonArray.push($(this).val());
		});
		var reason_details = $('#exception_request_reason_details').val();
		if(reasonArray.length < 1) {
			swal("Oops!", "Please confirm why a Non-Panel law firm is required for this matter?", "error");
			return false;
		}
		if(reason_details === "") {
			swal("Oops!", "Please provide details of reason(s) selected.", "error");
			return false;
		}
		$("#tabs-exception").tabs("enable", 1);
		$("#tabs-exception").tabs("enable", 2);
	//	$("#tabs-exception").tabs("enable", 3);
		$( "#tabs-exception" ).tabs( "option", "active", $("#tabs-exception").tabs('option', 'active')+1 );
	} else {
		$("#tabs-exception").tabs("enable", 1);
		$("#tabs-exception").tabs("enable", 2);
	//	$("#tabs-exception").tabs("enable", 3);
		$( "#tabs-exception" ).tabs( "option", "active", $("#tabs-exception").tabs('option', 'active')+1 );
	}
});
$(".prev-btn-exception").click(function () {
	$( "#tabs-exception" ).tabs( "option", "active", $("#tabs-exception").tabs('option', 'active')-1 );
});

$("#tabs-exception").tabs({
	active: 0,
	disabled: [1, 2, 3]
});
// check validation on tabs click
// $( ".tabs2, .tabs3" ).on( "click", function( event, ui ) {
// 	$( "#tabs-exception" ).tabs( "option", "active", "tabs-reason" );
// })
// adminLawFirm
$(".adminLawFirm .new_law_firm").validate();


$('.adminLawFirm select#law_firm_matter_type_ids').on('change', function() {
	if(this.value){
		
		$.ajax({
			url: "/admin/law_firms/get_sub_matter_types",
			method: "post",
			data: {id : $('select#law_firm_matter_type_ids').val()}
		})
			.done(function( data ) {
				if(data){
					$('.sub_matter_type_box').show()
					var options = "<option value=''> Select Sub Matter Type</option>";
					for (var i=0; i < data.data.length; i++){
						options += "<option value="+data.data[i].id+">"+data.data[i].sub_matter_type+"</option>";
					};
					$('#law_firm_sub_matter_type_ids').html(options);
					$("#law_firm_sub_matter_type_ids").trigger("chosen:updated");       // updates chosen
					return false;    
				}
			});
	}
	
});

$('.adminLawFirm select#law_firm_country_ids').on('change', function() {
	if(this.value){
		
		$.ajax({
			url: "/admin/law_firms/get_state",
			method: "post",
			data: {id : $('select#law_firm_country_ids').val()}
		})
			.done(function( data ) {
				if(data){
					$('.state_type_box').show()
					var options = "<option value=''> Select State/Province</option>";
					for (var i=0; i < data.data.length; i++){
						options += "<option value="+data.data[i].id+">"+data.data[i].name+"</option>";
					};
					$('#law_firm_state_ids').html(options);
					$("#law_firm_state_ids").trigger("chosen:updated");       // updates chosen
					return false;    
				}
			});
	}
	
});


if($('.adminLawFirm select#law_firm_matter_type_ids').val()){
	$('.sub_matter_type_box').show()
	// $.ajax({
	// 	url: "/admin/law_firms/get_sub_matter_types",
	// 	method: "post",
	// 	data: {id : $('select#law_firm_matter_type_ids').val()}
	// })
	// 	.done(function( data ) {
	// 		if(data){
	// 			// $('.sub_matter_type_box').show()
	// 			// // var options = "<option value=''> Select Sub Matter Type</option>";
	// 			// // for (var i=0; i < data.data.length; i++){
	// 			// // 	options += "<option value="+data.data[i].id+">"+data.data[i].sub_matter_type+"</option>";
	// 			// // };
	// 			// // $('#law_firm_sub_matter_type_ids').html(options);
	// 			// // $("#law_firm_sub_matter_type_ids").trigger("chosen:updated");       // updates chosen
	// 			// // return false;    
	// 		}
	// 	});
}
if($('.adminLawFirm select#law_firm_country_ids').val()){
	$('.state_type_box').show()
	// $.ajax({
	// 	url: "/admin/law_firms/get_state",
	// 	method: "post",
	// 	data: {id : $('select#law_firm_country_ids').val()}
	// })
	// 	.done(function( data ) {
	// 		if(data){
	// 			$('.state_type_box').show()
	// 			var options = "<option value=''> Select State/Province</option>";
	// 			for (var i=0; i < data.data.length; i++){
	// 				options += "<option value="+data.data[i].id+">"+data.data[i].name+"</option>";
	// 			};
	// 			$('#law_firm_states_ids').html(options);
	// 			$("#law_firm_states_ids").trigger("chosen:updated");       // updates chosen
	// 			return false;    
	// 		}
	// 	});
}


//panelRequestNew start
 
$('.panelRequestNew select#panel_request_law_firm_attributes_matter_type_ids').on('change', function() {
	if(this.value){
		
		$.ajax({
			url: "/lob/exception_requests/get_sub_matter_types",
			method: "post",
			data: {id : $('.panelRequestNew select#panel_request_law_firm_attributes_matter_type_ids').val()}
		})
			.done(function( data ) {
				if(data){
					$('.panelRequestNew .sub_matter_type_box').show()
					var options = "<option value=''> Select Sub Matter Type</option>";
					for (var i=0; i < data.data.length; i++){
						options += "<option value="+data.data[i].id+">"+data.data[i].sub_matter_type+"</option>";
					};
					$('.panelRequestNew #panel_request_law_firm_attributes_sub_matter_type_ids').html(options);
					$(".panelRequestNew #panel_request_law_firm_attributes_sub_matter_type_ids").trigger("chosen:updated");       // updates chosen
					return false;    
				}
			});
	}
});



if($('.panelRequestNew select#panel_request_law_firm_attributes_matter_type_ids').val()){
	$('.sub_matter_type_box').show()
		// $.ajax({
		// 	url: "/lob/exception_requests/get_sub_matter_types",
		// 	method: "post",
		// 	data: {id : $('.panelRequestNew select#panel_request_law_firm_attributes_matter_type_ids').val()}
		// })
		// 	.done(function( data ) {
		// 		if(data){
		// 			$('.sub_matter_type_box').show()
		// 			var options = "<option value=''> Select Sub Matter Type</option>";
		// 			for (var i=0; i < data.data.length; i++){
		// 				options += "<option value="+data.data[i].id+">"+data.data[i].sub_matter_type+"</option>";
		// 			};
		// 			$('.panelRequestNew #panel_request_law_firm_attributes_sub_matter_type_ids').html(options);
		// 			$(".panelRequestNew #panel_request_law_firm_attributes_sub_matter_type_ids").trigger("chosen:updated");       // updates chosen
		// 			return false;    
		// 		}
		// 	});
}

$('.panelRequestNew select#panel_request_law_firm_attributes_country_ids').on('change', function() {
	if(this.value){
		
		$.ajax({
			url: "/lob/exception_requests/get_state",
			method: "post",
			data: {id : $('.panelRequestNew select#panel_request_law_firm_attributes_country_ids').val()}
		})
			.done(function( data ) {
				if(data){
					$('.state_type_box').show()
					var options = "<option value=''> Select State/Province</option>";
					for (var i=0; i < data.data.length; i++){
						options += "<option value="+data.data[i].id+">"+data.data[i].name+"</option>";
					};
					$('.panelRequestNew #panel_request_law_firm_attributes_state_ids').html(options);
					$(".panelRequestNew #panel_request_law_firm_attributes_state_ids").trigger("chosen:updated");       // updates chosen
					return false;    
				}
			});
	}
	
});

if($('.panelRequestNew select#panel_request_law_firm_attributes_country_ids').val()){
	$('.state_type_box').show()
	// $.ajax({
	// 	url: "/lob/exception_requests/get_state",
	// 	method: "post",
	// 	data: {id : $('select#law_firm_country_ids').val()}
	// })
	// 	.done(function( data ) {
	// 		if(data){
	// 			$('.state_type_box').show()
	// 			var options = "<option value=''> Select State/Province</option>";
	// 			for (var i=0; i < data.data.length; i++){
	// 				options += "<option value="+data.data[i].id+">"+data.data[i].name+"</option>";
	// 			};
	// 			$('#law_firm_states_ids').html(options);
	// 			$("#law_firm_states_ids").trigger("chosen:updated");       // updates chosen
	// 			return false;    
	// 		}
	// 	});
}

//panelRequestNew end

$('.lxp_rejects').on('click', function() {
	var matter_intake_id = $('#matter_intake_id').val();
	if(matter_intake_id) {
		$.ajax({
			url: "/admin/matter_intakes/lxp_rejects",
			method: "POST",
			data: {id : matter_intake_id}
		})
			.done(function( data ) {
				window.location.href = "/admin/matter_intakes"
				setTimeout(() => {
					swal({
						title: "Success",
						icon: "success",
						text: "Matter intake form succesfully returns to lawyer for updation."
					});
				}, 300)
			})
			.error(function (error) {
				swal({
					title: "Ops!",
					icon: "error",
					text: "Something went wrong. Matter intake form failed to reject."
				});
			})
	}
 
});

if($('#matter_type_type_of_matter_lob_initiated').val()) {
	var work_area_based_on_matter_type = $('#matter_type_type_of_matter_lob_initiated').val();
	$('.lawyer_work_area_matter_type_based').val(work_area_based_on_matter_type);
	$('.lawyer_work_area_matter_type_based').trigger("chosen:updated");
}

// Matter intake for form-b (lob initiate lawyer)
if($('.lawyer_work_area_matter_type_based').val()) {
	setMatterIntakeWorkAreaOptions($('.lawyer_work_area_matter_type_based').val())
}

$('.lawyer_work_area_matter_type_based').on('change', function() {
	setMatterIntakeWorkAreaOptions(this.value)
})

if($('select#matter_intake_work_area').val()) {
	setMatterIntakeWorkAreaOptions($('select#matter_intake_work_area').val())
}

$('select#matter_intake_work_area').on('change', function() {
	setMatterIntakeWorkAreaOptions(this.value)
})

function setMatterIntakeWorkAreaOptions(value) {
	$('select#matter_intake_work_area_type').empty();
	var options = "<option value=''> Select option(s)</option>";
	var work_area_level2_value = $("#matter_intake_work_area_type").attr("data-value");
	switch(value) {
		case "Contractual Transactions (non-lending)":
		case "Contractual Transactions (non-lending) / Traduction contractuelle (autre que des prêt":
			valueArray = ["Card Services","Cash Management","Client and/or Account Documentation","Closed End Funds","Commercial Paper","DCN","Derivatives","Exchange Traded Funds","Inter-company (BMOFG) Agreements","Interest Rate Notes","IT Procurement (Non-Outsourcing)","Mutual Funds","Non-IT Procurement","NPPNs","Offerings","Outsourcing","PPNs","Professional Services (Consulting)","REPO/SLA","Trade/Finance"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Corporate Governance":
		case "Corporate Governance / Gouvernance d'entreprise":
			valueArray = ["BMO Board","Continuous Disclosure","Environment, Social/Governance","Funding Transactions","Reputation Risk Review","Subsidiary Matters"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Employment (non-action)":
		case "Employment (non-action) / Recrutement (aucune intervention)":
			valueArray = ["Compensation Program","Employment Contract","Pensions"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "General Customer Inquiries":
		case "General Customer Inquiries / Questions générales de clients":	
			valueArray = [];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Intellectual Property":
		case "Intellectual Property":
			valueArray = ["Copyrights","Patents","Trade Secrets","Trademarks"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Legal Administration":
		case "Legal Administration":
			valueArray = ["Internal Projects/Budgets/Audit"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;	
		case "Lending & Financing (inc. Secured Transactions and Workouts)":
		case "Lending and Financing (inc. secured transactions and workouts) / Financement de prê transactions garanties et les redressements)":	
			valueArray = ["Commercial","Loan Syndications/Participations","Real Estate/Mortgages","Structured Finance","Trade Finance","Underwriting","Recovery"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "M&A":
		case "Mergers & Acquisitions / Fusions et acquisitions":
			valueArray = ["Extraordinary (Bank is Party)","Ordinary (Bank is Advisor)"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Marketing":
		case "Marketing":
			valueArray = [];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "New Products":
		case "New Products / Nouveaux produits":
			valueArray = ["IDP/NPAP","Product Support"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Real Estate":
		case "Real Estate (non-lending) / Immobilier (autres que des prêts)":
			valueArray = ["Facilities","Leasing","Sales/Purchase"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Regulatory":
		case "Regulatory / Réglementation":
			valueArray = ["Advisory","Audit","Competition/Anti-trust","Enforcement Action","Filings","Inquiry","Investigations","OBSI Investigation","Privacy/FOI/Ombudsman"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Tax":
		case "Tax / Fiscalité":
			valueArray = [];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Wills/Estates":
		case "Wills & Estates / Testaments/successions":	
			valueArray = ["Estates", "Power of Attorneys"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Litigation":
			valueArray = ["Class Action/Customer","Class Action/Employment (Inc. Contractors)","Class Action/Non-Customer","Class Action/Securities","Customer/Action","Customer/Complaint (Non-action)","Employment/Action","Employment/Complaint (Non-action)","Internal Review/Investigations/Investigations","Internal Review/Investigations/Review","Non-Customer/Action","Non-Customer/Complaint (Non-action)","Recovery/Other than SAMU","Recovery/SAMU","Regulatory Proceedings/Tribunal","Small Claims","Third-Party Order/Subpoenas/Garnishments","Watching Brief"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;	
		default:
	}
	$('#matter_intake_work_area_type').html(options);
	// for Lob initiated lawyer
	$('.lawyer_work_area_2').html(options);
	$('.lawyer_work_area_2').trigger("chosen:updated");
	if(work_area_level2_value) {
		$("#matter_intake_work_area_type").val(work_area_level2_value);
	}
	$("#matter_intake_work_area_type").trigger("chosen:updated")
}

$('select#matter_intake_is_conceal_imanage_workspace').on('change', function() {
	setMatterIntakeIManager(this.value)
})

setMatterIntakeIManager($('#matter_intake_is_conceal_imanage_workspace').val())

function setMatterIntakeIManager(value) {
	if(value === "Yes") {
		$('.who_requires_imanager_workspace').show()
	} else {
		$('.who_requires_imanager_workspace').hide()
		$('#matter_intake_who_requires_access_to_imanage_workspace').val('')
	}
}

$('select#matter_intake_business_paying_for_matter').on('change', function() {
	setMatterIntakeBusinessGroupOptions(this.value)
})

if($('select#matter_intake_business_paying_for_matter').val()) {
	setMatterIntakeBusinessGroupOptions($('select#matter_intake_business_paying_for_matter').val())
}

function setMatterIntakeBusinessGroupOptions(value) {
	$('select#matter_intake_group_paying_for_matter').empty();
	var group_value = $("#matter_intake_group_paying_for_matter").attr("data-value");
	var options = "<option value=''> Select option(s)</option>";
	switch(value) {
		case "Canadian P&C":
			valueArray = ["Business Banking","Commercial Banking - ABL","Commercial Banking - Auto Finance","Commercial Banking - BMO Capital Partners & M&A","Commercial Banking - Corporate Finance","Commercial Banking - Diversified Industries","Commercial Banking - Equipment Leasing","Commercial Banking - Media","Commercial Banking - Other (Regions)","Commercial Banking - Overhead & Support","Commercial Banking - Real Estate Lending","Commercial Banking - Retail Dealer Finance","Commercial Banking - Sponsor Coverage","Commercial Banking - Tranportation Finance","Commercial Banking - Treasury & Payment Solutions","Electronic Banking Services","Other - Customer Contact Centres","Other - Distribution Services","Other - Headquarters","Other - Investment Plan","Personal Banking - Everyday Banking","Personal Banking - Home Financing & Retail Lending","Personal Banking - NA Retail Payments","Personal Banking - Office of the COO","Personal Banking - Sales & Distribution","Personal Banking - SVP Program","Personal Banking - Term Deposits"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Capital Markets":
			valueArray = ["Global I&CB - Excluding GTM","Global I&CB - HQ","Global I&CB - Merchant Banking","Global I&CB - Treasury & Payment Solutions","Global Markets - Cross Asset Solutions","Global Markets - Global Equity Products (Equities)","Global Markets - Global Fixed Income, Currencies & Commodities (FICC)","Global Markets - HQ and Other (Trading Products HQ, Cross Bus Risk)","Office of the COO"];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Corporate":
			valueArray = ["Audit","EI3 - CAO Office","EI3 - Insight Strategies","EI3 - Procurement","EI3 - Projects","EI3 - Real Estate","ERPM & AML","Finance","LRC","LRC Non-Legal","LRC TPP","Marketing & Strategy","Other (BMO Pools, Capital Account, Jupiter, Corp. Initiatives, U.S. Corp Office)","People & Culture - Corporate Communications","People & Culture - HR/ER","People & Culture - Office of the CEO","Senior Corporate Executive Operating","Technology & Operations"]
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "U.S. P&C":
			valueArray = ["Commercial Banking - Agriculture","Commercial Banking - Commercial Real Estate","Commercial Banking - Community Development","Commercial Banking - Corporate Finance","Commercial Banking - Dealer Finance","Commercial Banking - Diversified Industries Group (DIG)","Commercial Banking - EFC","Commercial Banking - Financial Institutions","Commercial Banking - Food & Consumer","Commercial Banking - Other (TPS, Corp Card, Global Treasury Mgmt, OREO, Other Wrap)","Commercial Banking - Transportation Finance","Other - Headquarters","Personal Banking - Brokered CD's","Personal Banking - Cards","Personal Banking - Deposit Products & Segment","Personal Banking - Indirect Auto","Personal Banking - Office of the COO","Personal Banking - Other - BB Strategy","Personal Banking - Other - HQ Administration","Personal Banking - Other - Retail","Personal Banking - Premier","Personal Banking - Regions (Excl. Small Business)","Personal Banking - Retail Lending","Personal Banking - Small Business"]
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		case "Wealth Management":
			valueArray = ["Global Asset Management - BAM HQ","Global Asset Management Asia","Global Asset Management Canada","Global Asset Management EMEA","Global Asset Management U.S.","HQ","Insurance","Personal Wealth - InvestorLine","Personal Wealth Canada","Personal Wealth U.S."];
			for (var i = 0; i < valueArray.length; i++) {
				options += `<option value='${valueArray[i]}'>${valueArray[i]}</option>`;
			}
			break;
		default:
	}
	$('#matter_intake_group_paying_for_matter').html(options);
	if (group_value) {
		$("#matter_intake_group_paying_for_matter").val(group_value);
	}
	$("#matter_intake_group_paying_for_matter").trigger("chosen:updated");
}

if($('select#matter_intake_process_type_level_1').val()) {
	setMatterIntakeProcessLevelType1($('select#matter_intake_process_type_level_1').val())
}

$('select#matter_intake_process_type_level_1').on('change', function() {
	setMatterIntakeProcessLevelType1(this.value)
})

function setMatterIntakeProcessLevelType1(value) {
	$('select#matter_intake_process_type_level_2').empty();
	var options = "<option value=''> Select option(s)</option>";
	var process_type_2_value = $("#matter_intake_process_type_level_2").attr("data-value");
	switch(value) {
		case "Capture and Document Transactions":
			options += "<option value='Capture Transactions'>Capture Transactions</option>";
			options += "<option value='Confirm and Document Transactions'>Confirm and Document Transactions</option>";
			break;
		case "Deliver Products and Services":
			options += "<option value='Advisory Services'>Advisory Services</option>";
			options += "<option value='Calculate and Apply Interest'>Calculate and Apply Interest</option>";
			options += "<option value='Cash, Stock and Securities Mgt'>Cash, Stock and Securities Mgt</option>";
			options += "<option value='Collateral Management'>Collateral Management</option>";
			options += "<option value='Customer Statements'>Customer Statements</option>";
			options += "<option value='Event Management/Corporate Actions (client assets)'>Event Management/Corporate Actions (client assets)</option>";
			options += "<option value='Event Management/Corporate Actions (own assets)'>Event Management/Corporate Actions (own assets)</option>";
			options += "<option value='Execution/Order Fill'>Execution/Order Fill</option>";
			options += "<option value='Fees Admin, Calculation and Application'>Fees Admin, Calculation and Application</option>";
			options += "<option value='Order Routing'>Order Routing</option>";
			options += "<option value='Portfolio Mgt (client assets)'>Portfolio Mgt (client assets)</option>";
			options += "<option value='Position/Portfolio Mgt (proprietary)'>Position/Portfolio Mgt (proprietary)</option>";
			options += "<option value='Product Control'>Product Control</option>";
			options += "<option value='Safekeeping of Client Assets'>Safekeeping of Client Assets</option>";
			break;
		case "Develop, Design and Maintain Products, Services and General Business Capabilities":
			options += "<option value='Market Analysis/Research'>Market Analysis/Research</option>";
			options += "<option value='Product Development'>Product Development</option>";
			options += "<option value='Reference Data Management'>Reference Data Management</option>";
			break;
		case "Market Products and Services":
			options += "<option value='Marketing - Other'>Marketing - Other</option>";
			options += "<option value='Publishing Price Quotes'>Publishing Price Quotes</option>";
			options += "<option value='Research (Marketing)'>Research (Marketing)</option>";
			break;
		case "Sell/Reach Agreement to Conduct Specific Business":
			options += "<option value='Advisory/Pitch/Pre-Sales'>Advisory/Pitch/Pre-Sales</option>";
			options += "<option value='Pricing and Quotation'>Pricing and Quotation</option>";
			options += "<option value='Reach Agreement/Order Receipt'>Reach Agreement/Order Receipt</option>";
			options += "<option value='Transaction/Limit Check'>Transaction/Limit Check</option>";
			break;
		case "Take on and Maintain Clients/Customers, Counterparties and Trade Relationships":
			options += "<option value='(New) Client Account'>(New) Client Account</option>";
			options += "<option value='Client Due Diligence'>Client Due Diligence</option>";
			options += "<option value='CRM/Client Services'>CRM/Client Services</option>";
			options += "<option value='Loan Defaults'>Loan Defaults</option>";
			break;
		case "Perform Settlements and Closing Activities":
			options += "<option value='Cash Payment/Physical Delivery'>Cash Payment/Physical Delivery</option>";
			options += "<option value='Fails Management'>Fails Management</option>";
			options += "<option value='Payment/Delivery (non-cash/non-physical)'>Payment/Delivery (non-cash/non-physical)</option>";
			break;
		case "Perform Transaction Accounting":
			options += "<option value='Transaction Accounting'>Transaction Accounting</option>";
			break;
		case "Manage Human Resources":
			options += "<option value='HR Management'>HR Management</option>";
			options += "<option value='Other HR Issues'>Other HR Issues</option>";
			options += "<option value='Remuneration, Expenses and Payroll'>Remuneration, Expenses and Payroll</option>";
			options += "<option value='Travel Accidents'>Travel Accidents</option>";
			break;
		case "Manage Information Technology":
			options += "<option value='IT Development'>IT Development</option>";
			options += "<option value='IT Implementation'>IT Implementation</option>";
			options += "<option value='IT Maintenance'>IT Maintenance</option>";
			options += "<option value='IT Production'>IT Production</option>";
			options += "<option value='IT Purchasing'>IT Purchasing</option>";
			options += "<option value='IT Security'>IT Security</option>";
			options += "<option value='Maintain Infrastructure and Networks'>Maintain Infrastructure and Networks</option>";
			options += "<option value='Mgt of IT Incidents'>Mgt of IT Incidents</option>";
			break;
		case "Manage Financial Reporting and Taxation":
			options += "<option value='Budgeting and Forecasting'>Budgeting and Forecasting</option>";
			options += "<option value='Financial Accounting and Reporting'>Financial Accounting and Reporting</option>";
			options += "<option value='Management Accounting'>Management Accounting</option>";
			options += "<option value='Management Reporting'>Management Reporting</option>";
			options += "<option value='Taxation'>Taxation</option>";
			break;
		case "Manage Capital, Funding and Liquidity":
			options += "<option value='Capital Management and Funding'>Capital Management and Funding</option>";
			options += "<option value='Management of Corporate Investments'>Management of Corporate Investments</option>";
			break;
		case "Manage Suppliers and Outsourcing Service Suppliers":
			options += "<option value='Conclusion of Outsourcing Contract'>Conclusion of Outsourcing Contract</option>";
			options += "<option value='Conclusion of Suppliers Contract'>Conclusion of Suppliers Contract</option>";
			options += "<option value='Outsourcing Management and Monitoring'>Outsourcing Management and Monitoring</option>";
			options += "<option value='Suppliers Management and Monitoring'>Suppliers Management and Monitoring</option>";
			options += "<option value='Take on Outsourcing'>Take on Outsourcing</option>";
			options += "<option value='Take on Suppliers'>Take on Suppliers</option>";
			break;
		case "Manage Physical Assets and Facilities":
			options += "<option value='Environmental Protection'>Environmental Protection</option>";
			options += "<option value='Facility Mgt'>Facility Mgt</option>";
			options += "<option value='Fleet Mgt'>Fleet Mgt</option>";
			options += "<option value='Health and Safety'>Health and Safety</option>";
			options += "<option value='Office Equipment'>Office Equipment</option>";
			options += "<option value='Other Internal Services'>Other Internal Services</option>";
			options += "<option value='Physical Security'>Physical Security</option>";
			break;
		case "Manage Compliance, Legal, Governance and Audit":
			options += "<option value='Administration of Mandates and Directorships'>Administration of Mandates and Directorships</option>";
			options += "<option value='Audit'>Audit</option>";
			options += "<option value='Information Integrity Management'>Information Integrity Management</option>";
			options += "<option value='Legal Advisory Services'>Legal Advisory Services</option>";
			options += "<option value='Litigation Management'>Litigation Management</option>";
			options += "<option value='Non-Financial Regulatory Reporting'>Non-Financial Regulatory Reporting</option>";
			options += "<option value='Policies, Governance and Monitoring'>Policies, Governance and Monitoring</option>";
			options += "<option value='Protect Private Information'>Protect Private Information</option>";
			break;
		case "Manage Risk Systems":
				options += "<option value='Business Continuity Management'>Business Continuity Management</option>";
			options += "<option value='Control and Oversight of Models and Methodologies'>Control and Oversight of Models and Methodologies</option>";
			options += "<option value='Insurance and Recoveries'>Insurance and Recoveries</option>";
			break;
		default:
	}
	$('#matter_intake_process_type_level_2').html(options);
	if(process_type_2_value) {
		$("#matter_intake_process_type_level_2").val(process_type_2_value);
	}
	$("#matter_intake_process_type_level_2").trigger("chosen:updated");
}

if($('select#matter_intake_event_type_level_1').val()) {
	setMatterIntakeEventType1($('select#matter_intake_event_type_level_1').val());
}

$('select#matter_intake_event_type_level_1').on('change', function() {
	setMatterIntakeEventType1(this.value);
})

function setMatterIntakeEventType1(value) {
	$('select#matter_intake_event_type_level_2').empty();
	var options = "<option value=''> Select option(s)</option>";
	var event_type_2_value = $("#matter_intake_event_type_level_2").attr("data-value");
	switch(value) {
		case "Internal Fraud":
			options += "<option value='Theft and Fraud - Electronic - Internal'>Theft and Fraud - Electronic - Internal</option>";
			options += "<option value='Theft and Fraud - In Person - Internal'>Theft and Fraud - In Person - Internal</option>";
			options += "<option value='Unauthorized Activity'>Unauthorized Activity</option>";
			break;
		case "External Fraud":
			options += "<option value='Theft and Fraud - In Person - External'>Theft and Fraud - In Person - External</option>";
			options += "<option value='Theft and fraud - Electronic - External'>Theft and fraud - Electronic - External</option>";
			break;
		case "Employment Practices and Workplace Safety":
			options += "<option value='Employee Discrimination'>Employee Discrimination</option>";
			options += "<option value='Employee Management Errors'>Employee Management Errors</option>";
			options += "<option value='Unsafe Workplace'>Unsafe Workplace</option>";
			break;
		case "Clients, Products and Business Practices":
			options += "<option value='Improper Business or Market Practices'>Improper Business or Market Practices</option>";
			options += "<option value='Inappropriate Advice'>Inappropriate Advice</option>";
			options += "<option value='Inappropriate Selection or Excessive Exposure'>Inappropriate Selection or Excessive Exposure</option>";
			options += "<option value='Product Flaws'>Product Flaws</option>";
			options += "<option value='Suitability, Disclosure, and Fiduciary'>Suitability, Disclosure, and Fiduciary</option>";
			options += "<option value='Unfounded Lawsuit'>Unfounded Lawsuit</option>";
			break;
		case "Disasters and Public Safety":
			options += "<option value='Physical Harm to Third Parties and Property'>Physical Harm to Third Parties and Property</option>";
			options += "<option value='Property Damage'>Property Damage</option>";
			options += "<option value='Systems Security - Wilful Damage - External'>Systems Security - Wilful Damage - External</option>";
			options += "<option value='Systems Security - Wilful Damage - Internal'>Systems Security - Wilful Damage - Internal</option>";
			options += "<option value='Terrorism'>Terrorism</option>";
			options += "<option value='Wilful Damage'>Wilful Damage</option>";
			break;
		case "Technology and Infrastructure Failures":
			options += "<option value='IT Failures'>IT Failures</option>";
			options += "<option value='Systemic Infrastructure Failures'>Systemic Infrastructure Failures</option>";
			break;
		case "Execution, Delivery and Process Management":
			options += "<option value='Customer Account Management Errors'>Customer Account Management Errors</option>";
			options += "<option value='Customer Intake and Documentation Errors'>Customer Intake and Documentation Errors</option>";
			options += "<option value='Monitoring and Reporting Errors'>Monitoring and Reporting Errors</option>";
			options += "<option value='Transaction Capture, Execution, and Maintenance'>Transaction Capture, Execution, and Maintenance</option>";
			break;
		default:
	}
	$('#matter_intake_event_type_level_2').html(options);
	if(event_type_2_value) {
		$('#matter_intake_event_type_level_2').val(event_type_2_value);
	}
	$("#matter_intake_event_type_level_2").trigger("chosen:updated");
}

if($('select#matter_intake_product_type_level_1').val()) {
	setMatterIntakeProductType1($('select#matter_intake_product_type_level_1').val());
}

$('select#matter_intake_product_type_level_1').on('change', function() {
	setMatterIntakeProductType1(this.value);
})

function setMatterIntakeProductType1(value) {
	$('select#matter_intake_product_type_level_2').empty();
	var options = "<option value=''> Select option(s)</option>";
	var product_type_2_value = $("#matter_intake_product_type_level_2").attr("data-value");
	switch(value) {
		case "Capital Raising":
			options += "<option value='Bond Issuance'>Bond Issuance</option>";
			options += "<option value='Equity Issuance'>Equity Issuance</option>";
			options += "<option value='Private Placements'>Private Placements</option>";
			options += "<option value='Securitisations'>Securitisations</option>";
			options += "<option value='Structured Products Issuance'>Structured Products Issuance</option>";
			options += "<option value='Syndications'>Syndications</option>";
			break;
		case "Corporate Finance Services":
			options += "<option value='Commodities'>Commodities</option>";
			options += "<option value='Corporate Advisory Services'>Corporate Advisory Services</option>";
			options += "<option value='Equities'>Equities</option>";
			options += "<option value='Exchange Traded Futures and Options'>Exchange Traded Futures and Options</option>";
			options += "<option value='Fixed Income'>Fixed Income</option>";
			options += "<option value='Foreign Exchange and Money Markets (FX and MM)'>Foreign Exchange and Money Markets (FX and MM)</option>";
			options += "<option value='Investment Funds'>Investment Funds</option>";
			options += "<option value='Mergers and Acquisitions'>Mergers and Acquisitions</option>";
			options += "<option value='OTC and Securitised Commodity Derivatives'>OTC and Securitised Commodity Derivatives</option>";
			options += "<option value='OTC and Securitised Credit Derivatives'>OTC and Securitised Credit Derivatives</option>";
			options += "<option value='OTC and Securitised Equity Derivatives'>OTC and Securitised Equity Derivatives</option>";
			options += "<option value='OTC and Securitised FX Derivatives'>OTC and Securitised FX Derivatives</option>";
			options += "<option value='OTC and Securitised Interest Rate Derivatives'>OTC and Securitised Interest Rate Derivatives</option>";
			options += "<option value='Other OTC and Securitised Derivatives'>Other OTC and Securitised Derivatives</option>";
			options += "<option value='Repos/Securities Lending'>Repos/Securities Lending</option>";
			break;
		case "Retail Credit":
			options += "<option value='Home Equity Loans and Lines of Credit'>Home Equity Loans and Lines of Credit</option>";
			options += "<option value='Mortgages'>Mortgages</option>";
			options += "<option value='Other Consumer Leasing'>Other Consumer Leasing</option>";
			options += "<option value='Other Secured Consumer Loans'>Other Secured Consumer Loans</option>";
			options += "<option value='Other Unsecured Consumer Loans'>Other Unsecured Consumer Loans</option>";
			options += "<option value='Personal standby letters of credit or guarantees'>Personal standby letters of credit or guarantees</option>";
			options += "<option value='Retail Cards'>Retail Cards</option>";
			options += "<option value='Student Loans'>Student Loans</option>";
			options += "<option value='Vehicle Leasing'>Vehicle Leasing</option>";
			options += "<option value='Vehicle Loans'>Vehicle Loans</option>";
			break;
		case "Commercial Credit":
			options += "<option value='Card Merchant Services'>Card Merchant Services</option>";
			options += "<option value='Commercial and Industrial Loans'>Commercial and Industrial Loans</option>";
			options += "<option value='Commercial Cards'>Commercial Cards</option>";
			options += "<option value='Commercial Leases'>Commercial Leases</option>";
			options += "<option value='Commercial Real Estate Loans'>Commercial Real Estate Loans</option>";
			options += "<option value='Construction, Acquisition and Development Loans'>Construction, Acquisition and Development Loans</option>";
			options += "<option value='Factoring'>Factoring</option>";
			options += "<option value='Project Finance Loans'>Project Finance Loans</option>";
			options += "<option value='Standby Letters of Credit, Bank Guarantees, Bankers Acceptances'>Standby Letters of Credit, Bank Guarantees, Bankers Acceptances</option>";
			options += "<option value='Structured Lending'>Structured Lending</option>";
			options += "<option value='Trade Finance'>Trade Finance</option>";
			break;
		case "Deposits":
			options += "<option value='Commercial Bank Accounts'>Commercial Bank Accounts</option>";
			options += "<option value='Commercial Time and Term Deposits'>Commercial Time and Term Deposits</option>";
			options += "<option value='Consumer Current Accounts'>Consumer Current Accounts</option>";
			options += "<option value='Consumer Notice Accounts'>Consumer Notice Accounts</option>";
			options += "<option value='Investment Products'>Investment Products</option>";
			break;
		case "Cash Management, Payments and Settlements":
			options += "<option value='Clearing'>Clearing</option>";
			options += "<option value='Commercial Cash Management'>Commercial Cash Management</option>";
			options += "<option value='Electronic Payments'>Electronic Payments</option>";
			options += "<option value='Exchange Services'>Exchange Services</option>";
			options += "<option value='Manual Payments'>Manual Payments</option>";
			options += "<option value='Retail Cash Management'>Retail Cash Management</option>";
			options += "<option value='Settlement'>Settlement</option>";
			break;
		case "Trust/Investment Management":
			options += "<option value='Advisory Portfolio Management'>Advisory Portfolio Management</option>";
			options += "<option value='Corporate Actions Services'>Corporate Actions Services</option>";
			options += "<option value='Corporate Trusts'>Corporate Trusts</option>";
			options += "<option value='Custody Services'>Custody Services</option>";
			options += "<option value='Discretionary Portfolio Management'>Discretionary Portfolio Management</option>";
			options += "<option value='Execution-only Services'>Execution-only Services</option>";
			options += "<option value='Financial and Estate Planning'>Financial and Estate Planning</option>";
			options += "<option value='Lombard Credits'>Lombard Credits</option>";
			options += "<option value='Prime Brokerage'>Prime Brokerage</option>";
			break;
		case "Investment Products":
			options += "<option value='Fund Administration'>Fund Administration</option>";
			options += "<option value='Institutional Asset Management - Traditional'>Institutional Asset Management - Traditional</option>";
			options += "<option value='Institutional Asset Management - Alternative'>Institutional Asset Management - Alternative</option>";
			break;
		case "Brokerage":
			options += "<option value='Full Service Brokerage'>Full Service Brokerage</option>";
			options += "<option value='Self Directed Brokerage'>Self Directed Brokerage</option>";
			break;
		case "Not Product Related":
			options += "<option value='Not Product Related'>Not Product Related</option>";
			break;
		case "Non-Banking Product":
			options += "<option value='Non-Banking Product'>Non-Banking Product</option>";
			break;
		default:
	}
	$('#matter_intake_product_type_level_2').html(options);
	if(product_type_2_value) {
		$('#matter_intake_product_type_level_2').val(product_type_2_value);
	}
	$("#matter_intake_product_type_level_2").trigger("chosen:updated");
}

if($('#matter_intake_business_activity_level_1').val()) {
	setMatterIntakeBusinessActivityLevel1($('#matter_intake_business_activity_level_1').val());
}

$('select#matter_intake_business_activity_level_1').on('change', function() {
	setMatterIntakeBusinessActivityLevel1(this.value);
})

function setMatterIntakeBusinessActivityLevel1(value) {
	$('select#matter_intake_business_activity_level_2').empty();
	var options = "<option value=''> Select option(s)</option>";
	var business_activity_level_2_value = $("#matter_intake_business_activity_level_2").attr("data-value");
	switch(value) {
		case "Corporate Finance":
			options += "<option value='Advisory Services'>Advisory Services</option>";
			options += "<option value='Corporate Finance'>Corporate Finance</option>";
			options += "<option value='Municipal/Government Finance'>Municipal/Government Finance</option>";
			break;
		case "Trading and Sales":
			options += "<option value='Corporate Investments'>Corporate Investments</option>";
			options += "<option value='Equities'>Equities</option>";
			options += "<option value='Global Markets'>Global Markets</option>";
			options += "<option value='Treasury'>Treasury</option>";
			break;
		case "Retail Banking":
			options += "<option value='Retail Banking'>Retail Banking</option>";
			break;
		case "Commercial Banking":
			options += "<option value='Commercial Banking'>Commercial Banking</option>";
			break;
		case "Clearing":
			options += "<option value='Cash clearing'>Cash clearing</option>";
			options += "<option value='Securities clearing'>Securities clearing</option>";
			break;
		case "Agency Services":
			options += "<option value='Corporate Trust and Agency'>Corporate Trust and Agency</option>";
			options += "<option value='Custody'>Custody</option>";
			options += "<option value='Custom Services'>Custom Services</option>";
			break;
		case "Asset Management":
			options += "<option value='Fund Management'>Fund Management</option>";
			break;
		case "Retail Brokerage":
			options += "<option value='Retail Brokerage'>Retail Brokerage</option>";
			break;
		case "Private Banking":
			options += "<option value='Private Banking'>Private Banking</option>";
			break;
		case "Corporate Areas":
			options += "<option value='Corporate Areas'>Corporate Areas</option>";
			options += "<option value='Technology Areas'>Technology Areas</option>";
			break;
		case "Insurance":
			options += "<option value='Insurance'>Insurance</option>";
			break;
		case "Card Services":
			options += "<option value='Card Services'>Card Services</option>";
			break;
		case "Branch Banking":
			options += "<option value='Branch Banking'>Branch Banking</option>";
			break;
		default:
	}
	$('#matter_intake_business_activity_level_2').html(options);
	if(business_activity_level_2_value) {
		$('#matter_intake_business_activity_level_2').val(business_activity_level_2_value);
	}
	$("#matter_intake_business_activity_level_2").trigger("chosen:updated")
}

$(document).ready(function() {
	// general intake
	var mode_of_payment = $('select#matter_intake_mode_of_payment > option:selected').val();

	if(mode_of_payment == 'N/A Internal – no law firm will be engaged') {
		$('.internal-matter').hide()
	} 

	// litigation inhtake
	var mode_of_payment_litigation = $('select#matter_intake_outside_counsel_engaged > option:selected').val();

	if(mode_of_payment_litigation == 'N/A Internal – no law firm will be engaged' || mode_of_payment_litigation ==  "") {
		$('.internal-matter').hide()
	} 

})

$('select#matter_intake_mode_of_payment, select#matter_intake_type_of_price, select#matter_intake_outside_counsel_engaged').on('change', function() {
	if(this.value == 'N/A Internal – no law firm will be engaged') {
		$('.internal-matter').hide()
		$('.panel_firm').hide()
		$('.non_panel_firm').hide()
	} else {
		$('.internal-matter').show()
		var matter_intake_firm_type = $('select#matter_intake_firm_type > option:selected').val();
		var matter_intake_type_of_price = $('select#matter_intake_type_of_price > option:selected').val();
		var type_of_price = ["Hourly Billing", "Work done at no cost"];
		
		// Handle on load case
		if(matter_intake_firm_type === "Panel") {
			$('.panel_firm').show()
			$('.non_panel_firm').hide()
		} else if(matter_intake_firm_type === "Non-Panel") {
			$('.panel_firm').hide()
			$('.non_panel_firm').show()
		} else if (matter_intake_firm_type === "Panel & Non-Panel Firms") {
			$('.panel_firm').show()
			$('.non_panel_firm').show()
		} else {
			$('.panel_firm').hide()
			$('.non_panel_firm').hide()
		}
	
		if(matter_intake_type_of_price != "" && !type_of_price.includes(matter_intake_type_of_price)) {
			$('.alternative_fee').show();
			$('#matter_intake_is_alternative_fee_arrangement').val("Yes")
			$('.afa_details').show();
			$("#matter_intake_is_alternative_fee_arrangement").trigger("chosen:updated")
		} else {
			$('.alternative_fee').hide();
			$('#matter_intake_is_alternative_fee_arrangement').val("No")
			$('#matter_intake_afa_details').val('');
			$('.afa_details').hide();
			$("#matter_intake_is_alternative_fee_arrangement").trigger("chosen:updated")
		}
	}
})

$( ".exception_request_reason input.check_boxes" ).on( "click", function() {
  var reasonArray = []
  $(".exception_request_reason input.check_boxes:checked").each(function(){
    reasonArray.push($(this).val());
	});
  if(reasonArray.includes("Expertise") || reasonArray.includes("Cost") ){
     $('.exception_request_women_owned_box').removeClass('hide')
  }else{
		$('.exception_request_women_owned_box').addClass('hide')
		$("#exception_request_women_owned").val('No');
		$(".women_owned_details").hide();
		$('#exception_request_women_owned_details').val('');
		$("#exception_request_women_owned").trigger("chosen:updated");
  }
});

if($('select#panel_request_niche_preferred_external_counsel_panel_law_firms').val() == "Yes"){
	$('.panel_request_niche_expertise').show()
}
$('select#panel_request_niche_preferred_external_counsel_panel_law_firms').on('change', function() {
	if(this.value == "Yes"){
		$('.panel_request_niche_expertise').show()
	}else{
		$('.panel_request_niche_expertise').hide()
		$('#panel_request_niche_expertise').val(" ")
	}
});

if($('select#panel_request_required_unique_geography').val() == "Yes"){
	$('.panel_request_geographic_location').show()
}
$('select#panel_request_required_unique_geography').on('change', function() {
	if(this.value == "Yes"){
		$('.panel_request_geographic_location').show()
	}else{
		$('.panel_request_geographic_location').hide()
		$('#panel_request_geographic_location').val(" ")
	}
});

if($("select#matter_intake_outside_counsel_engaged").val() == "N/A Internal – no law firm will be engaged" || $("select#matter_intake_outside_counsel_engaged").val() == "" || $('.matter_intake_outside_counsel_engaged_value').attr('data-value') === "N/A Internal – no law firm will be engaged" || $('.matter_intake_outside_counsel_engaged_value').attr('data-value') === "" ) {
	$('.outside_counsel_engaged').hide()
	$('.lob_matter_submit_btn').val("Submit")
} else {
	$('.outside_counsel_engaged').show()
	$('.lob_matter_submit_btn').val("Next")
}

$('select#matter_intake_outside_counsel_engaged').on('change', function() {
	if(this.value == "N/A Internal – no law firm will be engaged" || this.value == ""){
		$('.outside_counsel_engaged').hide()
		$('.lob_matter_submit_btn').val("Submit")
	} else {
		$('.outside_counsel_engaged').show()
		$('.lob_matter_submit_btn').val("Next")
	}
})

$('.lxp_review_status').on('click', function() {
	var status = $(this).attr("data-status");

	if(status) {
		$('#review_status').val(status);
		$('#review_status').trigger('chosen:updated');
		$(".form-submit-btn.lxp_sttaus").trigger('click');
	}

})

if($('select#conflict_waiver_confirm_waiver').val() === "true") {
	$('.confirm_waiver_notes').show()
	$('.confirm_waiver_btn').addClass('hide')
	$('.btn_confirm').removeClass('hide')
}

$('select#conflict_waiver_confirm_waiver').on('change', function() {
	var selectedValue = this.value;
	if(selectedValue === "true") {
		$('.confirm_waiver_notes').show()
		$('.confirm_waiver_btn').addClass('hide')
		$('.btn_confirm').removeClass('hide')
	} else {
		$('.confirm_waiver_notes').hide()
		$('.confirm_waiver_btn').removeClass('hide')
		$('.btn_confirm').addClass('hide')
	}
});


$(".loader").hide();

$('.email_wnn_documents').on('click', function() {
	var panel_request_id = $(this).attr("data-id");

	if(panel_request_id) {
		$(".loader").show();
		$.ajax({
			url: "/admin/panel_requests/send_wnn_documents",
			method: "post",
			data: {id : panel_request_id}
		})
		.done(function( response) {
			if(response){
				swal({
					title: response.title,
					icon: response.icon,
					text: response.message
				});	
				$(".loader").hide();
			}
		});
	}

})

$('.non-panel_send_retainer').on('click', function() {

	message = "Confirmation: Send Retainer Agreement"
	var non_panel_id = $(this).attr("data-id");
	swal({
		title: message,
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
			if(non_panel_id) {
				$(".non_panel_send_retainer_status").html("")
				$(".loader").show();
				$.ajax({
					url: "/admin/exception_requests/send_retainer_aggreement",
					method: "post",
					data: {id : non_panel_id}
				})
				.done(function( response) {
					if(response){
							$(".non_panel_send_retainer_status").html(response.title)
							swal({
								title: response.title,
								icon: response.icon,
								text: response.message,
								confirmButtonText: "Ok",
								cancelButtonText: "Cancel",
								closeOnConfirm: true,
								closeOnCancel: true
							},
							function(isConfirm){
								if (isConfirm) {
									if($(".non_panel_send_retainer_status").html() === "Success"){
										options = "<option value='RETAINER_AGREEMENT_SENT'>Retainer Agreement Sent</option>";
										$('#review_status').html(options);
										$("#review_status").trigger("chosen:updated")
										$("#new_review").submit()
									}
								}
							});
						// swal({
						// 	title: response.title,
						// 	icon: response.icon,
						// 	text: response.message,
						// });	
						$(".loader").hide();
					}
				});
			}
		}
	});
	return false

})

if($("select#matter_intake_is_ore_reportable").val() == "Yes" || $('#litigation_reporting').val() == "Yes") {
	$('.litigation_reporting').show()
} else {
	$('.litigation_reporting').hide()
}

$('select#matter_intake_is_ore_reportable').on('change', function() {
	if(this.value == "Yes"){
		$('.litigation_reporting').show()
	} else {
		$('.litigation_reporting').hide()
	}
})

if($("select#matter_intake_receive_personal_information").val() == "Yes" ) {
	$('.receive_personal_information_data_type_data_list').show()
} else {
	$('.receive_personal_information_data_type_data_list').hide()
}

$('select#matter_intake_receive_personal_information').on('change', function() {
	if(this.value == "Yes"){
		$('.receive_personal_information_data_type_data_list').show()
	} else {
		$('.receive_personal_information_data_type_data_list').hide()
	}
})

if($("select#matter_intake_receive_general_business_data").val() == "Yes" ) {
	$('.receive_general_business_data_type_data_list').show()
} else {
	$('.receive_general_business_data_type_data_list').hide()
}
$('select#matter_intake_receive_general_business_data').on('change', function() {
	if(this.value == "Yes"){
		$('.receive_general_business_data_type_data_list').show()
	} else {
		$('.receive_general_business_data_type_data_list').hide()
	}
})

if($("select#matter_intake_applicable_technical_specialty_data").val() == "Yes" ) {
	$('.applicable_technical_specialty_data_type_data_list').show()
} else {
	$('.applicable_technical_specialty_data_type_data_list').hide()
}
$('select#matter_intake_applicable_technical_specialty_data').on('change', function() {
	if(this.value == "Yes"){
		$('.applicable_technical_specialty_data_type_data_list').show()
	} else {
		$('.applicable_technical_specialty_data_type_data_list').hide()
	}
})

//New Non-Panel (one-off) Request


if($("select#exception_request_receive_personal_information").val() == "Yes" ) {
	$('.receive_personal_information_data_type_data_list').show()
} else {
	$('.receive_personal_information_data_type_data_list').hide()
}

$('select#exception_request_receive_personal_information').on('change', function() {
	if(this.value == "Yes"){
		$('.receive_personal_information_data_type_data_list').show()
	} else {
		$('.receive_personal_information_data_type_data_list').hide()
	}
})

if($("select#exception_request_receive_general_business_data").val() == "Yes" ) {
	$('.receive_general_business_data_type_data_list').show()
} else {
	$('.receive_general_business_data_type_data_list').hide()
}
$('select#exception_request_receive_general_business_data').on('change', function() {
	if(this.value == "Yes"){
		$('.receive_general_business_data_type_data_list').show()
	} else {
		$('.receive_general_business_data_type_data_list').hide()
	}
})

if($("select#exception_request_applicable_technical_specialty_data").val() == "Yes" ) {
	$('.applicable_technical_specialty_data_type_data_list').show()
} else {
	$('.applicable_technical_specialty_data_type_data_list').hide()
}
$('select#exception_request_applicable_technical_specialty_data').on('change', function() {
	if(this.value == "Yes"){
		$('.applicable_technical_specialty_data_type_data_list').show()
	} else {
		$('.applicable_technical_specialty_data_type_data_list').hide()
	}
})

//$(".simple_form.edit_exception_request").validate();

// $(document).ready(function(){
// 	$('.simple_form_edit_exception_request').click(function(){ 
		
// 		 if($('select#exception_request_matter_involve_following').val() == ""){
// 				$(".exception_request_matter_involve_following_error").show()
// 		}else{
// 				$(".exception_request_matter_involve_following_error").hide()
// 		}
		 
// 	});
// });


function validateEmail(emailField){
	var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
	if (reg.test(emailField) == false) 
	{
			return false;
	}
	return true;
}

$(document).ready(function() {
	$("#next-btn-information").click(function(){  // capture the click
		exception_request_line_of_business = $('select#exception_request_line_of_business');
		exception_request_law_firm_name = $('#exception_request_law_firm_name');
		exception_request_law_firm_phone = $('#exception_request_law_firm_phone');
		exception_request_law_firm_email = $('#exception_request_law_firm_email');
		exception_request_matter_name = $('#exception_request_matter_name');
		exception_request_matter_description = $('#exception_request_matter_description');
		exception_request_matter_involve_following = $('select#exception_request_matter_involve_following');
		exception_request_law_firm_email_val = true;
		if(exception_request_line_of_business.val() == ""){
				$(exception_request_line_of_business).parent().parent().find(".custom-error").show()
		}else{
				$(exception_request_line_of_business).parent().parent().find(".custom-error").hide()
		}
		if(exception_request_law_firm_name.val() == ""){
			$(exception_request_law_firm_name).parent().parent().find(".custom-error").show()
		}else{
				$(exception_request_law_firm_name).parent().parent().find(".custom-error").hide()
		}
		if(exception_request_law_firm_phone.val() == ""){
			$(exception_request_law_firm_phone).parent().parent().find(".custom-error").show()
		}else{
				$(exception_request_law_firm_phone).parent().parent().find(".custom-error").hide()
		}
		if(exception_request_law_firm_email.val() == ""){
			$(exception_request_law_firm_email).parent().parent().find(".custom-error").show()
		}else{
			exception_request_law_firm_email_val = validateEmail(exception_request_law_firm_email.val())
			if(exception_request_law_firm_email_val){
				$(exception_request_law_firm_email).parent().parent().find(".email-error").hide()
			}else{
				$(exception_request_law_firm_email).parent().parent().find(".email-error").show()
			}
			$(exception_request_law_firm_email).parent().parent().find(".custom-error").hide()
		}
		if(exception_request_matter_name.val() == ""){
			$(exception_request_matter_name).parent().parent().find(".custom-error").show()
		}else{
				$(exception_request_matter_name).parent().parent().find(".custom-error").hide()
		}
		if(exception_request_matter_description.val() == ""){
			$(exception_request_matter_description).parent().parent().find(".custom-error").show()
		}else{
				$(exception_request_matter_description).parent().parent().find(".custom-error").hide()
		}
		if(exception_request_matter_involve_following.val() == ""){
			$(exception_request_matter_involve_following).parent().parent().find(".custom-error").show()
		}else{
				$(exception_request_matter_involve_following).parent().parent().find(".custom-error").hide()
		}
		if(exception_request_line_of_business.val() != "" && exception_request_law_firm_name.val() != "" && exception_request_law_firm_phone.val() != "" && exception_request_law_firm_email.val() != "" && exception_request_matter_name.val() != "" && exception_request_matter_description.val() != "" && exception_request_matter_involve_following.val() != "" && exception_request_law_firm_email_val != "" ){
			$("#tabs-exception").tabs("enable", 3);
			$("#next-information-btn").click()
		}else{
			$("#tabs-exception").tabs("option", "disabled", [3]);
			return false;
		}
	});

$('.simple_form_edit_exception_request').click(function(){ 
	
	exception_request_receive_personal_information = $('select#exception_request_receive_personal_information');
	exception_request_receive_general_business_data = $('select#exception_request_receive_general_business_data');
	exception_request_applicable_technical_specialty_data = $('select#exception_request_applicable_technical_specialty_data'); 
		
	if(exception_request_receive_personal_information.val() == ""){
		$(exception_request_receive_personal_information).parent().parent().find(".custom-error").show()
	}else{
			$(exception_request_receive_personal_information).parent().parent().find(".custom-error").hide()
	}
	if(exception_request_receive_general_business_data.val() == ""){
		$(exception_request_receive_general_business_data).parent().parent().find(".custom-error").show()
	}else{
		$(exception_request_receive_general_business_data).parent().parent().find(".custom-error").hide()
	}
	if(exception_request_applicable_technical_specialty_data.val() == ""){
		$(exception_request_applicable_technical_specialty_data).parent().parent().find(".custom-error").show()
	}else{
		$(exception_request_applicable_technical_specialty_data).parent().parent().find(".custom-error").hide()
	}

	if(exception_request_receive_personal_information.val() != "" && exception_request_receive_general_business_data.val() != "" && exception_request_applicable_technical_specialty_data.val() != "" ){
		return true;
	}else{
		return false;
	}
});


$('.simple_form_edit_matter_intakes').click(function(){ 
	
	matter_intake_receive_personal_information = $('select#matter_intake_receive_personal_information');
	matter_intake_receive_general_business_data = $('select#matter_intake_receive_general_business_data');
	matter_intake_applicable_technical_specialty_data = $('select#matter_intake_applicable_technical_specialty_data'); 
		
	if(matter_intake_receive_personal_information.val() == ""){
		$(matter_intake_receive_personal_information).parent().parent().find(".custom-error").show()
	}else{
			$(matter_intake_receive_personal_information).parent().parent().find(".custom-error").hide()
	}
	if(matter_intake_receive_general_business_data.val() == ""){
		$(matter_intake_receive_general_business_data).parent().parent().find(".custom-error").show()
	}else{
		$(matter_intake_receive_general_business_data).parent().parent().find(".custom-error").hide()
	}
	if(matter_intake_applicable_technical_specialty_data.val() == ""){
		$(matter_intake_applicable_technical_specialty_data).parent().parent().find(".custom-error").show()
	}else{
		$(matter_intake_applicable_technical_specialty_data).parent().parent().find(".custom-error").hide()
	}

	if(matter_intake_receive_personal_information.val() != "" && matter_intake_receive_general_business_data.val() != "" && matter_intake_applicable_technical_specialty_data.val() != "" ){
		return true;
	}else{
		return false;
	}
});

$('.simple_form_admin_matter_intakes').click(function(){ 
	
	matter_intake_receive_personal_information = $('select#matter_intake_receive_personal_information');
	matter_intake_receive_general_business_data = $('select#matter_intake_receive_general_business_data');
	matter_intake_applicable_technical_specialty_data = $('select#matter_intake_applicable_technical_specialty_data'); 
		
	if(matter_intake_receive_personal_information.val() == ""){
		$(matter_intake_receive_personal_information).parent().parent().find(".custom-error").show()
	}else{
			$(matter_intake_receive_personal_information).parent().parent().find(".custom-error").hide()
	}
	if(matter_intake_receive_general_business_data.val() == ""){
		$(matter_intake_receive_general_business_data).parent().parent().find(".custom-error").show()
	}else{
		$(matter_intake_receive_general_business_data).parent().parent().find(".custom-error").hide()
	}
	if(matter_intake_applicable_technical_specialty_data.val() == ""){
		$(matter_intake_applicable_technical_specialty_data).parent().parent().find(".custom-error").show()
	}else{
		$(matter_intake_applicable_technical_specialty_data).parent().parent().find(".custom-error").hide()
	}

	if(matter_intake_receive_personal_information.val() != "" && matter_intake_receive_general_business_data.val() != "" && matter_intake_applicable_technical_specialty_data.val() != "" ){
		return true;
	}else{
		return false;
	}
});




});
