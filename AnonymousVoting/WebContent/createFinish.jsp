<%@ page import="voting.pkg.*" %>
<%@ page import="java.sql.Connection,java.sql.ResultSet,java.sql.SQLException,java.sql.PreparedStatement,java.util.*" %>
<%@ page import="javax.naming.Context,javax.naming.InitialContext,javax.naming.NamingException,javax.sql.DataSource" %>
<% 
String newPoll = (String)request.getAttribute("newPoll");
%>
<div class="panel-heading">
    <h3 class="panel-title"></h3>
</div>

<div class="panel-body">

<div class="alert alert-dismissible alert-success">
  <strong>Well done!</strong> Your poll has been created and is now available at <a href="http://localhost:8181/AnonymousVoting/?show=<%=newPoll %>" class="alert-link">http://localhost:8181/AnonymousVoting/?show=<%=newPoll %></a>.
</div>

</div>
