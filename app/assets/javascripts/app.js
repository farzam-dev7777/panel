$(document).ready(function(){
  $("*[data-custom-logic='true']").each(function(){
    prepareForCustomLogic($(this).find('.form_submission_form_values_value input, .form_submission_form_values_value select'));
  });

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

  $("input, select").change(function(){
    prepareForCustomLogic($(this));
  });

  if($('#gauge').length){
    var g = new JustGage({
      id: "gauge",
      value: 137,
      min: 0,
      max: 300
    });
  }

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


  $('.dynamic-select').select2().on('change', function() {
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


});

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

    $(target).select2('destroy').empty().select2({data: response}).trigger('change');
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


function prepareForCustomLogic(currentField){
  targetFieldId = currentField.parent().parent().siblings('.form_submission_form_values_form_field_id').find('input').val();
  targetField = $('.field-wrapper-'+targetFieldId);
  if(currentField.val() == targetField.find("*[data-custom-logic='true']").data('show-when-value')){
    targetField.find("*[data-custom-logic='true']").show();
  }else{
    targetField.find("*[data-custom-logic='true']").hide();
  }
}