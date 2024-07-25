$(document).ready(function(){
  // $("*[data-custom-logic='true']").each(function(){
  //   prepareForCustomLogic($(this).find('.form_submission_form_values_value input, .form_submission_form_values_value select'));
  // });
  
  // $('.dynamic-select').trigger('change');

  // if($(".form-wizard-wrapper").length > 0){
  //   // $(window).unload(function(){
  //   //   alert("Goodbye!");
  //   // });
  //   window.onbeforeunload = function() {
  //     if(!window.skipUnload){
  //       return "Are you sure you wish to leave the page? You may loose your changes";
  //     }
  //   }
  // }

  setSsoType();

  $("#tenant_sso_type").on('change', function() {
    setSsoType();
  })



  $(".show_technology_uploader").on('click', function(){
    $(".technology-uploader-container").removeClass('hidden');
    $(".technology-form-container").addClass('hidden');
  })

  $(".show_technology_form").on('click', function(){
    $(".technology-uploader-container").addClass('hidden');
    $(".technology-form-container").removeClass('hidden');
  })

  $('.fileupload-technology').fileupload({
    dataType: 'html',
    maxNumberOfFiles: 1,
    url: window.location.pathname + "_bulk_upload",
    type: 'POST',
    add: function(e, data) {
      upload_custom_file = $(e.target).data("uploadCustomCsv")
      data.url = window.location.pathname + "_bulk_upload?upload_custom_file=" + upload_custom_file;
      var uploadErrors = [];
      if(upload_custom_file){
        if(data.originalFiles[0]['type'].length && data.originalFiles[0]['type'] != 'text/csv') {
            uploadErrors.push('Not an accepted file type, only CSV files are allowed.');
        }
      }
      if(data.originalFiles[0]['size'] && data.originalFiles[0]['size'] > 10000000) {
          uploadErrors.push('Filesize is too big. Maximum filesize allowed is 10MB');
      }
      if(uploadErrors.length > 0) {
          sweetAlert("Oops...", uploadErrors.join("\n"), "error");
      } else {
          data.submit();
      }
    },
    done: function (e, data) {
      response = JSON.parse(data.response().result);
      if(response.upload_custom_file){
        if(response.invalid_rows.length == 0){
          sweetAlert("Success", "Successfully imported " + response.rows.length + " rows", "success");
          setTimeout(function(){
            window.location.reload()
          }, 5000);
        }else if(response.rows.length == 0){
          sweetAlert("Oops...", "Looks like there's an issue with the CSV you have uploaded, please use the sample CSV", "error");
        }else{
          sweetAlert("Oops...", "Successfully imported " + response.rows.length + " rows but there are " + response.invalid_rows.length + " row(s) that we were not able to import", "warning");
          setTimeout(function(){
            window.location.reload()
          }, 5000);
        }
      }else{
        sweetAlert("Success", response.message, "success");
      }
    },
    progressall: function (e, data) {
      container = $(this);
      var progress = parseInt(data.loaded / data.total * 100, 10);
      container.parent().find('#progress .bar').css(
          'width',
          progress + '%'
      )
      .css('display', 'block')
      .text(progress + '%');
    }
  });

  var currentUrl = window.location.href;

  $('.masked-phone').mask('(000)-000-0000');
  $('.masked-money').maskMoney({prefix:'USD ', allowNegative: true, thousands:',', affixesStay: false});

  $('.login-btn').on('click', function(){
    // if ( $('#tandc').prop('checked') == false ){ 
      // $('.login-error').css('display', 'block').html('Please accept the terms and conditions');
    // } else if ( $('#privacy-policy').prop('checked') == false ) {
      // $('.login-error').css('display', 'block').html('Please accept the privacy policy');
    // } else {
      // $('.login-error').css('display', 'none');
    // }
  })

  $('.delete-note').on('click', function(){
    var poa = $(this);
    var data = {};
    data.id = $(this).data('id');

    swal({
      title: "Are you sure?",
      text: "You're about to delete your note. You cannot undo this action.",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, delete note",
      cancelButtonText: "Cancel",
      closeOnConfirm: true,
      closeOnCancel: true
    },
    function(isConfirm){
      if (isConfirm) {
        $.ajax({
          method: 'DELETE',
          url: '/admin/notes/' + data.id,
          data: data,
          context: $(this),
          success: function() {
            // toastr.success("", "Recertification process has begun")
            window.location.reload();
          },
          error: function(response) {
            toastr.error('You\re not authorized to delete the note', 'Error');
          }
        })
      }
    });

  })

  if($.cookie('byp-text-understood') == 'true') {
    $('.byp-wrapper-help').addClass('hidden')
  } else {
    $('.byp-wrapper-help').removeClass('hidden')
  }
  $('.dont-show-byp-wrapper a').click(function(){
    if($(this).parent().find('input[type=checkbox]').is(':checked')) {
      $.cookie('byp-text-understood', 'true');
    }
    $(this).parent().parent().hide();
  })

  if($.cookie('tech-help-text-understood') == 'true') {
    $('.tech-form-wraper-help').addClass('hidden')
  } else {
    $('.tech-form-wraper-help').removeClass('hidden')
  }
  $('.dont-show-wrapper a').click(function(){
    if($(this).parent().find('input[type=checkbox]').is(':checked')) {
      $.cookie('tech-help-text-understood', 'true');
    }
    $(this).parent().parent().hide();
  })

  $('.tech-form-wraper-csv-toggle a').click(function(){
    if($(this).text() == 'Yes') {
      $(".technology-uploader-container").removeClass('hidden');
      $(".technology-form-container").addClass('hidden');
    } 
    if($(this).text() == 'No'){
      $(".technology-uploader-container").addClass('hidden');
      $(".technology-form-container").removeClass('hidden');
      $('.tech-form-wraper.form').removeClass('hidden')
      $('.tech-form-wraper-csv-toggle').addClass('hidden')
    }
    $.cookie('tech-form-selection', 'true');
  })

  if($.cookie('tech-form-selection') == 'true') {
    $('.tech-form-wraper-csv-toggle').addClass('hidden')
    $(".technology-form-container").removeClass('hidden');
    $('.tech-form-wraper.form').removeClass('hidden')
  } else {
    $('.tech-form-wraper-csv-toggle').removeClass('hidden')
  }

  $('.cloned-form').hide()
  $('#view-only-follow-ups').on('click', function(){
    if($('.cloned-form > div > .need-follow-up').size() == 0 ){
      var element = jQuery('.need-follow-up').clone();
      element.appendTo('.cloned-form > div');
    }
    $('.real-form').fadeOut();
    $('.cloned-form').fadeIn();
  })

  $('#view-all-questions').on('click', function(){
    $('.real-form').fadeIn();
    $('.cloned-form').fadeOut();
  })

  function save_user_progress(){
    if(currentUrl.indexOf("form_submissions") > -1 && currentUrl.indexOf("admin") == -1){
      $('.save-btn').trigger('click');
    }
  }

  // window.setInterval(function(){
  //   save_user_progress(true);
  // }, 300000);

  $(document).on('click', '.decrypt-file', function(){
    var params = $(this).data(); 
    var url = $(this).data('decrypt-url');
    var data = {};

    swal({
      title: "Decrypt",
      text: "<textarea id='pkey' placeholder='Enter your decryption key'></textarea>",
      html: true,
      showCancelButton: true,
      closeOnConfirm: true,
      showLoaderOnConfirm: true,
      animation: "slide-from-top",
      inputPlaceholder: "Write something"
    }, function(inputValue) {
      if (inputValue === false) return false;
      if (inputValue === "") {
        swal.showInputError("You need to write something!");
        return false
      }
      // get value using textarea id
      data.key = document.getElementById('pkey').value;
      if( data.key && data.key != ""){
        $.ajax({
          method: 'GET',
          url: url,
          data: data,
          success: function(response) {
            download("data:application/octet-stream;base64," + response.file, response.filename, data.application);
            toastr.success("", "Decryption process has begun")
          },
          error: function(response) {
            swal("Error!", "Decryption process failed. Please try again!", "error");
          }
        })
      }
    });

  })

  $(document).on('click', ".file-name-holder.user-access", function(){
    filename = $(this).data('file-name');
    swal({
      title: "Encrypted!",
      text: "The file (" + filename + ") you're trying to access is encrypted.",
      imageUrl: "http://www.freeiconspng.com/uploads/encryption-icon-11.png"
    });
  })

  $(document).on('blur', ".set-password", function(){
    if($(this).val().length < 10){
      swal({
        title: "Oops!",
        text: "Password length must be minimum 10 characters",
        imageUrl: "/assets/16205-200.png"
      });
    }
  })

  // $('input[type=submit]').parent().replaceTag('p');

  $('select').on('change', function(){
    if($(this).val() == 'other'){
      if($(this).parent().find('.other-input').length == 0) {
        name = $(this).attr('name');
        $(this).prop('readonly', true).trigger("chosen:updated");
        $(this).parent().append('<input class="form-control other-input" type="text" placeholder="Please specify the other option" name="' + name + '">');
      }
    } else {
      $(this).parent().find('.other-input').remove();
    }
  })


  var american_states = [ { "id": "Alabama", "text": "Alabama" }, { "id": "Alaska", "text": "Alaska" }, { "id": "American Samoa", "text": "American Samoa" }, { "id": "Arizona", "text": "Arizona" }, { "id": "Arkansas", "text": "Arkansas" }, { "id": "California", "text": "California" }, { "id": "Colorado", "text": "Colorado" }, { "id": "Connecticut", "text": "Connecticut" }, { "id": "Delaware", "text": "Delaware" }, { "id": "District Of Columbia", "text": "District Of Columbia" }, { "id": "Federated States Of Micronesia", "text": "Federated States Of Micronesia" }, { "id": "Florida", "text": "Florida" }, { "id": "Georgia", "text": "Georgia" }, { "id": "Guam", "text": "Guam" }, { "id": "Hawaii", "text": "Hawaii" }, { "id": "Idaho", "text": "Idaho" }, { "id": "Illinois", "text": "Illinois" }, { "id": "Indiana", "text": "Indiana" }, { "id": "Iowa", "text": "Iowa" }, { "id": "Kansas", "text": "Kansas" }, { "id": "Kentucky", "text": "Kentucky" }, { "id": "Louisiana", "text": "Louisiana" }, { "id": "Maine", "text": "Maine" }, { "id": "Marshall Islands", "text": "Marshall Islands" }, { "id": "Maryland", "text": "Maryland" }, { "id": "Massachusetts", "text": "Massachusetts" }, { "id": "Michigan", "text": "Michigan" }, { "id": "Minnesota", "text": "Minnesota" }, { "id": "Mississippi", "text": "Mississippi" }, { "id": "Missouri", "text": "Missouri" }, { "id": "Montana", "text": "Montana" }, { "id": "Nebraska", "text": "Nebraska" }, { "id": "Nevada", "text": "Nevada" }, { "id": "New Hampshire", "text": "New Hampshire" }, { "id": "New Jersey", "text": "New Jersey" }, { "id": "New Mexico", "text": "New Mexico" }, { "id": "New York", "text": "New York" }, { "id": "North Carolina", "text": "North Carolina" }, { "id": "North Dakota", "text": "North Dakota" }, { "id": "Northern Mariana Islands", "text": "Northern Mariana Islands" }, { "id": "Ohio", "text": "Ohio" }, { "id": "Oklahoma", "text": "Oklahoma" }, { "id": "Oregon", "text": "Oregon" }, { "id": "Palau", "text": "Palau" }, { "id": "Pennsylvania", "text": "Pennsylvania" }, { "id": "Puerto Rico", "text": "Puerto Rico" }, { "id": "Rhode Island", "text": "Rhode Island" }, { "id": "South Carolina", "text": "South Carolina" }, { "id": "South Dakota", "text": "South Dakota" }, { "id": "Tennessee", "text": "Tennessee" }, { "id": "Texas", "text": "Texas" }, { "id": "Utah", "text": "Utah" }, { "id": "Vermont", "text": "Vermont" }, { "id": "Virgin Islands", "text": "Virgin Islands" }, { "id": "Virginia", "text": "Virginia" }, { "id": "Washington", "text": "Washington" }, { "id": "West Virginia", "text": "West Virginia" }, { "id": "Wisconsin", "text": "Wisconsin" }, { "id": "Wyoming", "text": "Wyoming" } ];
  var canadian_provinces = [ { "id": "Alberta", "text": "Alberta" }, { "id": "British Columbia", "text": "British Columbia" }, { "id": "Manitoba", "text": "Manitoba" }, { "id": "New Brunswick", "text": "New Brunswick" }, { "id": "Newfoundland and Labrador", "text": "Newfoundland and Labrador" }, { "id": "Nova Scotia", "text": "Nova Scotia" }, { "id": "Ontario", "text": "Ontario" }, { "id": "Prince Edward Island", "text": "Prince Edward Island" }, { "id": "Quebec", "text": "Quebec" }, { "id": "Saskatchewan", "text": "Saskatchewan" }, { "id": "Northwest Territories", "text": "Northwest Territories" }, { "id": "Nunavut", "text": "Nunavut" }, { "id": "Yukon", "text": "Yukon" } ];

  var customElement   = $("<div>", {
    id      : "countdown",
    css     : { "font-size" : "15px" },
    text    : 'LOADING'
  });

  if(currentUrl.indexOf("form_submissions") != -1 && currentUrl.indexOf("admin/form_submissions") == -1){
    // if ((!window.location.href.indexOf("technology_step") > -1 || !window.location.href.indexOf("history_step") > -1)){
    //   $.LoadingOverlay("hide");
    // } else {
      $.LoadingOverlay("show", { 
        color:  'rgba(255, 255, 255, 0.96)',
        custom: customElement
      });
    // }
  }

  $('.add-all-multiselect-options').on('click', function(){
    $(this).parent().find('select option').prop('selected', true).trigger('chosen:updated').trigger('change');
  })

  $('.multiselectcantfind').on('click', function(){
    $(this).parent().parent().find('.select2').hide();
    $(this).parent().parent().find('.multiselectcantfind').hide();
    $(this).parent().parent().find('.text-for-multi').removeClass('hidden').show();
  })

  if (window.location.pathname.indexOf("/pricing_step") > -1 ||
      window.location.pathname.indexOf("/conflicts_step") > -1 ||
      window.location.pathname.indexOf("/relationship_step") > -1 || 
      window.location.pathname.indexOf("/diversity_step") > -1 || 
      window.location.pathname.indexOf("/innovation_step") > -1 || 
      window.location.pathname.indexOf("/resourcing_step") > -1 || 
      window.location.pathname.indexOf("/lawfirm_step") > -1) {
    replaceChosenWithSelect2();
    $(document).on('change paste keyup', 'select, input', function(){
      replaceChosenWithSelect2();
    })
    
  }

  $('.never-chkbx').on('change', function(){
    if($(this).is(':checked')){
      $(this).parent().parent().parent().parent().parent().find('.input-wrap input').val("").attr("disabled", "disabled")
    } else {
      $(this).parent().parent().parent().parent().parent().find('.input-wrap input').val("").removeAttr("disabled", "disabled")
    }
  })

  setTimeout(function(){
    var dataDiv = $('.logics');
    
    logics = dataDiv.data('logics');
    if(logics && logics.length > 0) {
      logics_count = logics.length;
      logics.forEach(function(logic) {
        var sourceField = $('.field-wrapper-' + logic.listen_field_id)
        var targetField = $('.field-wrapper-' + logic.change_field_id)
        if(logic.repeater_field){
          targetHTML = "<a class='btn btn-primary btn-sm repeater-customlogic' href='javascript:void(0)' data-target=" + logic.change_field_id + ">Next</a>";
          sourceField.children().last().children().last().append(targetHTML);

          if(sourceField.find('.repeater-field-value').val() == 'next_btn_pressed'){
            targetField.delay(1000).show(0);
          }
        }

        targetField.hide();
        setTimeout(function(){
          sourceField.find('input[type!=hidden], select').trigger("change");
          targetField.find('input[type!=hidden], select').trigger("change");
          targetField.find('input[type=file]').trigger("change");
          sourceField.find('input[type=file]').trigger("change");
        }, 1500)
        if (!--logics_count){ 
          setTimeout(function(){ $.LoadingOverlay("hide"); }, 500) 
        }
      })
    } else {
      $.LoadingOverlay("hide");
    }

    // When the assessor has requested follow-ups then disable all fields,
    // get all the follow ups, iterate through the array
    // and enable only those fields which require attention
    
    // if(dataDiv.data('form-submission-status') == 'follow_up') {
    //   follow_ups = dataDiv.data('follow-ups');
    //   if(follow_ups.length > 0 ){
    //     disableFormSubmissionFields();
    //     setTimeout(function(){
    //       follow_ups.forEach(function(follow_up) {
    //         var target = $('.need-follow-up.field-wrapper-' + follow_up.form_field_id);
    //         target.find('input').removeAttr('disabled');
    //         target.find('select').prop('disabled', false).trigger("chosen:updated");
    //       })
    //     }, 500)
    //   }
    // }

  }, 2000)

  $(document).on('click', '.repeater-customlogic', function(){
    var sourceField = $(this);
    var targetFieldId = $(this).data('target');
    if(targetFieldId) {
      $('.field-wrapper-' + targetFieldId).show();
      sourceField.parent().parent().find('.repeater-field-value').val('next_btn_pressed');
      $('select[multiple]').chosen({
        create_option: true,
              persistent_create_option: true,
              skip_no_results: true
      });
      $('select').chosen();
    }
  })

    // setTimeout(function(){
    //   $("select, input[type='text'], input[type='email'], input[type='file'], input[type='number'], input[type='file']").trigger('change')
    // }, 2000)

  $('.j-country').trigger('change');
  $(document).on('change', '.j-country', function(){
    var j_states = $(this).parent().parent().parent().find('.j-states select')
    if ($(this).val() == 'Canada'){

      j_states.empty().append("<option value=''></option>");

      $.each(canadian_provinces, function( key, value ) {
        j_states.append("<option selected='selected' value='" + value.id + "'>" + value.text + "</option>").trigger('chosen:updated').trigger('change');
      });

      // j_states.select2().empty().select2({data: canadian_provinces})
      // $(this).parent().parent().parent().find('.j-states select option').attr('selected', true).parent().trigger('change');
    } else {
      j_states.empty().append("<option value=''></option>");

      $.each(american_states, function( key, value ) {
        j_states.append("<option selected='selected' value='" + value.id + "'>" + value.text + "</option>").trigger('chosen:updated').trigger('change');
      });
      // j_states.select2().empty().select2({data: american_states})
      // $(this).parent().parent().parent().find('.j-states select option').attr('selected', true).parent().trigger('change');
    }
  })

  function setStates(){
    var j_states = $(this).parent().parent().parent().find('.law_firm_locations_province select');
    var selected_value = j_states.data("province");
    if ($(this).val() == 'US'){

      j_states.empty().append("<option value=''></option>");

      $.each(american_states, function( key, value ) {
        j_states.append("<option " + (selected_value == value.text ? "selected='selected'" : "") +" value='" + value.id + "'>" + value.text + "</option>").trigger('chosen:updated').trigger('change');
      });


    } else {
      j_states.empty().append("<option value=''></option>");

      $.each(canadian_provinces, function( key, value ) {
        j_states.append("<option " + (selected_value == value.text ? "selected='selected'" : "") +" value='" + value.id + "'>" + value.text + "</option>").trigger('chosen:updated').trigger('change');
      });
    }
  }

  $(document).on('change', '.law_firm_locations_country select', setStates);
  $('.law_firm_locations_country select').each(setStates);

  $(".add_fields").click(function(){
    setTimeout(function(){
      $('.location-object').each(function(){
        if(!$(this).find('.law_firm_locations_province select').val()){
          $(this).find('.law_firm_locations_country select').trigger('change');
        }  
      })
    }, 100)
  })
  

  function updateJurisdicationCities(){
    
  }

  // if(window.location.href.indexOf("admin") == -1){
  //   setTimeout(function(){
  //     var $select = $('select').select2();
  //       $select.each(function(i,item){
  //         if($(item).attr('multiple') != 'multiple'){
  //           $(item).select2("destroy");
  //         }
  //       });
  //   }, 1000)
  // }

  $('.form-control').on('click', function(){
    $(this).next('input').focus();
  })

  $('i.log-icon').tooltip();

  $(document).on('click', '.file-upload-handler', function(){
    $(this).prev('.fileupload').trigger('click');

    //File Upload
    $('.fileupload').fileupload({
      dataType: 'html',
      maxNumberOfFiles: parseInt($(this).data('limit')),
      change: function(e, data){
        var uploadErrors = [];
        var file_count = data.files.length + $(this).data('file-count');
        if(file_count > 2){
          uploadErrors.push('Only 2 files are allowed at max.');
          sweetAlert("Oops...", uploadErrors.join("\n"), "error");
          return false
        }
        if(uploadErrors.length > 0) {
        }
      },
      add: function(e, data) {
        var uploadErrors = [];
        var acceptFileTypes = /^image\/(gif|jpe?g|png)$|^application\/(pdf|(vnd\.(ms-|openxmlformats-).*))$|^text\/plain$/i;;
        // var acceptFileTypes = /\.(gif|jpg|jpeg|tiff|png|mp4)$/i;
        if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
            uploadErrors.push('Not an accepted file type');
        }
        if(data.originalFiles[0]['size'] && data.originalFiles[0]['size'] > 10000000) {
            uploadErrors.push('Filesize is too big. Maximum filesize allowed is 10MB');
        }
        if(uploadErrors.length > 0) {
            sweetAlert("Oops...", uploadErrors.join("\n"), "error");
        } else {
            data.submit();
        }
      },
      done: function (e, data) {
        container = $(this);
        json_data = JSON.parse(data.result);
        container.parent().append(json_data.file_attachment_html);
        existing_file_attachement_ids = _.compact($(this).parent().parent().find('.file-ids').val().split(','));
        existing_file_attachement_ids.push(json_data.file_attachment_ids);
        $(this).parent().parent().find('.file-ids').val(existing_file_attachement_ids)
        $(this).attr('data-file-count', container.parent().find('.delete-file').length); // update count
        $(this).data('file-count', container.parent().find('.delete-file').length); // update count
        showIfCustomLogicMatched($(this), false);

        setTimeout(function(){
          container.parent().find('#progress .bar').hide();
        }, 5000)
      },
      progressall: function (e, data) {
        container = $(this);
        var progress = parseInt(data.loaded / data.total * 100, 10);
        container.parent().find('#progress .bar').css(
            'width',
            progress + '%'
        )
        .css('display', 'block')
        .text(progress + '%');
      }
    });

  })


  $(document).on('click', '.form-field-header', function(){
    $(this).next('.form-field-content').slideToggle();
    $(this).next('.form-field-content').find('select[multiple]').chosen({
      create_option: true,
              persistent_create_option: true,
              skip_no_results: true
    });
    $(this).next('.form-field-content').find('select').chosen();
    $( ".tabs" ).tabs();
  })

  $(document).on('DOMNodeInserted', function(e) {
    if($(e.target).hasClass('form-field-wrapper')){
      $(e.target).find('.form-field-content').slideToggle();
      $('.tabs').tabs();
      setTimeout(function(){
        $('html, body').animate({ 
         scrollTop: $(document).height()-$(window).height()}, 
         1400, 
         "easeOutQuint"
        );
      }, 300)
    }
  });

  $('.begin-recertification-btn').on('click', function(e){
    href  = "/admin/law_firms/" + $(this).data('id') + "/begin_recertification_process";
    swal({
      title: "Are you sure?",
      text: "",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, begin recertification!",
      cancelButtonText: "Cancel",
      closeOnConfirm: true,
      closeOnCancel: true
    },
    function(isConfirm){
      if (isConfirm) {
        $.ajax({
          method: 'GET',
          url: href,
          success: function() {
            toastr.success("", "Recertification process has begun")
            window.location.reload();
          },
          error: function(response) {}
        })
      }
    });
  })

 
  $('.send-user-info-btn').on('click', function(e){
    href  = "/admin/users/send_user_info/"+ $(this).data('id');
    swal({
      title: "Are you sure?",
      text: "",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, send user password reset link!",
      cancelButtonText: "Cancel",
      closeOnConfirm: true,
      closeOnCancel: true
    },
    function(isConfirm){
      if (isConfirm) {
        $.ajax({
          method: 'GET',
          url: href,
          success: function() {
            toastr.success("", "User info is sent")
            window.location.reload();
          },
          error: function(response) {}
        })
      }
    });
  })

  $('.begin-certification-btn').on('click', function(e){
    href  = "/admin/law_firms/" + $(this).data('id') + "/begin_certification_process";
    swal({
      title: "Are you sure?",
      text: "",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, begin certification!",
      cancelButtonText: "Cancel",
      closeOnConfirm: true,
      closeOnCancel: true
    },
    function(isConfirm){
      if (isConfirm) {
        $.ajax({
          method: 'GET',
          url: href,
          success: function() {
            toastr.success("", "Certification process has begun")
            window.location.reload();
          },
          error: function(response) {}
        })
      }
    });
  })

  $('.send-user-info-begin-certification-btn').on('click', function(e){
    href  = "/admin/users/send_user_info_with_certification/"+ $(this).data('id');
    swal({
      title: "Are you sure?",
      text: "",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, send User info with RFI!",
      cancelButtonText: "Cancel",
      closeOnConfirm: true,
      closeOnCancel: true
    },
    function(isConfirm){
      if (isConfirm) {
        $.ajax({
          method: 'GET',
          url: href,
          success: function() {
            toastr.success("", "User info is sent with RFI")
            window.location.reload();
          },
          error: function(response) {}
        })
      }
    });
  })

  $(document).on('click', ".delete_file", function(e){
    e.preventDefault();
    href = $(this).attr('href');
    container = $(this);
    swal({
      title: "Are you sure?",
      text: "",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, delete it!",
      cancelButtonText: "No, don't delete!",
      closeOnConfirm: true,
      closeOnCancel: true
    },
    function(isConfirm){
      if (isConfirm) {
        $.ajax({
          method: 'DELETE',
          url: href,
          success: function(file_id) {
            file_upload = container.parent().parent().parent().find('.fileupload');
            file_upload.attr('data-file-count', $("#delete_file-" + file_id).parent().find('.delete-file').length - 1); // update count
            file_upload.data('file-count', $("#delete_file-" + file_id).parent().find('.delete-file').length - 1); // update count
            $("#delete_file-" + file_id).remove();
            file_upload.parent().find('.file-ids').val(_.without(file_upload.parent().find('.file-ids').val().split(','), file_id.toString()));
            showIfCustomLogicMatched(file_upload, false);
          },
          error: function(response) {
          }
        })
      }
    });
  });


  //File upload ends

  $( function() {
    $( "#accordion" ).accordion({
      collapsible: true, active: false, header: "h4",
      icons: { "header": "fa fa-plus", "activeHeader": "fa fa-minus" }
    });

    $( ".tabs" ).tabs();
  } );

  $('.form_submission_form_values_value input, .form_submission_form_values_value select, .form_submission_form_values_value textarea, .fileupload').each(function(){
     prepareForCustomLogic($(this));
  })

  $(".add_more_options").click(function(e){
    e.preventDefault();
    html = $(this).data("association-insertion-template");
    $(this).parent().prepend(html);
  })
  // $('*[data-role=activerecord_sortable]').activerecord_sortable();

  // $('select').select2();
  $("select.message_question").chosen({create_option: true, max_selected_options: 1})
  $('select').chosen({
    disable_search_threshold: 5,
    no_results_text: "Oops, nothing found!"
  });

  $('form#message-form').submit(function(e) {
    e.preventDefault()
    var values = $(this).serializeArray()
    var data = {}
    values.forEach(function(elem) {
      data[elem.name] = elem.value
    })
    $.ajax({
      method: 'POST',
      url: '/admin/messages',
      data: data,
      success: function(response) {
        $('form#message-form')[0].reset()
        var message = $('form#message-form .alert.alert-success')
        message.removeClass('hidden')
        message.show()
        setTimeout(function() {
          message.hide()
        }, 4000)
      },
      complete: function(response) {

      }
    })
  })

  $('.form_form_fields_custom_logic').on('click', initializeCustomLogic);

  $("input.datepicker").each(function(input) {
    $(this).datepicker({
      dateFormat: "dd M yy",
      altField: $(this).next()
    })
  })


  $('body').on('focus',".restrict-till-day", function(){
      $(this).datepicker({
        maxDate: 0,
        dateFormat: "dd M yy"
      });
  });


  $(document).on('click', '.add-css, .add-information-security-policy', function() {
    var classesToActOn = ".cyber-security, .information-security-policy"
    $(classesToActOn).find('.datepicker').datepicker({
      dateFormat: "dd-mm-yy",
      altField: $(this).next()
    })

    // If you use i18n-js you can set the locale like that
    // $(this).datepicker("option", $.datepicker.regional['en']);
  })

  $('.form_form_fields_custom_logic').each(initializeCustomLogic);
  
  $("select").on("change", function(){
    showIfCustomLogicMatched($(this), false);
  });

  $("input[type='text'], input[type='email'], input[type='file'], input[type='number'], input[type='file']")
    .on("change paste keyup", function(){
      showIfCustomLogicMatched($(this), false);
  });

  var ajaxRequestInProcess = false;
  $('.submit-form').click(function(e){
    e.preventDefault();

    $("form").attr("action", $("form").attr("action") + "?previous=true");

    window.skipUnload = true;
    $(this).find('.loader').removeClass('hidden');
    window.link_to_redirect_to = $(this).attr('href');
    if(!ajaxRequestInProcess){
      $('#redirect_value').val(window.link_to_redirect_to);
      ajaxRequestInProcess = true;
      $('form').submit();
      $('.submit-form').attr("disabled", "disabled");
    }
  })

  $("form").bind("ajax:success", function(e, response){
    $('.last-update-timestamp').html(response.last_updated);
    $('.submit-form').find('.loader').addClass('hidden');
    setTimeout(function(){ ajaxRequestInProcess = false; $('.submit-form').removeAttr("disabled"); }, 2000)
    toastr.success('Your progress has been saved successfully', 'Saved');
    link = window.link_to_redirect_to;
    if(link == window.location.pathname){
      if ((window.location.href.indexOf("conflicts_step") > -1)) {
        window.location.reload();
      }
    } else{ 
      window.location.href = link;
    }
  })
    .bind("ajax:failure", function(response){
      setTimeout(function(){ 
        ajaxRequestInProcess = false; 
        $('.submit-form').removeAttr("disabled"); 
      }, 2000)
      toastr.error('Failed to save the form. Please try again.', 'Error');
    })

    $('.submit-tech-form').click(function(e){
    e.preventDefault();

    $(this).find('.loader').removeClass('hidden');
    window.link_to_redirect_to = $(this).attr('href');
    if(!ajaxRequestInProcess){
      ajaxRequestInProcess = true;
      $('form').submit();
      $('.submit-tech-form').attr("disabled", "disabled");
    }
  })

  // $("form").bind("ajax:success", function(response){
  //   $('.submit-tech-form').find('.loader').addClass('hidden');
  //   toastr.success('Your progress has been saved successfully', 'Saved');
  //   setTimeout(function(){ ajaxRequestInProcess = false; $('.submit-form').removeAttr("disabled"); }, 2000)
  //   window.location.reload();
  // })

  $(document).on('DOMNodeInserted', function(e) {
    if($(e.target).hasClass('select-fields')){
      $(e.target).find('.dynamic-select').first().trigger('change');
    }
  });



  $(document).on('change', '.threat-lf-dynamic-select', function(e) {
    if(e.target.value != ""){
      field = $(this).data('field');
      
      if (field == 'vendor'){
        vendor = $(this).val();
        target = $(this).parent().parent().next('div.platform-wrapper').find('select');
        fetchLawFirms(vendor, null, null, target)
        fetchTechnology(vendor, null, null, target, null, null)
      } else if (field == 'platform'){
        vendor = $(this).parent().parent().prev('.vendor-wrapper').find('select').val();
        platform = $(this).val();
        target = $(this).parent().parent().next('div.version-wrapper').find('select');
        fetchLawFirms(vendor, platform, null, target)
        fetchTechnology(vendor, platform, null, target, null, null)
      } else if (field == 'version') {
        vendor = $(this).parent().parent().prev('.vendor-wrapper').find('select').val();
        platform = $(this).parent().parent().prev('.platform-wrapper').find('select').val();
        version = $(this).val();
        target = $(this).parent().parent().next('div.service_pack-wrapper').find('select');
        fetchLawFirms(vendor, platform, version, target);
        fetchTechnology(vendor, platform, version, target, null, null)
      }

      platform = $(this).data('platform');
      version = $(this).data('version');
    }
  })

  $('body').on('click', '.tech-form-wraper .add_fields', function(){
    fields = $(this);
    setTimeout(function(){
      fields.parent().prev('div').prev('div').find('div.platform-wrapper select, .service_pack-wrapper select, div.version-wrapper select').prop('disabled', true).trigger("chosen:updated");
    }, 100)
  })

  $(document).on('change', '.dynamic-select', function() {
    field = $(this).data('field');

    platform_category = $(this).parent().parent().parent().children('.hidden').first().find('input').val();
    platform_type = $(this).parent().parent().parent().children('.hidden').last().find('input').val()
    
    if (field == 'vendor'){
      vendor = $(this).val();
      target = $(this).parent().parent().next('div.platform-wrapper').find('select');
      
      if(vendor != ""){
        fetchTechnology(vendor, null, null, target, platform_type, platform_category)
        target.removeAttr('disabled')
      }
    } else if (field == 'platform'){
      vendor = $(this).parent().parent().prev('.vendor-wrapper').find('select').val();
      platform = $(this).val();
      target = $(this).parent().parent().next('div.version-wrapper').find('select');
      
      if(vendor != "" && platform != ""){
        fetchTechnology(vendor, platform, null, target, platform_type, platform_category)
        target.removeAttr('disabled')
      }
    } else if (field == 'version') {
      vendor = $(this).parent().parent().prev('.vendor-wrapper').find('select').val();
      platform = $(this).parent().parent().prev('.platform-wrapper').find('select').val();
      version = $(this).val();
      target = $(this).parent().parent().next('div.service_pack-wrapper').find('select');
      
      if(vendor != "" && platform != "" && version != ""){
        fetchTechnology(vendor, platform, version, target, platform_type, platform_category);
        target.removeAttr('disabled')
      }
    }

    platform = $(this).data('platform');
    version = $(this).data('version');
  })

  hideTextFields();

  $(document).on( 'click','a.turn-to-text', function () {
    var textFields = $(this).parent().parent().prev('.text-only-fields');
    $(this).parent().parent().remove();

    vendor_val = $(this).parent().children().find('select').val()
    platform_val = $(this).parent().parent().children('.platform-wrapper').find('select').val()
    version_val = $(this).parent().parent().children('.version-wrapper').find('select').val()
    service_pack_val = $(this).parent().parent().children('.service_pack-wrapper').find('select').val()
    supported_val = $(this).parent().parent().children('.supported-wrapper').find('select').val()

    textFields.find('.vendor-wrapper input').val(vendor_val ? vendor_val : "NA");
    textFields.find('.platform-wrapper input').val(platform_val ? platform_val : "NA");
    textFields.find('.version-wrapper input').val(version_val ? version_val : "NA");
    textFields.find('.service_pack-wrapper input').val(service_pack_val ? service_pack_val : "NA");
    textFields.find('.supported-wrapper select').val(supported_val ? supported_val : "Yes").trigger("chosen:updated");
  
    textFields.removeClass('hidden').show();
    
  });


  if(window.location.pathname.indexOf("/admin/form_submissions/") > -1 ){
    disableFormSubmissionFields();
    if(!$('body').hasClass('minified')){
      setTimeout(function(){ $('.minifyme').trigger('click') }, 500)
    }
  }

  if(window.location.pathname.indexOf("/form_submissions/") > -1 ){
    if($('form.simple_form.edit_form_submission').attr('disabled') == 'disabled'){
      disableFormSubmissionFields();
    }
  }

  if(window.location.href.indexOf("readonly=true") > -1){
    disableFormSubmissionFields();
  }

  $('.send-wrapper').click(function(){
    $('#notes-form').submit();  
  })

  $('#notes-form').on('submit', function(e){
    e.preventDefault();
    $.ajax({
      url: "/admin/notes",
      method: 'post',
      data: $(this).serialize()
    })
      .done(function( data ) {
        $('#notes-modal .notes').append('<div class="message">' + data.message + '<p>' + data.created_at + '</p></div>');
      });
  })

  $('.follow-up').each(function() {
    $(this).qtip({
      content: {
        title: 'Add Note',
        text: $(this).parent().parent().children('.note-box'),
        button: 'Close'
      },
      show: {
        event: 'click'
      },
      hide: {
          event: false
      },
      position: {
        my: 'bottom right'
      },
      style: {
        width: 1000,
        classes: 'qtip-blue qtip-shadow'
      }
    });
  });

  $('.threat-warning').each(function() {
    if($(this).hasClass('threat-found')){
      $(this).qtip({
        content: {
          title: 'Security threat(s) found.',
          text: $(this).attr("class").replace('btn btn-xs threat-warning threat-found ', '').replace('waves-effect waves-light', '').replace(/-/g, ' ')
        }
      });
    }
  });

  $('.history-qtip').qtip({
    content: {
      text: "<p>*Significant : An attempt or risk that that wasn’t automatically prevented with the security systems in place such as firewalls, intrusion detection systems, Policies and controls but needed attention and/or intervention.</p><p>**Incident: An adverse event in an information systems – includes the significant threat of an adverse event (implies harm or the attempt to harm)</p><p>*** Data Loss : Where one or more electronic files were potentially or known to have been copied, printed, viewed, altered or compromised in any other way.</p>"
    }
  });

  $('.help-text').each(function() {
    var data = $(this).data().help;
    $(this).qtip({
      content: {
        title: 'Tip!',
        text: data,
      },
      position: {
        my: 'top left'
      },
      style: { classes: 'helper-data-color' }
    });
  });

  $('.add-note').on('click', function(e){
    e.preventDefault();
    var data;

    if( _.isEmpty($(this).data()) ){
      data = $(this).find('input').data();
    } else {
      data = $(this).data();
    }
    var field_wrapper_id = data.field_wrapper_id;
    message = $(this).parent().parent().find('textarea.note').val();
    data.message = message;

    if(!message || message == "")
      return
    $.ajax({
      url: "/follow_ups",
      method: 'post',
      async: false,
      data: data,
      context: $(this).parent().parent().parent(),
      success: function(response) {
        $(this).find('div.note').prepend(response)
        window.location.reload();
      }
    })
    wrapper = $('.field-wrapper-' + field_wrapper_id);
    if(wrapper.hasClass('need-follow-up')){
      wrapper.removeClass('need-follow-up');
    }
  })
  $('.add-note-admin').on('click', function(e){
    e.preventDefault();
    var data;

    if( _.isEmpty($(this).data()) ){
      data = $(this).find('input').data();
    } else {
      data = $(this).data();
    }
    var field_wrapper_id = data.field_wrapper_id;
    message = $(this).parent().parent().find('textarea.note').val();
    data.message = message;

    if(!message || message == "")
      return
    $.ajax({
      url: "/admin/follow_ups",
      method: 'post',
      async: false,
      data: data,
      context: $(this).parent().parent().parent(),
      success: function(response) {
        $(this).find('div.note').prepend(response)
        window.location.reload();
      }
    })
    wrapper = $('.field-wrapper-' + field_wrapper_id);
    if(wrapper.hasClass('need-follow-up')){
      wrapper.removeClass('need-follow-up');
    }
  })

  $('.resolve-btn').on('click', function(e){
    e.preventDefault();
    var data = $(this).find('input').data();
    $.ajax({
      url: "/admin/follow_ups/resolve",
      method: 'post',
      data: data,
      context: $(this).parent()
    })
      .done(function( data ) {
        $(this).children('.resolve-btn').val('Resolved').attr('disabled', 'true')
        // https://github.com/johnpapa/toastr-bower
        $(this).parent().parent().parent().find('.qtip-close').trigger('click');
        toastr.success('The follow up has been marked as resolved', 'Resolved');
      });
  })

  $(document).on('click', 'a.check-field-value', function(e){
    e.preventDefault();
    $.ajax({
      url: "/admin/form_submissions/mark_as_checked",
      method: 'post',
      data: $(this).data(),
      context: $(this).parent()
    })
      .done(function( data ) {
        $(this).html(data);
      });
  })

  $('a.finalize-submission').on('click', function(e){
    e.preventDefault();

    var data = $(this).data();
    swal({
      title: "Are you sure?",
      text: "",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, submit it!",
      cancelButtonText: "No, don't submit!",
      closeOnConfirm: true,
      closeOnCancel: true
    },
    function(isConfirm){
      if (isConfirm) {
        $.ajax({
          url: "/form_submissions/" + data.form_id + "/submit_forms",
          method: 'get'
        })
        .done(function( data ) {
          window.location.href = '/';
        });
      }
    });

    
  })


  $('a.finalize-submission-lawfirm').on('click', function(e){
    e.preventDefault();

    var data = $(this).data();
    swal({
      title: "Are you sure?",
      text: "",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, submit it!",
      cancelButtonText: "No, don't submit!",
      closeOnConfirm: true,
      closeOnCancel: true
    },
    function(isConfirm){
      if (isConfirm) {
        $('.rfi_lawfirm .rfi-lawfirm-btn').trigger("click")
      }
    });

    
  })

  $('.delete-security-alert').on('click', function(e){
    e.preventDefault();
    var id = $(this).data('id');

    swal({
      title: "Are you sure?",
      text: "",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, delete this security alert!",
      cancelButtonText: "Cancel",
      closeOnConfirm: true,
      closeOnCancel: true
    },
    function(isConfirm){
      if (isConfirm) {
        $.ajax({
          url: "/admin/security_alerts/" + id,
          method: 'POST',
          async: false,
          data: {"_method":"delete"},
          complete: function(response) {
            window.location.reload();
          }
        })
      }
    });

    
  })

  // initialize sortable
  $(function() {
    $("#sortable1, #sortable2").sortable({
      handle : '.handle',
      connectWith : ".todo",
      update : countTasks
    }).disableSelection();
  });

  // check and uncheck
  $('.todo .checkbox > input[type="checkbox"]').click(function() {
    var $this = $(this).parent().parent().parent();

    if ($(this).prop('checked')) {

      var data = $(this).data();
      var checkbox = $(this);
      swal({
        title: "Are you sure you've completed this task?",
        text: "You won't be able to make any changes later on.",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Yes, submit it!",
        cancelButtonText: "No, don't submit!",
        closeOnConfirm: true,
        closeOnCancel: true
      },
      function(isConfirm){
        if (isConfirm) {
          $.ajax({
            method: 'POST',
            url: '/action_items/mark_as_complete',
            data: data,
            context: $(this).parent(),
            success: function(response) {
              $this.addClass("complete");
              $(this).parent().hide();
              $this.slideUp(500, function() {
                $this.clone().prependTo("#sortable3").effect("highlight", {}, 800);
                $this.remove();
                countTasks();
              });
              // window.location.href = response.redirect_url;
            }
          })
        } else {
          checkbox.trigger('click');
        }
      });

    }

  })

  function replaceChosenWithSelect2(){
    $('select[multiple]').chosen({
      create_option: true,
      persistent_create_option: true,
      skip_no_results: true
    });
    $('select').chosen();
  }

  function disableFormSubmissionFields(){
    $('select').attr('disabled', 'true');
    $('select').prop('disabled', true).trigger("chosen:updated");
    $('input[type="text"]').attr('disabled', 'true');
    $('input[type="number"]').attr('disabled', 'true');
    $('input[type="email"]').attr('disabled', 'true');
    $('textarea').attr('disabled', 'true');
    $('.score-form input').removeAttr('disabled');
    $('#notes-modal .input > div textarea').removeAttr('disabled');
    $('textarea.note').removeAttr('disabled');
    $('.wrapper .btn').attr('disabled', 'true');
    $('.wrapper .delete_file').hide();
    $('.wrapper .remove_fields').hide();
  }

  // count tasks
  function countTasks() {

    $('.todo-group-title').each(function() {
      var $this = $(this);
      $this.find(".num-of-tasks").text($this.next().find("li").size());
    });

  }


  $('.decertify-btn').on('click', function(){

    var context = $(this).parent();
    var data = $(this).data();

    swal({
      title: "Decertify " + data.name,
      text: "Please specify a reason to decertify",
      type: "input",
      showCancelButton: true,
      closeOnConfirm: true,
      animation: "slide-from-top",
      inputPlaceholder: ""
    },
    function(inputValue){
      if (inputValue === false) return false;
      
      if (inputValue === "") {
        swal.showInputError("You need to write something!");
        return false
      }

      data.reason = inputValue;
      
      $.ajax({
        method: 'POST',
        url: '/admin/law_firms/decertify',
        data: data,
        context: context,
        success: function(response) {
          window.location.reload();
        }
      })
    });
  })


  $('.certify-btn').on('click', function(){

    var context = $(this).parent();
    var data = $(this).data();

    swal({
      title: "Are you sure?",
      text: "Clicking yes will trigger the recertification process for " + data.name,
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes",
      closeOnConfirm: true
    },
    function(){
      $.ajax({
        method: 'GET',
        url: '/admin/law_firms/' + data.id + '/begin_recertification_process',
        data: data,
        context: context,
        success: function(response) {
          window.location.reload();
        }
      })
    });
  })

  $('#internal-note-form').on('submit', function(e){
    e.preventDefault();
    var data = $(this).serialize();
    var context = $(this).parent();
    
    $.ajax({
      method: 'POST',
      url: '/admin/law_firms/add_internal_note',
      data: data,
      context: context,
      success: function(response) {
        $(this).find('textarea').val('');
        $('ul.internal-notes').prepend(response)
      }
    })
  })

  $(document).on('click', '.remove-internal-note', function(){
    var data = $(this).data();
    var context = $(this).parent().parent();

    swal({
      title: "Are you sure?",
      text: "",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, delete note!",
      cancelButtonText: "Cancel",
      closeOnConfirm: true,
      closeOnCancel: true
    },
    function(isConfirm){
      if (isConfirm) {
        $.ajax({
          method: 'POST',
          url: '/admin/law_firms/remove_internal_note',
          data: data,
          context: context,
          success: function(response) {
            $(context).hide();
          }
        })
      }
    });
    
    
  })

  function score_rating(){
    $('.score-rating').rateYo({
      halfStar: true,
      rating: 5,
      onChange: function (rating, rateYoInstance) {
        
        $(this).attr("data-original-title", rating).tooltip('show');
        $(this).data('bs.tooltip').options.placement = 'right';


        $('.score-rating').click(function(){
          $(this).parent().children().find('.score-holder').val(rating)
          // $(this).parent().children('.form_form_fields_dropdown_options_score').children('.score-holder').val(rating);
        })
      },
      onInit: function (rating, rateYoInstance) {
        rating = parseFloat($(this).next().children('input').val())
        $(this).rateYo("rating", rating);
        $("#rateYo").rateYo("option", "multiColor", { "startColor": $(this).data('color'), "endColor": $(this).data('color') });
      }
    });
  }

  score_rating();

    
  $(document).on('click', '#links a.add_fields', function(){
    score_rating();
  })
  $(document).on('click', 'a.add_fields', function(){
    $("select.message_question").chosen({create_option: true, max_selected_options: 1})
    $('select[multiple]').chosen({
      create_option: true,
      persistent_create_option: true,
      skip_no_results: true
    });
    $('select').chosen();
  })

  $('.average-score-rating').rateYo({
    halfStar: true,
    rating: 0,
    multiColor: {
      "startColor": "#FF0000",
      "endColor"  : "#369e36"
    },
    onChange: function (rating, rateYoInstance) {
      var data = $(this).data();
      data.score = rating;
      $('.average-score-rating').click(function(){
        update_assessor_score(data);
      })
    },
    onInit: function (rating, rateYoInstance) {
      $(this).rateYo("rating", $(this).data().assessor_score)
      if($(this).data().readonly){
        $(this).rateYo("readonly", readonly);
      }
    }
  });

  init_rating('.total-score, .readonly-system-score, .readonly-assessor-score-rating, .readonly-responsiveness-score-rating, .readonly-total-score-rating, .system-score')
  // $('.readonly-system-score, .readonly-assessor-score-rating, .readonly-responsiveness-score-rating, .readonly-total-score-rating').rateYo({
  //   rating: 0,
  //   precision: 1,
  //   multiColor: {
  //     "startColor": "#FF0000",
  //     "endColor"  : "#369e36"
  //   },
  //   onInit: function (rating, rateYoInstance) {
  //     rating = $(this).data().score;
  //     $(this).rateYo("rating", rating);
  //     $(this).rateYo("option", "readOnly", true);
  //   }
  // })

  // $('.system-score').rateYo({
  //   rating: 0,
  //   precision: 1,
  //   multiColor: {
  //     "startColor": "#FF0000",
  //     "endColor"  : "#369e36"
  //   },
  //   onInit: function (rating, rateYoInstance) {
  //     rating = $(this).data().score;
  //     $(this).rateYo("rating", rating);
  //   }
  // });

  // $('.total-score').rateYo({
  //   rating: 0,
  //   precision: 1,
  //   multiColor: {
  //     "startColor": "#FF0000",
  //     "endColor"  : "#369e36"
  //   },
  //   onInit: function (rating, rateYoInstance) {
  //     rating = $(this).data().score;
  //     $(this).rateYo("rating", rating);
  //     $(this).rateYo("option", "readOnly", true);
  //   }
  // });

  $('.system-score-threshold').rateYo({
    rating: 0,
    precision: 1,
    multiColor: {
      "startColor": "#FF0000",
      "endColor"  : "#369e36"
    },
    onChange: function(rating, instance){

      $('.system-score-threshold').click(function(){

        swal({
          title: "Are you sure?",
          text: "",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: "#DD6B55",
          confirmButtonText: "Yes, change threshold",
          cancelButtonText: "Cancel",
          closeOnConfirm: true,
          closeOnCancel: true
        },
        function(isConfirm){
          if (isConfirm) {
            $.ajax({
              method: 'PATCH',
              url: '/admin/system_settings/0',
              data: {
                system_setting: {
                  score_threshold: rating 
                }
              },
              context: $(this),
              success: function(response) {
                toastr.success("", "The system score threshold has been updated.")
              }
            })
          }
        });
        
      })


      $(this).attr("data-original-title", rating).tooltip('show');
      $(this).data('bs.tooltip').options.placement = 'right';
      
      $('.system-score-threshold').click(function(){
        $(this).parent().children('.system_setting_score_threshold').children('input').val(rating);
      })
    },
    onInit: function (rating, rateYoInstance) {
      rating = $(this).data().threshold_score;
      $(this).rateYo("rating", rating);
    }
  });

  $('.severity-level').change(function(){
    // var data = {};
    // data.id = $(this).val();

    // $.ajax({
    //   method: 'GET',
    //   url: '/admin/security_threats/' + data.id + '/severity_negative_factors_for_triggers',
    //   data: data,
    //   success: function(response) {
    //     $('.snf').html(response)
    //   }
    // })
  })

  $('.search-query').on('change', function(){
    var data = $(this).val();
    // if(data.length > 2){
      $.ajax({
        method: 'GET',
        url: '/admin/internal_dashboard/search_activity_logs?query=' + data,
        success: function(response) {
          $('.smart-timeline-list').html(response)
        }
      })
    // }
  })
  


});

