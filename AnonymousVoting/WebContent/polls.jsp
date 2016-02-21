<%@ page import="voting.pkg.*" %>
<%@ page import="java.sql.Connection,java.sql.ResultSet,java.sql.SQLException,java.sql.PreparedStatement,java.util.*" %>
<%@ page import="javax.naming.Context,javax.naming.InitialContext,javax.naming.NamingException,javax.sql.DataSource" %>
<% 
List<Poll> polls = new ArrayList<Poll>();
if( request.getAttribute("listData") instanceof List)
{
	polls = (List<Poll>)request.getAttribute("listData");
}
%>
<div class="panel-heading">
    <h3 class="panel-title">Select a poll to cast your vote.</h3>
</div>

<div class="panel-body">

<div class="row">
	<div class="col-md-12">
    	<button id="addPoll" class="btn btn-primary">Add new poll</button>
	</div>
</div>
<br/>
<div class="row">
	<div id="polls" class="list-group">
<%for( Poll poll : polls ){%>
  		<a href="#" data-id="<%=poll.getSubjectID() %>" class="poll list-group-item">
    	<h4 class="list-group-item-heading"><%=poll.getPollTitle() %></h4>
    	<p class="list-group-item-text"><%=poll.getPollDesc() %></p>
    	<p class="list-group-item-text">Started: <%=poll.getPollStartDate() %> / Ends: <%=poll.getPollEndDate() %></p>
  		</a>
 <%} %>
	</div>
</div>

    

</div>