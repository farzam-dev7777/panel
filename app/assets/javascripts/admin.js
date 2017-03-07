$(document).ready(function(){

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

})

function toast(text){
	$.toast({
    heading: 'Information',
    text: text,
    icon: 'info',
    loader: true,
    loaderBg: '#9EC600'
	})
}