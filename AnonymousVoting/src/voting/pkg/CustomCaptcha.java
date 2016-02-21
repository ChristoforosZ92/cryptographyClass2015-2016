package voting.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CustomCaptcha {
	public String generateCaptcha(){
		String captcha = "";
		Random r = new Random();
		for( int i = 0; i < 5; i++){
			int randomNum = r.nextInt(10);
			captcha = captcha + randomNum;
		}
		addCaptcha(captcha);
		return captcha;
	}
	private void addCaptcha(String cap){
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
			String sql = "insert into captcha(randomNumber) values (?);";
			stm = con.prepareStatement(sql);
			stm.setString(1, cap);
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
	public boolean verifyCaptcha(String cap){
		DataSource ds=null;
		Connection con = null;
		PreparedStatement stm = null;
		PreparedStatement stm2 = null;
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
			String sql = "select * from captcha where randomNumber = ? and status = '1';";
			stm = con.prepareStatement(sql);
			stm.setString(1, cap);
			ResultSet captcha = stm.executeQuery();
			if(captcha.next())
			{
				valid = true;
			}
			sql = "Update captcha set status = '0' where randomNumber = ? and status = '1';";
			stm2 = con.prepareStatement(sql);
			stm2.setString(1, cap);
			stm2.executeUpdate();
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
		    {    	if(null!=stm2)stm2.close();	} 
		    catch (SQLException e) 
		    {    	e.printStackTrace();    }
		    try 
		    {    	if(null!=con)con.close();   } 
		    catch (SQLException e) 
		    {    	e.printStackTrace();    }
		}
		return valid;
	}
}