var ajaxReqestSent = false;

function setSsoType() {
  var sso_type = $('#tenant_sso_type').val();
  switch(sso_type) {
    case "okta":
      $('.okta_fields').show();
      $('.azure_fields').hide();
      break;
    case "azure_active_directory":
      $('.okta_fields').hide();
      $('.azure_fields').show();
      break;
    default:
      $('.okta_fields').hide();
      $('.azure_fields').hide()
  }
}

function init_rating(handler){
  $(handler).rateYo({
    rating: 0,
    precision: 1,
    onInit: function (rating, rateYoInstance) {
      rating = parseFloat($(this).data().score);
      $(this).rateYo("rating", rating);
      $(this).rateYo("option", "readOnly", true);
      $(this).rateYo("option", "multiColor", { "startColor": $(this).data('color'), "endColor": $(this).data('color') });
    }
  });
}

function update_assessor_score(data){
  if(!ajaxReqestSent){
    $.ajax({
      method: 'POST',
      url: '/admin/form_submissions/update_assessor_score',
      data: data,
      beforeSend: function(){
        ajaxReqestSent = true;
      },
      success: function(response) {
        ajaxReqestSent = false;
        toastr.success("", "Score Updated");
        window.location.reload();
        // TODO: if total score is below threshold, disable approval
        // if(response.total_score){
        //   $('.approve-btn').attr("disabled", "disabled")
        // }
      }
    })
  }
}

