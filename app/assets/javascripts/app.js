$(document).ready(function(){
  // $("*[data-custom-logic='true']").each(function(){
  //   prepareForCustomLogic($(this).find('.form_submission_form_values_value input, .form_submission_form_values_value select'));
  // });
  
  // $('.dynamic-select').trigger('change');
  $('i.log-icon').tooltip();

  $('.fileupload').next('.file-upload-handler').on('click', function(){ $(this).prev('.fileupload').trigger('click') })

  //File Upload
  $('.fileupload').fileupload({
    dataType: 'html',
    done: function (e, data) {
      container = $(this);
      container.parent().append(data.result);
      $(this).attr('data-file-count', container.parent().find('p').length); // update count
      $(this).data('file-count', container.parent().find('p').length); // update count
      showIfCustomLogicMatched($(this), false);
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


  $(document).on('click', '.form-field-header', function(){
    $(this).next('.form-field-content').slideToggle();
    $(this).next('.form-field-content').find('select').select2();
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
            file_upload = container.parent().parent().find('.fileupload');
            file_upload.attr('data-file-count', $("#delete_file-" + file_id).parent().find('p').length - 1); // update count
            file_upload.data('file-count', $("#delete_file-" + file_id).parent().find('p').length - 1); // update count
            $("#delete_file-" + file_id).remove();
            showIfCustomLogicMatched(file_upload, false);
          },
          error: function(response) {
            debugger;
          }
        })
      }
    });
  });


  //File upload ends

  $( function() {
    $( "#accordion" ).accordion();
    $( ".tabs" ).tabs();
    // $( ".accordion" ).accordion({
    //   heightStyle: "content",
    //   collapsible: true,
    // });
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

  $('select').select2();

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

  $('.submit-form').click(function(e){
    e.preventDefault();
    $(this).find('.loader').removeClass('hidden');
    window.link_to_redirect_to = $(this).attr('href');
    $('form').submit();
  })

  $("form").bind("ajax:success", function(response){
    $('.submit-form').find('.loader').addClass('hidden');
    link = window.link_to_redirect_to;
    window.location.href = link;
  })

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
      fetchTechnology(vendor, null, null, target)
    } else if (field == 'platform'){
      vendor = $(this).parent().parent().prev('.vendor-wrapper').find('select').val();
      platform = $(this).val();
      target = $(this).parent().parent().next('div.version-wrapper').find('select');
      fetchLawFirms(vendor, platform, null, target)
      fetchTechnology(vendor, platform, null, target)
    } else if (field == 'version') {
      vendor = $(this).parent().parent().prev('.vendor-wrapper').find('select').val();
      platform = $(this).parent().parent().prev('.platform-wrapper').find('select').val();
      version = $(this).val();
      target = $(this).parent().parent().next('div.service_pack-wrapper').find('select');
      fetchLawFirms(vendor, platform, version, target);
      fetchTechnology(vendor, platform, version, target)
    }

    platform = $(this).data('platform');
    version = $(this).data('version');
  })

  $(document).on('change', '.dynamic-select', function() {
    field = $(this).data('field');
    
    if (field == 'vendor'){
      vendor = $(this).val();
      target = $(this).parent().parent().next('div.platform-wrapper').find('select');
      fetchTechnology(vendor, null, null, target)
    } else if (field == 'platform'){
      vendor = $(this).parent().parent().prev('.vendor-wrapper').find('select').val();
      platform = $(this).val();
      target = $(this).parent().parent().next('div.version-wrapper').find('select');
      fetchTechnology(vendor, platform, null, target)
    } else if (field == 'version') {
      vendor = $(this).parent().parent().prev('.vendor-wrapper').find('select').val();
      platform = $(this).parent().parent().prev('.platform-wrapper').find('select').val();
      version = $(this).val();
      target = $(this).parent().parent().next('div.service_pack-wrapper').find('select');
      fetchTechnology(vendor, platform, version, target);
    }

    platform = $(this).data('platform');
    version = $(this).data('version');
  })

  hideTextFields();

  $(document).on( 'click','a.turn-to-text', function () {
    $(this).parent().parent().prev('.text-only-fields').removeClass('hidden').show();
    $(this).parent().parent().remove();
  });


  if(window.location.pathname.indexOf("/admin/form_submissions/") > -1){
    $('select').attr('disabled', 'true');
    $('input[type="text"]').attr('disabled', 'true');
    $('input[type="number"]').attr('disabled', 'true');
    $('textarea').attr('disabled', 'true');
    $('.score-form input').removeAttr('disabled');
    $('#notes-modal .input > div textarea').removeAttr('disabled');
    $('textarea.note').removeAttr('disabled');
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

  $('.add-note').on('click', function(e){
    e.preventDefault();

    data = $(this).data();
    message = $(this).parent().parent().find('textarea.note').val();
    data.message = message;
    $.ajax({
      url: "/admin/follow_ups",
      method: 'post',
      data: data,
      context: $(this).parent().parent().parent()
    })
      .done(function( data ) {
        $(this).find('div.note').prepend(data)

      });
  })

  $('.resolve-btn').on('click', function(e){
    e.preventDefault();
    $.ajax({
      url: "/admin/follow_ups/resolve",
      method: 'post',
      data: $(this).data(),
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
            }
          })
        } else {
          checkbox.trigger('click');
        }
      });

    }

  })
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
        $('ul.internal-notes').prepend(response)
      }
    })
  })

  function score_rating(){
    $('.score-rating').rateYo({
      halfStar: true,
      rating: 5,
      multiColor: {
        "startColor": "#FF0000", //RED
        "endColor"  : "#369e36"  //GREEN
      },
      onChange: function (rating, rateYoInstance) {
        
        $(this).attr("data-original-title", rating).tooltip('show');
        $(this).data('bs.tooltip').options.placement = 'right';


        $('.score-rating').click(function(){
          $(this).parent().children('.form_form_fields_dropdown_options_score').children('.score-holder').val(rating);
        })
      },
      onInit: function (rating, rateYoInstance) {
        rating = parseFloat($(this).next().children('input').val())
        $(this).rateYo("rating", rating);
      }
    });
  }

  score_rating();

  $(document).on('click', '#links a.add_fields', function(){
    score_rating();

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

  $('.system-score').rateYo({
    rating: 0,
    precision: 1,
    multiColor: {
      "startColor": "#FF0000",
      "endColor"  : "#369e36"
    },
    onInit: function (rating, rateYoInstance) {
      rating = $(this).data().score;
      $(this).rateYo("rating", rating);
    }
  });

  $('.total-score').rateYo({
    rating: 0,
    precision: 1,
    multiColor: {
      "startColor": "#FF0000",
      "endColor"  : "#369e36"
    },
    onInit: function (rating, rateYoInstance) {
      rating = $(this).data().score;
      $(this).rateYo("rating", rating);
    }
  });

  $('.system-score-threshold').rateYo({
    rating: 0,
    precision: 1,
    multiColor: {
      "startColor": "#FF0000",
      "endColor"  : "#369e36"
    },
    onChange: function(rating, instance){
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
    var data = {};
    data.id = $(this).val();

    $.ajax({
      method: 'GET',
      url: '/admin/security_threats/' + data.id + '/severity_negative_factors_for_triggers',
      data: data,
      success: function(response) {
        $('.snf').html(response)
      }
    })
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

function fetchTechnology(vendor, platform, version, target){
  data = {
    field: target.data('field'),
    filter: {
      vendor: vendor,
      platform: platform,
      version: version,
    }
  }

  $.get('/technologies', data, function(response){
    html = "";
    $(target).select2().empty().select2({data: response}).trigger('change');
    // $(target).select2({data: response}).trigger('change');
    // response.forEach(function(value){
      // html += '<option value="' + value + '">' + value + "</option>";
    // })
    // target.html(html);
    // $(target).select2();
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
    $('#law-firms').select2().empty().select2({data: response.selected});
    $('#law-firms option').attr('selected', true).parent().trigger('change');
    $('#law-firms').select2({data: response.all});
    $('#law-firms-count').html(response.selected.length + " Firm(s) found")
  })
}

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
  currentFieldLogics = _.where(logics, { listen_field_id: parseInt(currentFieldId) })
  
  if( currentFieldLogics.length > 0 ) {
    currentFieldLogics.forEach(function(logic) {
      targetField = $('.field-wrapper-' + logic.change_field_id)
      if( (currentField.val() == logic.values && currentField.val().length != 0) 
           || (logic.values == "" && currentField.val().length > 0)
           || (currentField.hasClass('fileupload') && parseInt(currentField.data('file-count')) > 0)
        ){
        switch(logic.perform_action){
          case 'show':
            targetField.show();
            targetField.find("select").select2();
            break;
          case 'hide':
            targetField.hide();
            if(!pageLoad){
              targetField.find("select").val('').trigger('change');
              targetField.find("input[type!=hidden]").val('').trigger('change');
            }
            break;
        }
      } else {
        switch(logic.perform_action){
          case 'show':
            targetField.hide();
            if(!pageLoad){
              targetField.find("select").val('').trigger('change');
              targetField.find("input[type!=hidden]").val('').trigger('change');
            }
            break;
          case 'hide':
            targetField.show();
            targetField.find("select").select2();
            if(!pageLoad){
              targetField.find("input[type!=hidden]").val('').trigger('change');
            }
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

