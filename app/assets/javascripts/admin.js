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

	$('select#review_status').chosen().change(function() {
		if(this.value == "APPROVED"){
			$(".internal_lawyers_box").show()
			
		}else{
			$(".internal_lawyers_box").hide()
			$('select#review_assigned_to').val('').trigger('chosen:updated');
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
		if(PAY_TYPE == "BANK_PAY"){
			message = "Confirm To Emails Retainer and Forms to Law firm to fill/sign ?"
		}else{
			message = "Confirm To Emails Retainer to LOB to sign"
		}

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
					var options = "<option value=''> Select State</option>";
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



if($('.engageForm select#law_firm_matter_type_ids').val()){
		
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
					var options = "<option value=''> Select State</option>";
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

if($('.engageForm select#law_firm_country_ids').val()){

	$.ajax({
		url: "/lob/exception_requests/get_state",
		method: "post",
		data: {id : $('select#law_firm_country_ids').val()}
	})
		.done(function( data ) {
			if(data){
				$('.state_type_box').show()
				var options = "<option value=''> Select State</option>";
				for (var i=0; i < data.data.length; i++){
					options += "<option value="+data.data[i].id+">"+data.data[i].name+"</option>";
				};
				$('#law_firm_states_ids').html(options);
				$("#law_firm_states_ids").trigger("chosen:updated");       // updates chosen
				return false;    
			}
		});
}


$('.searchLawFirm').on('click', function() {
	matter_type = $('select#law_firm_matter_types').chosen().val()
	sub_matter_type = $('select#law_firm_sub_matter_types').chosen().val()
	jurisdiction_type = $('select#law_firm_jurisdiction_types').chosen().val()
	country = $('select#law_firm_countries').chosen().val()
	state = $('select#law_firm_states').chosen().val()
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
				if(data){
						for (var i=0; i < data.data.length; i++){
							html += 
							`<tr id=lawFirm_`+data.data[i].id+`>
									<td><input name="exception_request[law_firm_id]" type="radio" value="`+data.data[i].id+`" /></td>
									<td>`+data.data[i].name+`</td>
									<td>`+data.data[i].email+`</td>
									<td>`+data.data[i].phone+`(`+data.data[i].phone+`)</td>
								</tr>`;	
							//options += "<option value="+data.data[i].id+">"+data.data[i].sub_matter_type+"</option>";
						};
						
				}else{
					html += "<tr><td>No Law Firm Match Your criteria<td></tr>";		
				}
				 html += "</table>";		
				 $('.law_firm_list table#dt_basic').find('tbody').html(html)
				 $('.law_firm_list').show()
			});
	}else{
		swal({
			title: "Oops!",
			text: "Please select atleast one option"
		});
	}
	return false
});

$('.engage_non_panel_firm_btn').on('click', function() {
	law_firm_id = $('input[name="exception_request[law_firm_id]"]:checked').val()
	is_work = $('input[name="exception_request[is_work]"]:checked').val()

	if(is_work === "Yes"){
		if(law_firm_id){
			return true
		}else{
			swal({
				title: "Opps!",
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
$(".simple_form.edit_exception_request").validate();

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

$('select#matter_intake_work_area').on('change', function() {
	var work_area = this.value;
	if(work_area === "Regulatory") {
		$('.work_area_reportable').show()
	} else {
		$('.work_area_reportable').hide()
	}
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
	
	if(type_of_price.includes(matter_intake_type_of_price)) {
		$('.alternative_fee').show();
		$('#matter_intake_is_alternative_fee_arrangement').val("true")
	} else {
		$('.alternative_fee').hide();
		$('#matter_intake_is_alternative_fee_arrangement').val("false")
	}

	$('select#matter_intake_type_of_price').on('change', function() {
		var selectedValue = this.value;
		if(type_of_price.includes(selectedValue)) {
			$('.alternative_fee').show();
			$("#matter_intake_is_alternative_fee_arrangement option[value='true']").attr("selected", "selected")
			$("#matter_intake_is_alternative_fee_arrangement option[value='false']").attr("selected", null)
		} else {
			$('.alternative_fee').hide();
			$("#matter_intake_is_alternative_fee_arrangement option[value='true']").attr("selected", null)
			$("#matter_intake_is_alternative_fee_arrangement option[value='false']").attr("selected", "selected")
		}
	});
})
 
$(".next-btn-exception").click(function () {
	$( "#tabs-exception" ).tabs( "option", "active", $("#tabs-exception").tabs('option', 'active')+1 );
});
$(".prev-btn-exception").click(function () {
	$( "#tabs-exception" ).tabs( "option", "active", $("#tabs-exception").tabs('option', 'active')-1 );
});


// adminLawFirm
$(".adminLawFirm .new_law_firm").validate();


$('.adminLawFirm select#law_firm_matter_types').on('change', function() {
	if(this.value){
		
		$.ajax({
			url: "/admin/law_firms/get_sub_matter_types",
			method: "post",
			data: {id : $('select#law_firm_matter_types').val()}
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

$('.adminLawFirm select#law_firm_countries').on('change', function() {
	if(this.value){
		
		$.ajax({
			url: "/admin/law_firms/get_state",
			method: "post",
			data: {id : $('select#law_firm_countries').val()}
		})
			.done(function( data ) {
				if(data){
					$('.state_type_box').show()
					var options = "<option value=''> Select State</option>";
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

/*
$('select#law_firm_matter_type_ids').on('change', function() {
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



if($('select#law_firm_matter_type_ids').val()){
		
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

$('select#law_firm_country_ids').on('change', function() {
	if(this.value){
		
		$.ajax({
			url: "/lob/exception_requests/get_state",
			method: "post",
			data: {id : $('select#law_firm_country_ids').val()}
		})
			.done(function( data ) {
				if(data){
					$('.state_type_box').show()
					var options = "<option value=''> Select State</option>";
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

if($('select#law_firm_country_ids').val()){

	$.ajax({
		url: "/lob/exception_requests/get_state",
		method: "post",
		data: {id : $('select#law_firm_country_ids').val()}
	})
		.done(function( data ) {
			if(data){
				$('.state_type_box').show()
				var options = "<option value=''> Select State</option>";
				for (var i=0; i < data.data.length; i++){
					options += "<option value="+data.data[i].id+">"+data.data[i].name+"</option>";
				};
				$('#law_firm_states_ids').html(options);
				$("#law_firm_states_ids").trigger("chosen:updated");       // updates chosen
				return false;    
			}
		});
}


*/
