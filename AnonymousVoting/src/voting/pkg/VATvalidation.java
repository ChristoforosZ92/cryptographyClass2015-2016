package voting.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class VATvalidation {
	public boolean vatExists(String vat , String id){
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
			String sql = "select * from voters where vat = ? and subjectID = ?;";
			stm = con.prepareStatement(sql);
			stm.setString(1, vat);
			stm.setString(2, id);
			ResultSet vatEx = stm.executeQuery();
			if(vatEx.next())
			{
				valid = true;
			}
		}
		catch (SQLException e){	
			e.printStackTrace();
		}
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
	public void addNewVat(String vat , String id){
		DataSource ds=null;
		Connection con = null;
		PreparedStatement stm = null;
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
			con.setAutoCommit(false);
			String sql = "insert into voters(vat,subjectID) values (?,?);";
			stm = con.prepareStatement(sql);
			stm.setString(1, vat);
			stm.setString(2, id);
			stm.executeUpdate();
			con.commit();
		}
		catch (SQLException e){	
			e.printStackTrace();
		}
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
	}
}
