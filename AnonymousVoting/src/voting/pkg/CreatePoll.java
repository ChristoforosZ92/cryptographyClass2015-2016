package voting.pkg;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.mysql.jdbc.Statement;

@WebServlet("/CreatePoll")
public class CreatePoll extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CreatePoll() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String question = request.getParameter("question");
		String alltxt = request.getParameter("alltxt");
		String type = request.getParameter("type");
		String title = request.getParameter("title");
		String[] options = alltxt.split("\\^");
		String t = "";
		if("vat".equals(type)) t = "2";
		else if("captcha".equals(type)) t = "1";
		String newPoll = createPoll(question,title,t,options);
		if(!"".equals(newPoll)){
			request.setAttribute("newPoll", newPoll);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/createFinish.jsp");
			rd.forward(request, response);
		}
		else
		{
			request.setAttribute("isValid", false);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/createPoll.jsp");
			rd.forward(request, response);
		}
	}
	private String createPoll(String quest,String title,String type ,String[] options){
		DataSource ds=null;
		Connection con = null;
		PreparedStatement stm1 = null;
		PreparedStatement stm2 = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		String start = dateFormat.format(date);
		String end = getEndDate(start);
		String newid = "";
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
			String sql = "insert into votesubject(title,description,startdate,enddate,vType) values (?,?,?,?,?);";
			stm1 = con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			stm1.setString(1, title);
			stm1.setString(2, quest);
			stm1.setString(3, start);
			stm1.setString(4, end );
			stm1.setString(5, type);
			stm1.executeUpdate();
			ResultSet id  = stm1.getGeneratedKeys();
			if(id.next())
			{
				newid = id.getString(1);
			}
			int count = options.length;
			count = count - 1;
			sql = "insert into votedetails(subjectID,detailsID,vOption) values";
			for(int i = 0; i < options.length; i++){
				if(i < count)sql = sql + "(?,?,?),";
				else sql = sql + "(?,?,?);";
			}
			stm2 = con.prepareStatement(sql);
			int j = 0;
			for(int i = 0; i < options.length; i++){
				j++;
				stm2.setString(j, newid);
				j++;
				stm2.setInt(j, i+1 );
				j++;
				stm2.setString(j, options[i]);
			}
			stm2.executeUpdate();
			con.commit();
		}
		catch (SQLException e){	
			e.printStackTrace();
		}
		finally
		{
		    try 
		    {    	if(null!=stm1)stm1.close();	} 
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
		return newid;
	}
	private String getEndDate(String date)
	{
		String[] datetime = date.split(" ");
		String[] parts = datetime[0].split("-");
		String end = "";
		int[] numbers = new int[parts.length];
		for(int i =0;i<parts.length;i++)
		{
			numbers[i]=Integer.parseInt(parts[i]);
		}
		int year = numbers[0];
		int month = numbers[1];
		int day = numbers[2];
		day = day + 10;
		if(month != 2){
			if((month & 1) == 1){
				if(month < 8){
					if(day > 31){
						day = day - 31;
						month = month + 1;
					}
				}
				else{
					if(day > 30){
						day = day - 30;
						month = month + 1;
						if(month > 12) month = 1;
					}
				}
			}
			else{
				if(month < 8){
					if(day > 30){
						day = day - 30;
						month = month + 1;
					}
				}
				else{
					if(day > 31){
						day = day - 31;
						month = month + 1;
						if(month > 12) month = 1;
					}
				}
			}
		}
		else{
			if((year % 4 == 0 && year % 100 != 0) || year % 400 == 0){
				if(day > 29){
					day = day - 29;
					month = month + 1;
				}
			}
			else{
				if(day > 28){
					day = day - 28;
					month = month + 1;
				}
			}
		}
		end = year + "-" + month + "-" + day + " " + "23:59:59";
		return end;
	}
}
