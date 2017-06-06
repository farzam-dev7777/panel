$(document).ready(function(){
  // $("*[data-custom-logic='true']").each(function(){
  //   prepareForCustomLogic($(this).find('.form_submission_form_values_value input, .form_submission_form_values_value select'));
  // });
  
  // $('.dynamic-select').trigger('change');


  (function( $ ) {
    $.fn.replaceTag = function(newTag) {
      var originalElement = this[0]
      , originalTag = originalElement.tagName
      , startRX = new RegExp('^<'+originalTag, 'i')
      , endRX = new RegExp(originalTag+'>$', 'i')
      , startSubst = '<'+newTag
      , endSubst = newTag+'>'
      , newHTML = originalElement.outerHTML
      .replace(startRX, startSubst)
      .replace(endRX, endSubst);
      this.replaceWith(newHTML);
    };
  })(jQuery);
  // $('input[type=submit]').parent().replaceTag('p');
  
  var currentUrl = window.location.href;

  var american_states = [ { "id": "Alabama", "text": "Alabama" }, { "id": "Alaska", "text": "Alaska" }, { "id": "American Samoa", "text": "American Samoa" }, { "id": "Arizona", "text": "Arizona" }, { "id": "Arkansas", "text": "Arkansas" }, { "id": "California", "text": "California" }, { "id": "Colorado", "text": "Colorado" }, { "id": "Connecticut", "text": "Connecticut" }, { "id": "Delaware", "text": "Delaware" }, { "id": "District Of Columbia", "text": "District Of Columbia" }, { "id": "Federated States Of Micronesia", "text": "Federated States Of Micronesia" }, { "id": "Florida", "text": "Florida" }, { "id": "Georgia", "text": "Georgia" }, { "id": "Guam", "text": "Guam" }, { "id": "Hawaii", "text": "Hawaii" }, { "id": "Idaho", "text": "Idaho" }, { "id": "Illinois", "text": "Illinois" }, { "id": "Indiana", "text": "Indiana" }, { "id": "Iowa", "text": "Iowa" }, { "id": "Kansas", "text": "Kansas" }, { "id": "Kentucky", "text": "Kentucky" }, { "id": "Louisiana", "text": "Louisiana" }, { "id": "Maine", "text": "Maine" }, { "id": "Marshall Islands", "text": "Marshall Islands" }, { "id": "Maryland", "text": "Maryland" }, { "id": "Massachusetts", "text": "Massachusetts" }, { "id": "Michigan", "text": "Michigan" }, { "id": "Minnesota", "text": "Minnesota" }, { "id": "Mississippi", "text": "Mississippi" }, { "id": "Missouri", "text": "Missouri" }, { "id": "Montana", "text": "Montana" }, { "id": "Nebraska", "text": "Nebraska" }, { "id": "Nevada", "text": "Nevada" }, { "id": "New Hampshire", "text": "New Hampshire" }, { "id": "New Jersey", "text": "New Jersey" }, { "id": "New Mexico", "text": "New Mexico" }, { "id": "New York", "text": "New York" }, { "id": "North Carolina", "text": "North Carolina" }, { "id": "North Dakota", "text": "North Dakota" }, { "id": "Northern Mariana Islands", "text": "Northern Mariana Islands" }, { "id": "Ohio", "text": "Ohio" }, { "id": "Oklahoma", "text": "Oklahoma" }, { "id": "Oregon", "text": "Oregon" }, { "id": "Palau", "text": "Palau" }, { "id": "Pennsylvania", "text": "Pennsylvania" }, { "id": "Puerto Rico", "text": "Puerto Rico" }, { "id": "Rhode Island", "text": "Rhode Island" }, { "id": "South Carolina", "text": "South Carolina" }, { "id": "South Dakota", "text": "South Dakota" }, { "id": "Tennessee", "text": "Tennessee" }, { "id": "Texas", "text": "Texas" }, { "id": "Utah", "text": "Utah" }, { "id": "Vermont", "text": "Vermont" }, { "id": "Virgin Islands", "text": "Virgin Islands" }, { "id": "Virginia", "text": "Virginia" }, { "id": "Washington", "text": "Washington" }, { "id": "West Virginia", "text": "West Virginia" }, { "id": "Wisconsin", "text": "Wisconsin" }, { "id": "Wyoming", "text": "Wyoming" } ];
  var canadian_provinces = [ { "id": "Alberta", "text": "Alberta" }, { "id": "British Columbia", "text": "British Columbia" }, { "id": "Manitoba", "text": "Manitoba" }, { "id": "New Brunswick", "text": "New Brunswick" }, { "id": "Newfoundland and Labrador", "text": "Newfoundland and Labrador" }, { "id": "Nova Scotia", "text": "Nova Scotia" }, { "id": "Ontario", "text": "Ontario" }, { "id": "Prince Edward Island", "text": "Prince Edward Island" }, { "id": "Quebec", "text": "Quebec" }, { "id": "Saskatchewan", "text": "Saskatchewan" }, { "id": "Northwest Territories", "text": "Northwest Territories" }, { "id": "Nunavut", "text": "Nunavut" }, { "id": "Yukon", "text": "Yukon" } ];

  var customElement   = $("<div>", {
    id      : "countdown",
    css     : { "font-size" : "15px" },
    text    : 'LOADING'
  });

  if(currentUrl.indexOf("form_submissions") != -1 && currentUrl.indexOf("admin/form_submissions") == -1){
    $.LoadingOverlay("show", { 
      color:  'rgba(255, 255, 255, 0.96)',
      custom: customElement
    });
  }

  $('.add-all-multiselect-options').on('click', function(){
    $(this).parent().find('select option').prop('selected', true).trigger('chosen:updated').trigger('change');
  })

  $('.multiselectcantfind').on('click', function(){
    $(this).parent().parent().find('.select2').hide();
    $(this).parent().parent().find('.multiselectcantfind').hide();
    $(this).parent().parent().find('.text-for-multi').removeClass('hidden').show();
  })

  if (window.location.pathname.indexOf("/policy_step") > -1 ||
      window.location.pathname.indexOf("/process_step") > -1 || 
      window.location.pathname.indexOf("/technology_step") > -1 || 
      window.location.pathname.indexOf("/history_step") > -1) {
    replaceChosenWithSelect2();
    $(document).on('change paste keyup', 'select, input', function(){
      replaceChosenWithSelect2();
    })
    
  }

  $('.never-chkbx').on('change', function(){
    if($(this).is(':checked')){
      $(this).parent().parent().find('.input-wrap input').val("").attr("disabled", "disabled")
    } else {
      $(this).parent().parent().find('.input-wrap input').val("").removeAttr("disabled", "disabled")
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

        // targetField.hide();
        setTimeout(function(){
          sourceField.find('input[type!=hidden], select').trigger("change");
          targetField.find('input[type!=hidden], select').trigger("change");
        }, 500)
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
    if(dataDiv.data('form-submission-status') == 'follow_up') {
      follow_ups = dataDiv.data('follow-ups');
      if(follow_ups.length > 0 ){
        disableFormSubmissionFields();
        setTimeout(function(){
          follow_ups.forEach(function(follow_up) {
            var target = $('.need-follow-up.field-wrapper-' + follow_up.form_field_id);
            target.find('input').removeAttr('disabled');
            target.find('select').prop('disabled', false).trigger("chosen:updated");
          })
        }, 500)
      }
    }

  }, 2000)

  $(document).on('click', '.repeater-customlogic', function(){
    var sourceField = $(this);
    var targetFieldId = $(this).data('target');
    if(targetFieldId) {
      $('.field-wrapper-' + targetFieldId).show();
      sourceField.parent().parent().find('.repeater-field-value').val('next_btn_pressed');
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
  $('*[data-role=activerecord_sortable]').activerecord_sortable();

  // $('select').select2();
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

    // If you use i18n-js you can set the locale like that
    // $(this).datepicker("option", $.datepicker.regional['en']);
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
    
    $(this).find('.loader').removeClass('hidden');
    window.link_to_redirect_to = $(this).attr('href');
    if(!ajaxRequestInProcess){
      $('#redirect_value').val(window.link_to_redirect_to);
      ajaxRequestInProcess = true;
      $('form').submit();
      $('.submit-form').attr("disabled", "disabled");
    }
  })

  $("form").bind("ajax:success", function(response){
    $('.submit-form').find('.loader').addClass('hidden');
    setTimeout(function(){ ajaxRequestInProcess = false; $('.submit-form').removeAttr("disabled"); }, 2000)
    toastr.success('Your progress has been saved successfully', 'Saved');
    link = window.link_to_redirect_to;
    if(link == window.location.pathname){
      window.location.reload();
    } else{ 
      window.location.href = link;
    }
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



  $(document).on('change', '.threat-lf-dynamic-select', function() {
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
  })

  $(document).on('change', '.dynamic-select', function() {
    field = $(this).data('field');

    platform_category = $(this).parent().parent().parent().children('.hidden').first().find('input').val();
    platform_type = $(this).parent().parent().parent().children('.hidden').last().find('input').val()
    
    if (field == 'vendor'){
      vendor = $(this).val();
      target = $(this).parent().parent().next('div.platform-wrapper').find('select');
      fetchTechnology(vendor, null, null, target, platform_type, platform_category)
    } else if (field == 'platform'){
      vendor = $(this).parent().parent().prev('.vendor-wrapper').find('select').val();
      platform = $(this).val();
      target = $(this).parent().parent().next('div.version-wrapper').find('select');
      fetchTechnology(vendor, platform, null, target, platform_type, platform_category)
    } else if (field == 'version') {
      vendor = $(this).parent().parent().prev('.vendor-wrapper').find('select').val();
      platform = $(this).parent().parent().prev('.platform-wrapper').find('select').val();
      version = $(this).val();
      target = $(this).parent().parent().next('div.service_pack-wrapper').find('select');
      fetchTechnology(vendor, platform, version, target, platform_type, platform_category);
    }

    platform = $(this).data('platform');
    version = $(this).data('version');
  })

  hideTextFields();

  $(document).on( 'click','a.turn-to-text', function () {
    var textFields = $(this).parent().parent().prev('.text-only-fields');
    $(this).parent().parent().remove();

    textFields.find('.vendor-wrapper input').val($(this).parent().children().find('select').val());
    textFields.find('.platform-wrapper input').val($(this).parent().parent().children('.platform-wrapper').find('select').val());
    textFields.find('.version-wrapper input').val($(this).parent().parent().children('.version-wrapper').find('select').val());
    textFields.find('.service_pack-wrapper input').val($(this).parent().parent().children('.service_pack-wrapper').find('select').val());
    textFields.find('.supported-wrapper select').val($(this).parent().parent().children('.supported-wrapper').find('select').val());
  
    textFields.removeClass('hidden').show();
    
  });


  if(window.location.pathname.indexOf("/admin/form_submissions/") > -1 ){
    disableFormSubmissionFields();
    if(!$('body').hasClass('minified')){
      setTimeout(function(){ $('.minifyme').trigger('click') }, 500)
    }
  }

  if(window.location.pathname.indexOf("/form_submissions/?readonly=true") > -1){
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

  $('.help-text').each(function() {
    var data = $(this).data().help;
    $(this).qtip({
      content: {
        title: 'Tip!',
        text: data,
      },
      position: {
        my: 'bottom left'
      }
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
        toastr.success('The follow up has been marked as resolved', 'Resolved')
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
              window.location.href = response.redirect_url;
            }
          })
        } else {
          checkbox.trigger('click');
        }
      });

    }

  })

  function replaceChosenWithSelect2(){
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
        toastr.success("", "Score Updated")
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

// var _rollbarConfig = {
//     accessToken: "721164f0eda644f686c3e844ec50ab74",
//     captureUncaught: true,
//     captureUnhandledRejections: true,
//     payload: {
//         environment: "production"
//     }
// };
// // Rollbar Snippet
// !function(r){function e(n){if(o[n])return o[n].exports;var t=o[n]={exports:{},id:n,loaded:!1};return r[n].call(t.exports,t,t.exports,e),t.loaded=!0,t.exports}var o={};return e.m=r,e.c=o,e.p="",e(0)}([function(r,e,o){"use strict";var n=o(1).Rollbar,t=o(2);_rollbarConfig.rollbarJsUrl=_rollbarConfig.rollbarJsUrl||"https://cdnjs.cloudflare.com/ajax/libs/rollbar.js/1.9.4/rollbar.min.js";var a=n.init(window,_rollbarConfig),i=t(a,_rollbarConfig);a.loadFull(window,document,!_rollbarConfig.async,_rollbarConfig,i)},function(r,e){"use strict";function o(r){return function(){try{return r.apply(this,arguments)}catch(r){try{console.error("[Rollbar]: Internal error",r)}catch(r){}}}}function n(r,e,o){window._rollbarWrappedError&&(o[4]||(o[4]=window._rollbarWrappedError),o[5]||(o[5]=window._rollbarWrappedError._rollbarContext),window._rollbarWrappedError=null),r.uncaughtError.apply(r,o),e&&e.apply(window,o)}function t(r){var e=function(){var e=Array.prototype.slice.call(arguments,0);n(r,r._rollbarOldOnError,e)};return e.belongsToShim=!0,e}function a(r){this.shimId=++c,this.notifier=null,this.parentShim=r,this._rollbarOldOnError=null}function i(r){var e=a;return o(function(){if(this.notifier)return this.notifier[r].apply(this.notifier,arguments);var o=this,n="scope"===r;n&&(o=new e(this));var t=Array.prototype.slice.call(arguments,0),a={shim:o,method:r,args:t,ts:new Date};return window._rollbarShimQueue.push(a),n?o:void 0})}function l(r,e){if(e.hasOwnProperty&&e.hasOwnProperty("addEventListener")){var o=e.addEventListener;e.addEventListener=function(e,n,t){o.call(this,e,r.wrap(n),t)};var n=e.removeEventListener;e.removeEventListener=function(r,e,o){n.call(this,r,e&&e._wrapped?e._wrapped:e,o)}}}var c=0;a.init=function(r,e){var n=e.globalAlias||"Rollbar";if("object"==typeof r[n])return r[n];r._rollbarShimQueue=[],r._rollbarWrappedError=null,e=e||{};var i=new a;return o(function(){if(i.configure(e),e.captureUncaught){i._rollbarOldOnError=r.onerror,r.onerror=t(i);var o,a,c="EventTarget,Window,Node,ApplicationCache,AudioTrackList,ChannelMergerNode,CryptoOperation,EventSource,FileReader,HTMLUnknownElement,IDBDatabase,IDBRequest,IDBTransaction,KeyOperation,MediaController,MessagePort,ModalWindow,Notification,SVGElementInstance,Screen,TextTrack,TextTrackCue,TextTrackList,WebSocket,WebSocketWorker,Worker,XMLHttpRequest,XMLHttpRequestEventTarget,XMLHttpRequestUpload".split(",");for(o=0;o<c.length;++o)a=c[o],r[a]&&r[a].prototype&&l(i,r[a].prototype)}return e.captureUnhandledRejections&&(i._unhandledRejectionHandler=function(r){var e=r.reason,o=r.promise,n=r.detail;!e&&n&&(e=n.reason,o=n.promise),i.unhandledRejection(e,o)},r.addEventListener("unhandledrejection",i._unhandledRejectionHandler)),r[n]=i,i})()},a.prototype.loadFull=function(r,e,n,t,a){var i=function(){var e;if(void 0===r._rollbarPayloadQueue){var o,n,t,i;for(e=new Error("rollbar.js did not load");o=r._rollbarShimQueue.shift();)for(t=o.args,i=0;i<t.length;++i)if(n=t[i],"function"==typeof n){n(e);break}}"function"==typeof a&&a(e)},l=!1,c=e.createElement("script"),p=e.getElementsByTagName("script")[0],s=p.parentNode;c.crossOrigin="",c.src=t.rollbarJsUrl,c.async=!n,c.onload=c.onreadystatechange=o(function(){if(!(l||this.readyState&&"loaded"!==this.readyState&&"complete"!==this.readyState)){c.onload=c.onreadystatechange=null;try{s.removeChild(c)}catch(r){}l=!0,i()}}),s.insertBefore(c,p)},a.prototype.wrap=function(r,e){try{var o;if(o="function"==typeof e?e:function(){return e||{}},"function"!=typeof r)return r;if(r._isWrap)return r;if(!r._wrapped){r._wrapped=function(){try{return r.apply(this,arguments)}catch(e){throw"string"==typeof e&&(e=new String(e)),e._rollbarContext=o()||{},e._rollbarContext._wrappedSource=r.toString(),window._rollbarWrappedError=e,e}},r._wrapped._isWrap=!0;for(var n in r)r.hasOwnProperty(n)&&(r._wrapped[n]=r[n])}return r._wrapped}catch(e){return r}};for(var p="log,debug,info,warn,warning,error,critical,global,configure,scope,uncaughtError,unhandledRejection".split(","),s=0;s<p.length;++s)a.prototype[p[s]]=i(p[s]);r.exports={Rollbar:a,_rollbarWindowOnError:n}},function(r,e){"use strict";r.exports=function(r,e){return function(o){if(!o&&!window._rollbarInitialized){var n=window.RollbarNotifier,t=e||{},a=t.globalAlias||"Rollbar",i=window.Rollbar.init(t,r);i._processShimQueue(window._rollbarShimQueue||[]),window[a]=i,window._rollbarInitialized=!0,n.processPayloads()}}}}]);
// // End Rollbar Snippet

