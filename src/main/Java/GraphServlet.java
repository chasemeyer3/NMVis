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
        GraphService graphService;
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
        if (nemoFilePart != null){
            InputStream nemoFileData = nemoFilePart.getInputStream();
            graphService = new GraphService(reqGraph, nemoFileData, mSize);
        }
        else {
            graphService = new GraphService(reqGraph);
        }

        resp.setContentType("application/json");
        //req.setAttribute("graphJSON",reqGraph.generateJSON());

        //RequestDispatcher dispatcher = req.getRequestDispatcher("network.jsp");

        // this is for graph only - could be made into own API in the future
//        PrintWriter out = resp.getWriter();
//        out.print(reqGraph.generateGraphJSON());
//        out.flush();

        // for returning JSONObject that contains Graph and Motif data
        PrintWriter out = resp.getWriter();
        out.print(graphService.generateJSON());
        out.flush();

    }

}