package voting.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class GetPolls {
	public List<Poll> getAllPolls()
	{
		DataSource ds=null;
		Connection con = null;
		PreparedStatement stm = null;
		List<Poll> allpolls = new ArrayList<Poll>();
		try
		{
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/votedb");
		}
		catch (NamingException e)
		{
			e.printStackTrace();
		}
		try
		{
			con = ds.getConnection();
			String sql;
			sql = "SELECT * FROM votesubject where status = ? order by id desc";
			stm = con.prepareStatement(sql);
			stm.setString(1, "1");
			ResultSet polls = stm.executeQuery();
			Poll poll;
			while(polls.next())
			{
				poll = new Poll();
				poll.setSubjectID(polls.getString("id"));
				poll.setPollTitle(polls.getString("title"));
				poll.setPollDesc(polls.getString("description"));
				String date = polls.getString("startdate");
				date = date.substring(0,date.length()-2);
				poll.setPollStartDate(date);
				date = polls.getString("enddate");
				date = date.substring(0,date.length()-2);
				poll.setPollEndDate(date);
				allpolls.add(poll);
			}
		}
		catch (SQLException e) 
		{	e.printStackTrace();}
		finally
		{
		    try 
		    {    	if(null!=stm)stm.close();	} 
		    catch (SQLException e) 
		    {    	e.printStackTrace();    }
		    try 
		    {    	if(null!=con)con.close();   } 
		    catch (SQLException e) 
		    {    	e.printStackTrace();    }
		}
		return allpolls;
	}
	
	public Poll getPoll(String id){
		DataSource ds=null;
		Connection con = null;
		PreparedStatement stm = null;
		Poll poll = new Poll();
		List<String> det = new ArrayList<String>();
		List<String> opt = new ArrayList<String>();
		try
		{
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/votedb");
		}
		catch (NamingException e)
		{
			e.printStackTrace();
		}
		try
		{
			con = ds.getConnection();
			String sql = "select * from votesubject vs left outer join votedetails vd on vs.id = vd.subjectID where id = ?";
			stm = con.prepareStatement(sql);
			stm.setString(1, id);
			ResultSet polls = stm.executeQuery();
			while(polls.next())
			{
				poll.setSubjectID(polls.getString("id"));
				poll.setPollTitle(polls.getString("title"));
				poll.setPollDesc(polls.getString("description"));
				poll.setPollStartDate(polls.getString("startdate"));
				poll.setPollEndDate(polls.getString("enddate"));
				poll.setType(polls.getString("vType"));
				det.add(polls.getString("detailsID"));
				poll.setDetailsID(det);
				opt.add(polls.getString("vOption"));
				poll.setOption(opt);
			}
		}
		catch (SQLException e) 
		{	e.printStackTrace();}
		finally
		{
		    try 
		    {    	if(null!=stm)stm.close();	} 
		    catch (SQLException e) 
		    {    	e.printStackTrace();    }
		    try 
		    {    	if(null!=con)con.close();   } 
		    catch (SQLException e) 
		    {    	e.printStackTrace();    }
		}
		return poll;
	}
	public boolean checkIfOptionExists(String pollId,String optId){
		DataSource ds=null;
		Connection con = null;
		PreparedStatement stm = null;
		boolean valid = false;
		try
		{
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/votedb");
		}
		catch (NamingException e)
		{
			e.printStackTrace();
		}
		try
		{
			con = ds.getConnection();
			String sql = "select * from votedetails where subjectID = ? and detailsID = ?;";
			stm = con.prepareStatement(sql);
			stm.setString(1, pollId);
			stm.setString(2, optId);
			ResultSet res = stm.executeQuery();
			if(res.next())
			{
				valid = true;
			}
		}
		catch (SQLException e) 
		{	e.printStackTrace();}
		finally
		{
		    try 
		    {    	if(null!=stm)stm.close();	} 
		    catch (SQLException e) 
		    {    	e.printStackTrace();    }
		    try 
		    {    	if(null!=con)con.close();   } 
		    catch (SQLException e) 
		    {    	e.printStackTrace();    }
		}
		return valid;
	}
	public Poll getPollResults(String pollID){
		DataSource ds=null;
		Connection con = null;
		PreparedStatement stm = null;
		Poll poll = new Poll();
		List<String> det = new ArrayList<String>();
		List<String> opt = new ArrayList<String>();
		List<String> res = new ArrayList<String>();
		try
		{
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/votedb");
		}
		catch (NamingException e)
		{
			e.printStackTrace();
		}
		try
		{
			con = ds.getConnection();
			String sql = "select vs.title,vs.description,vs.vType,vd.subjectID,vd.detailsID,vd.vOption," +
						"(SELECT COUNT(*) FROM Votes v WHERE v.subjectID=vd.subjectID AND v.detailsID=vd.detailsID) as results " +
						"from votedetails vd " +
						"left outer join votesubject vs on vs.id = vd.subjectID " +
						"where vd.subjectID = ? " + 
						"group by vd.detailsID " +
						"order by results desc, vd.detailsID asc;";
			stm = con.prepareStatement(sql);
			stm.setString(1, pollID);
			ResultSet polls = stm.executeQuery();
			while(polls.next())
			{
				poll.setSubjectID(polls.getString("subjectID"));
				poll.setPollTitle(polls.getString("title"));
				poll.setPollDesc(polls.getString("description"));
				poll.setType(polls.getString("vType"));
				det.add(polls.getString("detailsID"));
				poll.setDetailsID(det);
				opt.add(polls.getString("vOption"));
				poll.setOption(opt);
				res.add(polls.getString("results"));
				poll.setResults(res);
			}
		}
		catch (SQLException e) 
		{	e.printStackTrace();}
		finally
		{
		    try 
		    {    	if(null!=stm)stm.close();	} 
		    catch (SQLException e) 
		    {    	e.printStackTrace();    }
		    try 
		    {    	if(null!=con)con.close();   } 
		    catch (SQLException e) 
		    {    	e.printStackTrace();    }
		}
		return poll;
	}
}