function hideTextFields(){
  setTimeout(function(){
    $('.text-only-fields').hide();
  }, 100)
}

function fetchTechnology(vendor, platform, version, target, platform_type, platform_category){
  data = {
    field: target.data('field'),
    filter: {
      vendor: vendor,
      platform: platform,
      version: version,
      platform_category: platform_category,
      platform_type: platform_type
    }
  }

  $.get('/technologies', data, function(response){
    html = "";
    // $(target).select2().empty().select2({data: response}).trigger('change');

    $(target).empty().append("<option value=''></option>");
    if (response.length > 0){
      $.each(response, function( index, value ) {
        $(target).append("<option value='" + value.id + "'>" + value.text + "</option>").trigger('chosen:updated').trigger('change');
      });
    }
    // $(target).select2({data: response}).trigger('change');
    // response.forEach(function(value){
      // html += '<option value="' + value + '">' + value + "</option>";
    // })
    // target.html(html);
    // $(target).select2();
  })

}

function fetchTechnologyForThreats(vendor, platform, version, target){
  data = {
    field: target.data('field'),
    filter: {
      vendor: vendor,
      platform: platform,
      version: version,
    }
  }
  $.get('/technologies', data, function(response){
    $(target).select2().empty().select2({data: response}).trigger('change');
  })

}

