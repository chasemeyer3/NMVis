import java.io.*;

import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;


@WebServlet(
        name = "Graph",
        urlPatterns = {"/graph"}
)

@MultipartConfig
public class GraphServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Graph reqGraph;
        String inputText = req.getParameter("graphData");
        if (inputText != null && !inputText.equals("")){
            reqGraph = new Graph(inputText);
        }
        else {
            Part filePart = req.getPart("graphFile");
            if (filePart != null){
                InputStream fileData = filePart.getInputStream();
                reqGraph = new Graph(fileData);
            }
            else {
                reqGraph = new Graph(); // will generate graph with one node that says "ERROR!", should never get here
            }
        }
        // get the input motif size
        Integer mSize = Integer.parseInt(req.getParameter("motifSize"));
        // get the nemoCollect File, this will be required for testing purposes
        Part nemoFilePart = req.getPart("nemoCollectFile");
        // TODO - should be checking for null here
        InputStream nemoFileData = nemoFilePart.getInputStream();
        GraphService graphService = new GraphService(reqGraph, nemoFileData, mSize); // not using this as of now

        resp.setContentType("application/json");
        //req.setAttribute("graphJSON",reqGraph.generateJSON());

        //RequestDispatcher dispatcher = req.getRequestDispatcher("network.jsp");

        // was using these for get but I think i have to use POST since I am using multipart form data
        PrintWriter out = resp.getWriter();
        out.print(reqGraph.generateJSON());
        out.flush();

        //dispatcher.forward(req, resp);
    }

}