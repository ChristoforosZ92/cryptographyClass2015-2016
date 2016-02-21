package voting.pkg;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SelectPolls")
public class SelectPolls extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SelectPolls() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		GetPolls gp = new GetPolls();
		List<Poll> polls = gp.getAllPolls();
		request.setAttribute("listData", polls);
		request.setAttribute("isValid", true);
	    RequestDispatcher rd = getServletContext().getRequestDispatcher("/polls.jsp");
	    rd.forward(request, response);
	}

}