function fetchLawFirms(vendor, platform, version, target){
  data = {
    field: target.data('field'),
    filter: {
      vendor: vendor,
      platform: platform,
      version: version,
    }
  }
  $.get('/admin/security_threats/0/find_law_firms', data, function(response){

    if (response.selected.length > 0){
      $('#law-firms').empty().append("<option value=''></option>");
      $.each(response.selected, function( index, value ) {
        $("#law-firms").append("<option selected='selected' value='" + value.id + "'>" + value.text + "</option>").trigger('chosen:updated').trigger('change');
      });
    }
    if (response.all.length > 0){
      $.each(response.all, function( index, value ) {
        $("#law-firms").append("<option value='" + value.id + "'>" + value.text + "</option>").trigger('chosen:updated').trigger('change');
      });
    }

    // $('#law-firms').select2().empty().select2({data: response.selected});
    // $('#law-firms option').attr('selected', true).parent().trigger('change');
    // $('#law-firms').select2({data: response.all});
    // $('#law-firms-count').html(response.selected.length + " Firm(s) found")

    if(response.selected.length > 0){
      $('.clear-all-lawfirms').show();
    }
  })
}

$('.add-all-lawfirms').on('click', function(e){
  e.preventDefault();
  $('#law-firms option').attr('selected', true).trigger('change');
  $('.clear-all-lawfirms').show();
})
$('.clear-all-lawfirms').hide();
$('.clear-all-lawfirms').on('click', function(e){
  e.preventDefault();
  $('#law-firms option').attr('selected', false).parent().trigger('change');
  $('.clear-all-lawfirms').hide();
})

