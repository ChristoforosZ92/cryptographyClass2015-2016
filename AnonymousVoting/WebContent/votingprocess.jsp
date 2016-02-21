<%@ page import="voting.pkg.*" %>
<%@ page import="java.util.Date,java.text.DateFormat,java.text.SimpleDateFormat,java.sql.Connection,java.sql.ResultSet,java.sql.SQLException,java.sql.PreparedStatement,java.util.*" %>
<%@ page import="javax.naming.Context,javax.naming.InitialContext,javax.naming.NamingException,javax.sql.DataSource" %>
<% 
Poll poll = new Poll();
List<String> opt = new ArrayList<String>();
List<String> det = new ArrayList<String>();
String type = "";
String endDate = "";
if( request.getAttribute("pollData") instanceof Poll)
{
	poll = (Poll)request.getAttribute("pollData");
	opt = poll.getOption();
	det = poll.getDetailsID();
	type = poll.getType();
	endDate = poll.getPollEndDate();
}
String id = "";
String errorM = "";
if(null != request.getAttribute("pollId")) id = (String)request.getAttribute("pollId");
if(null != request.getAttribute("errorM")) errorM = (String)request.getAttribute("errorM");
CustomCaptcha cc = new CustomCaptcha();
String newCap = cc.generateCaptcha();
boolean valid = true;
if(null != request.getAttribute("isValid"))valid = Boolean.valueOf(request.getAttribute("isValid").toString());
%>
<div class="panel-heading">
    <h3 class="panel-title"><%=poll.getPollTitle() %></h3>
</div>
  
<div class="panel-body">
<%
Date date = new Date();
DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
try {
	 date = df.parse(endDate);
}
catch (Exception e) {
	e.printStackTrace();
}
Date today = new Date();
if(today.after(date)){
%>
<div class="jumbotron">
  <h3><%=poll.getPollDesc() %></h3>
  <p>The voting period for this poll has ended you can view the results here.</p>
  <p class="col-md-12">
        <button id="backBtn" class="btn btn-default">Back</button>
        <button id="resultsBtn" data-id="<%=id %>" class="btn btn-success">Results</button>
  </p>
</div>
<%}else{ %>
<form id="votingForm" class="form-horizontal">
<fieldset>
<legend><%=poll.getPollDesc() %></legend>

<div class="form-group">
	<label class="col-md-2 control-label">Options</label>
    <div class="col-md-10">
    <% for(int i = 0; i < opt.size(); i++){ %>
		<div class="radio">
        <label>
			<input type="radio" name="options" id="option<%=i %>" value="<%=det.get(i) %>">
            <%=opt.get(i) %>
        </label>
        </div>
    <%} %>
	</div>
</div>
<%if("2".equals(type)){ %>
<div class="form-group">
      <label for="vatI" class="col-md-2 control-label">VAT:</label>
      <div id="vatdiv" class="col-md-3">
        <input type="text" class="form-control" id="vatI" name="vatI" placeholder="VAT">
      </div>
      <div id="errorVat" class="alert alert-dismissible alert-danger col-md-3 errorSelected">
  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  		<span id="erVat" class="errS"></span>
	  </div>
	  <% if(!valid){ %>
	  <div id="errorVat2" class="alert alert-dismissible alert-danger col-md-3">
  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  		<span><%=errorM %></span>
	  </div>
	  <%} %>
</div>
<%}else if ("1".equals(type)){ %>
	<div class="form-group">
		<span class="label label-warning col-md-3 col-md-offset-2"><%=newCap %></span>
		<br/>
		<label for="capI" class="col-md-2 control-label">Captcha:</label>
      <div id="capdiv" class="col-md-3">
        <input type="text" class="form-control" id="capI" name="Captcha" >
      </div>
      <div class="alert alert-dismissible alert-danger col-md-3 errorSelected">
  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  		<span id="erCap" class="errS"></span>
	  </div>
      <% if(!valid){ %>
	  <div id="errorCaptcha" class="alert alert-dismissible alert-danger col-md-3">
  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  		<span><%=errorM %></span>
	  </div>
	  <%} %>
	</div>
<%} %>
<div class="form-group">
      <div class="col-md-8 col-md-offset-2">
        <button id="backBtn" class="btn btn-default">Back</button>
        <button id="submitBtn" data-id="<%=id %>" class="btn btn-primary">Vote</button>
      </div>
      <div class="col-md-2">
        <button id="resultsBtn" data-id="<%=id %>" class="btn btn-success">Results</button>
      </div>
</div>
</fieldset>
</form>
<%} %>
</div>