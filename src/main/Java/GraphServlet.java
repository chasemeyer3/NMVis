import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.util.ArrayList;

@WebServlet(
        name = "Graph",
        urlPatterns = {"/graph"}
)

@MultipartConfig
public class GraphServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JSONGraph reqGraph;
        GraphService graphService;
        NetworkMotifDetector motifDetector;
        String inputText = req.getParameter("graphData");

        // get input p-value and z-score
        Double inputPVal = Double.parseDouble(req.getParameter("pVal"));
        Double inputZScore = Double.parseDouble(req.getParameter("zScore"));
        // get the input motif size and number of random graphs
        Integer mSize = Integer.parseInt(req.getParameter("motifSize"));
        Integer numRandGraphs = Integer.parseInt(req.getParameter("numRand"));

        // if the input is String representation of graph
        if (inputText != null && !inputText.equals("")){
            reqGraph = new JSONGraph(inputText);
        }
        // if a file with the graph info was input
        else {
            Part filePart = req.getPart("graphFile");
            if (filePart != null){
                InputStream fileData = filePart.getInputStream();
                reqGraph = new JSONGraph(fileData);
            }
            else {
                reqGraph = new JSONGraph(); // will generate graph with one node that says "ERROR!", should never get here
            }
        }
        /* Getting the Network motif detection results here */
        // check for input zScore or pVal considerations - should always have some value here since frontend uses default; here for error checking.
        if (inputPVal != null && inputZScore != null && numRandGraphs != null && inputPVal > 0 && inputZScore > 0 && numRandGraphs > 0) {
            motifDetector = new NetworkMotifDetector(reqGraph.getLines(), mSize, numRandGraphs, inputPVal, inputZScore);
        }
        // use the default p-value, z-score and numRandGraph values if the above parameter checks don't pass
        else {
            motifDetector = new NetworkMotifDetector(reqGraph.getLines(), mSize);
        }

        // run the detector to get all of the frequency data
        ArrayList<Motif> motifs = motifDetector.runDetector();

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

        // for returning JSONObject that contains Graph and Motif data
        PrintWriter out = resp.getWriter();
        out.print(graphService.generateJSON());
        out.flush();

    }

}