function initializeCustomLogic(){
  if($(this).find('input:checked').length > 0){
    $(this).siblings('.form_form_fields_show_when_form_field_id').show();
    $(this).siblings('.form_form_fields_show_when_form_field_value').show();
  }else{
    $(this).siblings('.form_form_fields_show_when_form_field_id').hide();
    $(this).siblings('.form_form_fields_show_when_form_field_value').hide();
  }
}

function showIfCustomLogicMatched(currentField, pageLoad){
  logics = $('.logics').data('logics');
  currentFieldId = currentField.parent().parent().siblings('.form_submission_form_values_form_field_id').find('input').val() || currentField.data('form-field-id');
  // currentFieldLogics = logics;
  currentFieldLogics = _.where(logics, { listen_field_id: parseInt(currentFieldId) })
  
  if( currentFieldLogics.length > 0 ) {
    currentFieldLogics.forEach(function(logic) {

      targetField = $('.field-wrapper-' + logic.change_field_id)

      if( (currentField.val() && currentField.val() == logic.values && currentField.val().length != 0) 
           || (logic.values == "" && currentField.val() && currentField.val().length > 0)
           || (currentField.hasClass('fileupload') && parseInt(currentField.data('file-count')) > 0)
        ){
        switch(logic.perform_action){
          case 'show':
            targetField.show();
            // targetField.find("select").select2();
            targetField.find("select[multiple]").chosen({
              create_option: true,
              persistent_create_option: true,
              skip_no_results: true
            });
            targetField.find("select").chosen();
            break;
          case 'hide':
            targetField.hide();
            // if(!pageLoad){
            //   targetField.find("select").val('').trigger('change');
            //   targetField.find("input[type!=hidden]").val('').trigger('change');
            // }
            break;
        }
      } else {
        switch(logic.perform_action){
          case 'show':
            targetField.hide();
            // if(!pageLoad){
            //   targetField.find("select").val('').trigger('change');
            //   targetField.find("input[type!=hidden]").val('').trigger('change');
            // }
            break;
          case 'hide':
            targetField.show();
            targetField.find("select[multiple]").chosen({
              create_option: true,
              persistent_create_option: true,
              skip_no_results: true
            });
            targetField.find("select").chosen();
            // if(!pageLoad){
            //   targetField.find("input[type!=hidden]").val('').trigger('change');
            // }
            break;
        }
      }

    })
  }
}

