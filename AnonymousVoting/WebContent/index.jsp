<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AnonymousVoting</title>
<script src="JS/jquery-2.1.3.js" type="text/javascript"></script>
<script src="JS/jquery-ui.js"  type="text/javascript"></script>
<script src="JS/bootstrap.js"  type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="CSS/jquery-ui.theme.css"/>
<link rel="stylesheet" type="text/css" href="CSS/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="CSS/jquery-ui.structure.css"/>
<link rel="stylesheet" type="text/css" href="CSS/bootstraps1.css"/>
</head>
<%response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate"); 

%>
<script>
$(function(){
<%if(null != request.getParameter("show")){
	String id = request.getParameter("show");
%>	
	$.ajax(
	{
		url: 'ShowVote',
		type: 'post',
		data: {pollID:<%=id %>},
		success: function(data)
		{
			$('#main').html( data );
			$('#errorVat').hide();
			$('.errorSelected').hide();
		}
	});
<%}	
else if(null != request.getParameter("r")){
	String id = request.getParameter("r");
%>	
	$.ajax(
	{
		url: 'ShowResults',
		type: 'post',
		data: {pollID:<%=id %>},
		success: function(data)
		{
			$('#main').html( data );
			interval = setInterval(function(){
				$.ajax(
				{
					url: 'ShowResults',
					type: 'post',
					data: {pollID:<%=id %>},
					success: function(data)
					{
						$('#main').html( data );
					}
				});
			}, 2000)
		}
	});
<%}else{
%>

	$.ajax(
	{
		url: 'SelectPolls',
	    type: 'post',
	    datatype: 'json',
	    success: function(data)
	    {
	    	$('#main').html( data );
	    }
	});
<%}%>
	function errorClass( elem ) 
    {
      elem.addClass( "has-error" );
    }
	function errorMessage( txt , elem1 , elem2 )
	{
		elem2.text(txt);
		elem1.show();
	}
	function checkVAT(num)
	{
		var c;
		var regex = /[0-9]/ ;
		if(num.length != 9) 
		{
			errorClass($('#vatdiv'));
			errorMessage('Not a valid VAT number!', $('#errorVat'), $('#erVat'));
			return false;
		}
		for(i=0; i < num.length; i++)
		{
			c = num.charAt(i);
			if(!regex.test(c))
			{
				errorClass($('#vatdiv'));
				errorMessage('Not a valid VAT number!', $('#errorVat'), $('#erVat'));
				return false;
			}
		}
		return true;
	}
	function checkSelected(opt){
		if(undefined != opt.val()) return true;
		errorMessage('Please select an option first!', $('.errorSelected'), $('.errS'));
		return false;
	}
	$(document).on('click', '.poll' ,function(){
		var id = $(this).data("id");
		$.ajax(
		{
			url: 'ShowVote',
			type: 'post',
			data: {pollID:id},
			success: function(data)
			{
				$('#main').html( data );
				$('#errorVat').hide();
				$('.errorSelected').hide();
			}
		});
		return false;
	});
	$(document).on('click', '#backBtn', function(){
		$.ajax(
		{
			url: 'SelectPolls',
	    	type: 'post',
	    	datatype: 'json',
	    	success: function(data)
	    	{
	    		$('#main').html( data );
	    		clearInterval(interval);
	    	}
		});
		return false;
	});
	$(document).on('click', '#submitBtn', function(e)
	{
		var p = $(this).data("id");
		$('#vatdiv').removeClass("has-error");
		$('#errorVat').hide();
		$('#errorVat2').hide();
		$('#errorCaptcha').hide();
		$('.errorSelected').hide();
		var valid = true;
		valid = valid && checkSelected($('[name=options]:checked'));
		if(undefined != $('#vatI').val())valid = valid && checkVAT($('#vatI').val());
		if(valid)
		{
			$.ajax(
			{
				url: 'SubmitVote',
				type: 'post',
				data: {opt:$('[name=options]:checked').val(), vat:$('#vatI').val(), poll:p, captcha:$('#capI').val()},
				success: function(data)
				{
					$('#main').html( data );
					$('.errorSelected').hide();
					var res = $('#results').data('id');
					if("true" == res){
					 	interval = setInterval(function(){
							$.ajax(
							{
								url: 'ShowResults',
								type: 'post',
								data: {pollID:p},
								success: function(data)
								{
									$('#main').html( data );
								}
							});
						}, 2000)
					}
				}
			});
		}
		return false;
	});
	$(document).on('click', '#addPoll', function(){
		$.ajax(
		{
			url: 'CreateNewPoll',
	    	type: 'post',
	    	datatype: 'json',
	    	success: function(data)
	    	{
	    		$('#main').html( data );
	    		$('#errorDiv').hide();
	    	}
		});
		return false;
	});
	$(document).on('click', '#resultsBtn', function(){
		var p = $(this).data("id");
		$.ajax(
		{
			url: 'ShowResults',
			type: 'post',
			data: {pollID:p},
			success: function(data)
			{
				$('#main').html( data );
				interval = setInterval(function(){
					$.ajax(
					{
						url: 'ShowResults',
						type: 'post',
						data: {pollID:p},
						success: function(data)
						{
							$('#main').html( data );
						}
					});
				}, 2000)
			}
		});
		return false;
	});
//create table in memory

	var tableArray = new Array();
	var number = 0;
	var text = "";
	var btn = false;
	
	function MakeRecord(number,text,btn)
	{
		this.number = number;
		this.text = text;
		this.btn = btn;
	}
	for(i=0;i<4;i++){
		number = i+1;
		var rec = new MakeRecord(number,text,btn);
		tableArray.push(rec);
	}
	
	function createTR(rec){
		var newTR = '<tr><td class="col-md-1">'+ rec.number +'</td><td class="col-md-3">'+
		'<div class="form-group">'+
    	'<input type="text" '+
    	'class="form-control" '+
    	'id="'+ rec.number +'" '+
    	'placeholder="Enter poll option..." value="'+ rec.text +'" ></div></td>'
    	if(rec.btn){
    		newTR = newTR +'<td class="col-md-8">'+
    		'<div class="form-group">'+
        	'<button name="delOption" '+
        	'class="btn btn-danger btn-xs" '+
        	'data-toggle="modal" '+
        	'data-target="#delete-modal" ><span '+
        	'class="glyphicon glyphicon-remove" '+
        	'aria-hidden="true"></span><span '+
        	'class="sr-only">Remove</span></button></div></td></tr>';
    	}
    	else
    	{
    		newTR = newTR +'<td class="col-md-8">' + '</td></tr>';
    	}
        return newTR;
	}
	
	function createTable(){
		$('#createPoll tbody').find('tr').remove();
		for(i = 0; i < tableArray.length; i++){
			var rec = tableArray[i];
			rec.number = parseInt(i) + parseInt(1);
			if( i == 0 ) $('#createPoll tbody').html(createTR(rec));
			else $('#createPoll tr:last').after(createTR(rec));
		}
	}
	
	$(document).on('click', '#addOption', function(){
		var id = $('#createPoll tr:last td div input').attr('id');
		id = parseInt(id)+ parseInt(1);
		for(i = 0; i < tableArray.length; i++)
		{
			var rec = tableArray[i]
			count = parseInt(i)+ parseInt(1);
			ele = "#"+count;
			rec.text = $(ele).val();
			tableArray[i] = rec;
		}
		text = "";
		rec = new MakeRecord(id,text,true)
		tableArray.push(rec);
		createTable();
	});
	
	$(document).on('click', '[name=delOption]', function(){
		var id = $(this).closest('tr').find('input').attr('id');
		for(i = 0; i < tableArray.length; i++)
		{
			var rec = tableArray[i]
			count = parseInt(i)+ parseInt(1);
			ele = "#"+count;
			rec.text = $(ele).val();
			tableArray[i] = rec;
		}
		tableArray.splice(id - 1 , 1);
		createTable();
	});
	$(document).on('click', '#createBtn', function(){
		$('#errorDiv').hide();
		var allInputs = "";
		var count = 0;
		for(i = 0; i < tableArray.length; i++)
		{
			c = parseInt(i)+ parseInt(1);
			ele = "#" + c;
			if("" != $(ele).val()) {
				count = parseInt(count) + parseInt(1);
				if("" == allInputs) allInputs = $(ele).val();
				else allInputs = allInputs + "\^" + $(ele).val();
			}
		}
		if("" == $('#question').val()){
			$('#erSpan').text("Please enter a poll question.")
			$('#errorDiv').show();
		}
		else if("" == $('#title').val()){
			$('#erSpan').text("Please enter a poll title.")
			$('#errorDiv').show();
		}
		else if(count < 2){
			$('#erSpan').text("Please enter at least 2 options.")
			$('#errorDiv').show();
		}
		else{
			$.ajax(
			{
				url: 'CreatePoll',
				type: 'post',
				data: {question:$('#question').val(),title:$('#title').val() , alltxt:allInputs , type:$('[name=options]:checked').val()},
				success: function(data)
				{
					$('#main').html( data );
				}
			});
		}
		return false;
	});
});
</script>

<body>

<div class="container-fluid">

<div id="main" class="panel panel-primary"></div>

<div class="navbar navbar-inverse navbar-static-bottom">
	<div class="navbar-header col-md-offset-4">
      <a class="navbar-brand" href="about.jsp">AnonymousVoting</a>
    </div>
</div>

</div>

</body>

</html>