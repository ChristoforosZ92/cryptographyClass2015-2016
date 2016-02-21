package voting.pkg;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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

import javax.servlet.http.*;

@WebServlet("/SubmitVote")
public class SubmitVote extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SubmitVote() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String selected = request.getParameter("opt");
		String cap = request.getParameter("captcha");
		String vat = request.getParameter("vat");
		String pollId = request.getParameter("poll");
		boolean valid = checkVat(vat);
		CustomCaptcha cc =new CustomCaptcha();
		boolean verify = cc.verifyCaptcha(cap);
		GetPolls gp = new GetPolls();
		if((valid || verify) && null != selected){
			valid = gp.checkIfOptionExists(pollId, selected);
			if(valid){
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date date = new Date();
				String newdate = dateFormat.format(date);
				VATvalidation vv = new VATvalidation();
				Cookie[] cookies = request.getCookies();
				Cookie votedPollID = null;
				if(null != cookies){
					for(int i = 0; i < cookies.length;i++){
						if(pollId.equals(cookies[i].getValue())){
							votedPollID = cookies[i];
							break;
						}
					}
				}
				if(null != vat && vv.vatExists(vat, pollId)){
					Poll poll = gp.getPoll(pollId);
					request.setAttribute("errorM", "Sorry you have already voted!");
					request.setAttribute("pollData", poll);
					request.setAttribute("isValid", false);
					request.setAttribute("pollId", pollId);
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/votingprocess.jsp");
				    rd.forward(request, response);
				}
				else if(null != votedPollID && votedPollID.getValue().toString().equals(pollId))
				{
					Poll poll = gp.getPoll(pollId);
					request.setAttribute("errorM", "Sorry you have already voted!");
					request.setAttribute("pollData", poll);
					request.setAttribute("isValid", false);
					request.setAttribute("pollId", pollId);
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/votingprocess.jsp");
				    rd.forward(request, response);
				}
				else{
					valid = addVote(pollId,selected,newdate);
					if(valid){
						if(!verify)vv.addNewVat(vat, pollId);
						else {
							votedPollID = new Cookie("AnonymousVoting"+pollId, pollId);
							votedPollID.setMaxAge(60*60*24*10);
							response.addCookie(votedPollID);
						}
						Poll results = gp.getPollResults(pollId);
						request.setAttribute("pollData", results);
						request.setAttribute("isValid", valid);
						request.setAttribute("pollId", pollId);
						RequestDispatcher rd = getServletContext().getRequestDispatcher("/showResults.jsp");
						rd.forward(request, response);
					}
					else{
						request.setAttribute("isValid", valid);
						request.setAttribute("pollId", pollId);
						RequestDispatcher rd = getServletContext().getRequestDispatcher("/showResults.jsp");
						rd.forward(request, response);
					}
				}
			}
			else{
				request.setAttribute("isValid", valid);
				request.setAttribute("pollId", pollId);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/showResults.jsp");
			    rd.forward(request, response);
			}
		}
		else{
			Poll poll = gp.getPoll(pollId);
			if("1".equals(poll.getType())) request.setAttribute("errorM", "Captcha not valid!");
			else request.setAttribute("errorM", "Not a valid VAT number!");
			request.setAttribute("pollData", poll);
			request.setAttribute("isValid", false);
			request.setAttribute("pollId", pollId);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/votingprocess.jsp");
		    rd.forward(request, response);
		}
	}
	private boolean checkVat(String vat){
		boolean valid = false;
		try{
			Integer.parseInt(vat);
		}
		catch(NumberFormatException e){
			valid = false;
			return valid;
		}
		if(vat.length() != 9)
		{
			valid = false;
			return valid;
		}
		int isum = 0;
		int idiv = 256;
		int inum = 0;
		int ires = 0;
		char c;
		for(int i = 0; i < vat.length()-1; i++)
		{
			c = vat.charAt(i);
			inum = Character.getNumericValue(c);
			isum = isum + (inum*idiv);
			idiv = idiv / 2;
		}
		ires = isum % 11;
		if(ires == 10) ires = 0;
		c = vat.charAt(8);
		inum = Character.getNumericValue(c);
		if(inum != ires){
			valid = false;
			return valid;
		}
		valid = true;
		return valid;
	}
	private boolean addVote(String pollID, String optID,String date){
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
			valid = true;
			con = ds.getConnection();
			con.setAutoCommit(false);
			String sql = "insert into votes(subjectID,detailsID,vDate) values (?,?,?);";
			stm = con.prepareStatement(sql);
			stm.setString(1, pollID);
			stm.setString(2, optID);
			stm.setString(3, date);
			stm.executeUpdate();
			con.commit();
		}
		catch (SQLException e){	
			e.printStackTrace();
			valid = false;
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
}
