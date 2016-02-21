package voting.pkg;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CreateNewPoll")
public class CreateNewPoll extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CreateNewPoll() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	    RequestDispatcher rd = getServletContext().getRequestDispatcher("/createPoll.jsp");
	    rd.forward(request, response);
	}

}