function prepareForCustomLogic(currentField){
  showIfCustomLogicMatched(currentField, true);
}

$(document).ready(function(){
  if($("#chartContainer").length > 0){

    var chart = new CanvasJS.Chart("chartContainer",
      {
        title:{
          text: "Law Firms Compliance/Risk Analysis",      
          fontFamily: '"Roboto",Arial,Helvetica,Sans-Serif',
          fontColor: "DarkSlateGrey"
        },
        animationEnabled: true,
        axisX: {
          title:"Risk",
          titleFontFamily: '"Roboto",Arial,Helvetica,Sans-Serif'
        },
        axisY:{
          title: "Compliance",
          titleFontFamily: '"Roboto",Arial,Helvetica,Sans-Serif',
          valueFormatString:"0",
          titleFontSize: 12
        },

        data: [
        {        
          type: "scatter",  
          toolTipContent: "<span style='\"'color: {color};'\"'><strong>{name}</strong></span> <br/> <strong>Compliance</strong> {y} <br/> <strong>Risk</strong> {x} ",
          dataPoints: [

          { y: 4,   x: 1070,name:"Preszler Law Firm" },
          { y: 4.1, x: 2275,name:"Niren & Associates Immigration Law Firm" },
          { y: 4.2, x: 1265,name:"E&A Law Firm - Toronto Family Law Attorney" },
          { y: 3.9, x: 755,name:"Shulman Law Firm" },
          { y: 4.5, x: 1800,name:"Kahler Personal Injury Law Firm" },
          { y: 4,   x: 545,name:"Worsoff Law Firm" },    
          { y: 4,   x: 1245,name:"Borders Law Firm Immigration Lawyers" },
          { y: 3.8, x: 1221,name:"Wires Law" },
          { y: 2.1, x: 801,name:"The Law Firm of Ted Yoannou" },
          { y: 2.5, x: 435,name:"Kruse Law" }
          ]
        }
        ]
      });
      chart.render();
    }
})



