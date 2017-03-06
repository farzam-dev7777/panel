$(document).ready(function(){
  // $("*[data-custom-logic='true']").each(function(){
  //   prepareForCustomLogic($(this).find('.form_submission_form_values_value input, .form_submission_form_values_value select'));
  // });
  $('.form_submission_form_values_value input, .form_submission_form_values_value select').each(function(){
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
      dateFormat: "yy-mm-dd",
      altField: $(this).next()
    })

    // If you use i18n-js you can set the locale like that
    $(this).datepicker("option", $.datepicker.regional['en']);
  })

  $('.form_form_fields_custom_logic').each(initializeCustomLogic);

  $("select").on("change", function(){
    showIfCustomLogicMatched($(this));
  });

  $("input[type='text']").on("change paste keyup", function(){
    showIfCustomLogicMatched($(this));
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
    $(this).parent().parent().hide();
    $(this).parent().parent().next('.text-only-fields').removeClass('hidden').show();
  });


  if(window.location.pathname.indexOf("/admin/form_submissions/") > -1){
    $('select').attr('disabled', 'true');
    $('input[type="text"]').attr('disabled', 'true');
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

  $('form.resolve-note-form').on('submit', function(e){
    e.preventDefault();
    $.ajax({
      url: "/admin/follow_ups/resolve",
      method: 'post',
      data: $(this).serialize(),
      context: $(this).parent().parent().children()
    })
      .done(function( data ) {
        $(this).children('form.resolve-note-form').find('.resolve-btn').val('Resolved').attr('disabled', 'true')
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


});

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

function initializeCustomLogic(){
  if($(this).find('input:checked').length > 0){
    $(this).siblings('.form_form_fields_show_when_form_field_id').show();
    $(this).siblings('.form_form_fields_show_when_form_field_value').show();
  }else{
    $(this).siblings('.form_form_fields_show_when_form_field_id').hide();
    $(this).siblings('.form_form_fields_show_when_form_field_value').hide();
  }
}


function showIfCustomLogicMatched(currentField){
  targetFieldId = currentField.parent().parent().siblings('.form_submission_form_values_form_field_id').find('input').val();
  $("*[data-show-when-field-id='"+ targetFieldId +"']").each(function(){
    if($(this).data("show-when-value") == currentField.val()){
      $(this).show();
      $(this).find("select").select2();
    }else{
      $(this).find("select").val('')
      $(this).find("select").trigger('change')
      $(this).hide();
    }
  })
}

function prepareForCustomLogic(currentField){
  showIfCustomLogicMatched(currentField);
}