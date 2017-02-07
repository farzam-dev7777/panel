$(document).ready(function(){
  $(".add_more_options").click(function(e){
    e.preventDefault();
    html = $(this).data("association-insertion-template");
    $(this).parent().prepend(html);
  })
  $('*[data-role=activerecord_sortable]').activerecord_sortable();
});