$('.law-firm-row').on('click', function(){
  window.location.href = "/admin/law_firms/" + $(this).data().id;
})

$('.rfp-row').on('click', function(){
  window.location.href = "/admin/rfps/" + $(this).data().id;
})

$('.lob-rfp-row').on('click', function(){
  window.location.href = "/lob/rfps/" + $(this).data().id;
})

$('.proposal-row').on('click', function(){
  window.location.href = $(this).data().url;
})

$(document).on('click', '#load-more-activities', function(){
  var data = $(this).data();
  context = $(this).parent();
  $.ajax({
    method: 'GET',
    url: '/admin/internal_dashboard/load_more_activities',
    data: data,
    context: context,
    success: function(response) {
      if(response == ""){
        $('#load-more-activities').hide();
      } else {
        $('#load-more-activities').remove();
        $('ul.smart-timeline-list').append(response)
      }
    }
  })
})

$(document).on('click', '.fa-eye-slash', function() {
    var input = $("#user_password");
    if (input.attr("type") === "password") {
      $(".fa-eye").show();
      $(".fa-eye-slash").hide();
      input.attr("type", "text");
    }
  });

$(document).on('click', '.fa-eye', function() {
    var input = $("#user_password");
    if (input.attr("type") === "text") {
      $(".fa-eye").hide();
      $(".fa-eye-slash").show();
      input.attr("type", "password");
    }
  });
$(document).on('change', '#rfp_invites', function() {
    values = $('#rfp_invites').val();
    if(values != null){
      if(values.includes('select_all') == true){
        $('#rfp_invites option').prop('selected', true)
        $("#rfp_invites option[value='select_all']").prop('selected', false).trigger("chosen:updated");
      }
    }
    setRfpAvailableLawyerOptions($('#rfp_invites').val())
  });

// $('#search-activity-log-btn').on('click', function(e){
//   e.preventDefault();
//   $("#search_activity_log").submit();
// })

// $("#search-activity-log").find("input[type=text], select").on('change', function(e){
//   // $('#search-activity-log-btn').trigger('click');
//   e.preventDefault();
//   $("#search_activity_log").submit();
// })

$('#reset-activity-log-btn').on('click', function(e){
  $("#search-activity-log").find("input[type=text], textarea").val("");
  $("#search-activity-log").find("select").val("All");
  $("#search-activity-log").find("select").select2();
  $("#search-activity-log").submit();
  e.preventDefault();
})

$('#reset-matter-filter-btn').on('click', function(e){
  $("#matter_intake_search").find("#q_matter_description_cont").val("");
  $("#matter_intake_search").find("#q_invoices_status_cont").val("");
  $("#matter_intake_search").find("#q_invoices_status_cont").val("");
  $("#matter_intake_search").find("#q_budget_amount_lt_any").val("");
  $("#matter_intake_search").find("#q_line_of_business_id_eq").val('').trigger("chosen:updated")
  $("#matter_intake_search").find("#q_law_firm_id_eq").val('').trigger("chosen:updated")
  e.preventDefault();
})

$("#search-activity-log").find("input[type=text], select").on('change keyup paste', function(e){
  e.preventDefault();
  $.ajax({
    method: 'GET',
    url: '/admin/internal_dashboard/search_activity_logs',
    data: $("#search-activity-log").serialize(),
    success: function(response) {
      if(response != ""){
        $('ul.smart-timeline-list').html(response);
      } else {
        toastr.info("Your search query didn't yield any results");
      }
    }
  })
})


$('#extend-expiry-form').hide();
$('.extend-expiry').on('click', function(){
  $('#extend-expiry-form').toggle();
})

$('#extend-expiry-form').on('submit', function(e){
  e.preventDefault();
  var data = $(this).serialize();
  swal({
    title: "Are you sure?",
    text: "",
    type: "warning",
    showCancelButton: true,
    confirmButtonColor: "#DD6B55",
    confirmButtonText: "Yes, change expiry date",
    cancelButtonText: "Cancel",
    closeOnConfirm: true,
    closeOnCancel: true
  },
  function(isConfirm){
    if (isConfirm) {
      $.ajax({
        method: 'POST',
        url: '/admin/form_submissions/set_expiry_date',
        data: data,
        context: $(this),
        success: function(response) {
          window.location.reload();
        }
      })
    }
  });

})

$(document).on('change', '#lawfirm_tenants', function(){
  var subdomain = $(this).val();
  $.ajax({
    method: 'POST',
    url: '/tenants/switch',
    data: { subdomain: subdomain },
    dataType: 'json',
    context: $(this),
    success: function(response) {
      if (response && response.url) {
        window.location.replace(response.url);
      }
    },
    error: function() {
      alert("An error occurred!")
    }
  })
});

$(document.body).on('change', '.file.optional.ajax_file_upload', function(element){
  $($(this).parents('.uploadFile')).find('.loader').show();
  const formData = new FormData();
  formData.append("inovie[file]", element.target.files[0]);
  $.ajax({
    url: "/matter_intakes/verify_doc",
    type: "POST",
    beforeSend(xhr, options) {
      options.data = formData;
      return true;
    },
    success: response => {
      if(date = response['resource']['date'] != null && response['resource']['total'] != null){
        date = response['resource']['date'].split(' ')[0]
        message = "Total: "+response['resource']['total'] +'\nDate: '+date

        if (confirm(message) == true) {
          $($(this).parents('.nested-fields')).find('.matter_intake_invoices_amount input').val(response['resource']['total']);
          $($(this).parents('.nested-fields')).find('.invoice_datepicker').val(date);
          $($(this).parents('.nested-fields')).find('.hidden.veryfi_response').val(response['resource']);
        }
      }
      $($(this).parents('.uploadFile')).find('.loader').hide();
    },
    error: () => {
      $($(this).parents('.uploadFile')).find('.loader').hide();
    }
  });
});

function trigger_file_input(obj){
  $(obj).next().find('input').trigger('click');
}

function show_file_name(e){
  var geekss = $(e).val().replace(/.*(\/|\\)/, '');
  $(e).parents('.uploadFile').find('.file_name').text(geekss);
}


