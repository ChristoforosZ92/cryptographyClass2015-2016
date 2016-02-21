package voting.pkg;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ShowResults")
public class ShowResults extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ShowResults() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pollId = request.getParameter("pollID");
		GetPolls gp = new GetPolls();
		Poll results = gp.getPollResults(pollId);
		request.setAttribute("pollData", results);
		request.setAttribute("isValid", true);
		request.setAttribute("pollId", pollId);
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/showResults.jsp");
	    rd.forward(request, response);
	}

}
