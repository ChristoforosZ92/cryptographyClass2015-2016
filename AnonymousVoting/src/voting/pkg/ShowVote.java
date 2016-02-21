package voting.pkg;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ShowVote")
public class ShowVote extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ShowVote() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("pollID");
		GetPolls gp = new GetPolls();
		Poll poll = gp.getPoll(id);
		request.setAttribute("pollData", poll);
		request.setAttribute("pollId", id);
	    RequestDispatcher rd = getServletContext().getRequestDispatcher("/votingprocess.jsp");
	    rd.forward(request, response);
	}

}