$('body').on('focus',".invoice_datepicker", function(){
  $(this).datepicker({
    dateFormat: "yy-mm-dd",
    altField: $(this).next()
  });
});

$('body').on('focus',".rfp_datepicker", function(){
  $(this).datetimepicker({
    format:'d M Y H:m'
  });
});

$('#matter_intake_law_firm_id').on('change', function() {
  setAvailableLawyerOptions(this.value)
})

$('#matter_intake_law_firm_id').on('change', function() {
  setAvailableLawyerOptions(this.value)
})

$('#matter-security-form').on('click', function() {
  $('#matter-back-button').trigger('click');
})

function setAvailableLawyerOptions(law_firm_id) {
  $.ajax({
    url: "/law_firms/get_external_lawyers?id=" + law_firm_id,
    method: "get",
  })
    .done(( response ) => {
      $('#matter_intake_lawyer_ids').empty();
      var options = "";
      if (response.users) {
        $.each(response.users, function(index, user) {
          options += "<option value='" + user.id + "'>" + user.name + "</option>";
        })
        $('#matter_intake_lawyer_ids').html(options);
        $("#matter_intake_lawyer_ids").trigger("chosen:updated")
      }
    })
    .fail((error) => {
      $('#matter_intake_lawyer_ids').empty();
      var options = "<option value=''> Select option</option>";
    })
}

function setRfpAvailableLawyerOptions(law_firm_ids) {
  $.ajax({
    url: "/law_firms/get_external_lawyers?id=" + law_firm_ids,
    method: "get",
  })
  .done(( response ) => {
    $('#rfp_matter_intake_attributes_lawyer_ids').empty();
    var options = "";
    if (response.users) {
      $.each(response.users, function(index, user) {
        options += "<option value='" + user.id + "'>" + user.name + "</option>";
      })
      $('#rfp_matter_intake_attributes_lawyer_ids').html(options);
      $("#rfp_matter_intake_attributes_lawyer_ids").trigger("chosen:updated")
    }
  })
  .fail((error) => {
    $('#rfp_matter_intake_attributes_lawyer_ids').empty();
    var options = "<option value=''> Select option</option>";
  })
}

$("#login-form").submit(function(e){
  if($('#accept').is(':checked') == false){
    $("#login-form .btn-type-primary").prop("disabled", false);
    window.alert("Please accept Terms & Conditions");
    e.preventDefault(e);
  }
});
$("#login-form #accept").on('click', function(e){
  $("#login-form .btn-type-primary").prop("disabled", false);
});

$(document).ready(function(){
  law_firm = $("#matter_intake_law_firm_id option:selected").text();
  if(law_firm != ''){
    existing_text = 'Assigned Lawyer'
    $("label.matter_intake_lawyer_ids").text(existing_text+" ("+law_firm+")")
  }
})

$('#matter_intake_law_firm_id').on('change', function(){
  existing_text = 'Assigned Lawyer'
  if($(this).val() == ''){
    $("label.matter_intake_lawyer_ids").text(existing_text)
  } else {
    law_firm = $("#matter_intake_law_firm_id option:selected").text();
    $("label.matter_intake_lawyer_ids").text(existing_text+" ("+law_firm+")")
  }
})

$("#add_lawyer_matter").on('click', function(e){
  $(".matter_intake_lawyer_first_name input").toggle();
  $(".matter_intake_lawyer_last_name input").toggle();
  $(".matter_intake_lawyer_email input").toggle();
  $(".matter_intake_lawyer_email.has-error").toggle();
  $(".matter_intake_lawyer_first_name.has-error").toggle();
  $(".matter_intake_lawyer_last_name.has-error").toggle();
});

$(function() {
    $.fn.size = function() {
        return this.length;
    }
});

// var _rollbarConfig = {
//     accessToken: "721164f0eda644f686c3e844ec50ab74",
//     captureUncaught: true,
//     captureUnhandledRejections: true,
//    payload: {
//        environment: "production"
//    }
// };// // Rollbar Snippe// !function(r){function e(n){if(o[n])return o[n].exports;var t=o[n]={exports:{},id:n,loaded:!1};return r[n].call(t.exports,t,t.exports,e),t.loaded=!0,t.exports}var o={};return e.m=r,e.c=o,e.p="",e(0)}([function(r,e,o){"use strict";var n=o(1).Rollbar,t=o(2);_rollbarConfig.rollbarJsUrl=_rollbarConfig.rollbarJsUrl||"https://cdnjs.cloudflare.com/ajax/libs/rollbar.js/1.9.4/rollbar.min.js";var a=n.init(window,_rollbarConfig),i=t(a,_rollbarConfig);a.loadFull(window,document,!_rollbarConfig.async,_rollbarConfig,i)},function(r,e){"use strict";function o(r){return function(){try{return r.apply(this,arguments)}catch(r){try{console.error("[Rollbar]: Internal error",r)}catch(r){}}}}function n(r,e,o){window._rollbarWrappedError&&(o[4]||(o[4]=window._rollbarWrappedError),o[5]||(o[5]=window._rollbarWrappedError._rollbarContext),window._rollbarWrappedError=null),r.uncaughtError.apply(r,o),e&&e.apply(window,o)}function t(r){var e=function(){var e=Array.prototype.slice.call(arguments,0);n(r,r._rollbarOldOnError,e)};return e.belongsToShim=!0,e}function a(r){this.shimId=+c,this.notifier=null,this.parentShim=r,this._rollbarOldOnError=null}function i(r){var e=a;return o(function(){if(this.notifier)return this.notifier[r].apply(this.notifier,arguments);var o=this,n="scope"===r;n&&(o=new e(this));var t=Array.prototype.slice.call(arguments,0),a={shim:o,method:r,args:t,ts:new Date};return window._rollbarShimQueue.push(a),n?o:void 0})}function l(r,e){if(e.hasOwnProperty&&e.hasOwnProperty("addEventListener")){var o=e.addEventListener;e.addEventListener=function(e,n,t){o.call(this,e,r.wrap(n),t)};var n=e.removeEventListener;e.removeEventListener=function(r,e,o){n.call(this,r,e&&e._wrapped?e._wrapped:e,o)}}}var c=0;a.init=function(r,e){var n=e.globalAlias||"Rollbar";if("object"==typeof r[n])return r[n];r._rollbarShimQueue=[],r._rollbarWrappedError=null,e=e||{};var i=new a;return o(function(){if(i.configure(e),e.captureUncaught){i._rollbarOldOnError=r.onerror,r.onerror=t(i);var o,a,c="EventTarget,Window,Node,ApplicationCache,AudioTrackList,ChannelMergerNode,CryptoOperation,EventSource,FileReader,HTMLUnknownElement,IDBDatabase,IDBRequest,IDBTransaction,KeyOperation,MediaController,MessagePort,ModalWindow,Notification,SVGElementInstance,Screen,TextTrack,TextTrackCue,TextTrackList,WebSocket,WebSocketWorker,Worker,XMLHttpRequest,XMLHttpRequestEventTarget,XMLHttpRequestUpload".split(",");for(o=0;o<c.length;++o)a=c[o],r[a]&&r[a].prototype&&l(i,r[a].prototype)}return e.captureUnhandledRejections&&(i._unhandledRejectionHandler=function(r){var e=r.reason,o=r.promise,n=r.detail;!e&&n&&(e=n.reason,o=n.promise),i.unhandledRejection(e,o)},r.addEventListener("unhandledrejection",i._unhandledRejectionHandler)),r[n]=i,i})()},a.prototype.loadFull=function(r,e,n,t,a){var i=function(){var e;if(void 0===r._rollbarPayloadQueue){var o,n,t,i;for(e=new Error("rollbar.js did not load");o=r._rollbarShimQueue.shift();)for(t=o.args,i=0;i<t.length;++i)if(n=t[i],"function"==typeof n){n(e);break}}"function"==typeof a&&a(e)},l=!1,c=e.createElement("script"),p=e.getElementsByTagName("script")[0],s=p.parentNode;c.crossOrigin="",c.src=t.rollbarJsUrl,c.async=!n,c.onload=c.onreadystatechange=o(function(){if(!(l||this.readyState&&"loaded"!==this.readyState&&"complete"!==this.readyState)){c.onload=c.onreadystatechange=null;try{s.removeChild(c)}catch(r){}l=!0,i()}}),s.insertBefore(c,p)},a.prototype.wrap=function(r,e){try{var o;if(o="function"==typeof e?e:function(){return e||{}},"function"!=typeof r)return r;if(r._isWrap)return r;if(!r._wrapped){r._wrapped=function(){try{return r.apply(this,arguments)}catch(e){throw"string"==typeof e&&(e=new String(e)),e._rollbarContext=o()||{},e._rollbarContext._wrappedSource=r.toString(),window._rollbarWrappedError=e,e}},r._wrapped._isWrap=!0;for(var n in r)r.hasOwnProperty(n)&&(r._wrapped[n]=r[n])}return r._wrapped}catch(e){return r}};for(var p="log,debug,info,warn,warning,error,critical,global,configure,scope,uncaughtError,unhandledRejection".split(","),s=0;s<p.length;++s)a.prototype[p[s]]=i(p[s]);r.exports={Rollbar:a,_rollbarWindowOnError:n}},function(r,e){"use strict";r.exports=function(r,e){return function(o){if(!o&&!window._rollbarInitialized){var n=window.RollbarNotifier,t=e||{},a=t.globalAlias||"Rollbar",i=window.Rollbar.init(t,r);i._processShimQueue(window._rollbarShimQueue||[]),window[a]=i,window._rollbarInitialized=!0,n.processPayloads()}}}}]);
// // End Rollbar Snippet
