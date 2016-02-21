<%@ page import="voting.pkg.*" %>
<%@ page import="java.sql.Connection,java.sql.ResultSet,java.sql.SQLException,java.sql.PreparedStatement,java.util.*" %>
<%@ page import="javax.naming.Context,javax.naming.InitialContext,javax.naming.NamingException,javax.sql.DataSource" %>
<% 
Poll poll = new Poll();
List<String> opt = new ArrayList<String>();
List<String> det = new ArrayList<String>();
List<String> res = new ArrayList<String>();
if( request.getAttribute("pollData") instanceof Poll)
{
	poll = (Poll)request.getAttribute("pollData");
	opt = poll.getOption();
	det = poll.getDetailsID();
	res = poll.getResults();
}
int sum = 0;
int num = 0;
for(String str : res){
	try{
		num = Integer.parseInt(str);
		sum = sum + num;
	}
	catch(NumberFormatException e){
		e.printStackTrace();
	}
}
boolean valid = Boolean.valueOf(request.getAttribute("isValid").toString());
if(!valid){
%>
<div class="alert alert-dismissible alert-danger">
  <strong>Error!</strong> Something went wrong try submitting again.
</div>
<%}else{%>
<div class="panel-heading">
    <h3 class="panel-title"><%=poll.getPollTitle() %></h3>
</div>
  
<div id="results" data-id="true" class="panel-body">
<table id="createPoll" class="table table-striped table-hover table-condensed">
  <thead>
    <tr>
    	<th class="col-md-1"></th>
    	<th class="col-md-11"><h4><%=poll.getPollDesc() %></h4></th>
    	<th class="col-md-1"></th>
    </tr>
  </thead>
  <tfoot>
    <tr>
    	<td class="col-md-1">
    	
    	</td>
    	<td class="col-md-11"><h4>Total: <%=sum %></h4></td>
    	<td class="col-md-1">
    	<div class="form-group">
        	<button id="backBtn" class="btn btn-default">Back</button>
      	</div>
    	</td>
    </tr>
  </tfoot>
  <tbody>
  <%for(int i = 0; i < opt.size(); i++){ %>
  	<tr>
  		<td class="col-md-1"><h5><%=det.get(i) %></h5></td>
    	<td class="col-md-10"><h5><%=opt.get(i) %></h5></td>
    	<td class="col-md-1"></td>
  	</tr>
  	<tr>
  		<td class="col-md-1"></td>
    	<td class="col-md-10">
    	<div class="progress">
    	<%int percent = 0;
    	try{
    		num = Integer.parseInt(res.get(i));
    		if(num == 0)percent = 0;
    		else percent = (num*100)/sum;
    	}
    	catch(NumberFormatException e){
    		e.printStackTrace();
    	} %>
  			<div class="progress-bar" style="width: <%=percent %>%;"></div>
		</div>
    	</td>
    	<td class="col-md-1"><h5><%=res.get(i) %></h5></td>
  	</tr>
  <%} %>
  </tbody>
</table>
</div>
<%}%>