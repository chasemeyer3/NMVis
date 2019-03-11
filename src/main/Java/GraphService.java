import java.io.*; // InputStream
import java.util.HashMap;
import java.util.ArrayList;

public class GraphService {

    private Graph network; // the complete network
    private HashMap<Integer, Motif> motifs; // a list of all the motifs in the graph (from NemoCollect)

    // Constructor initializes the motif array and assigns all of the motifs found in
    public GraphService(Graph g, InputStream fileData, int motifSize){
        network = g;
        motifs = new HashMap<>();
        try (BufferedReader strReader = new BufferedReader(new InputStreamReader(fileData))){
            String line = null;
            Motif curMotif;
            while((line = strReader.readLine()) != null) {
                line = line.replaceAll("\\s","");// remove all spaces
                // three kinds of line possible (starts with "ID:", contains '\n' only, or contains comma separated nodes)
                if (line.substring(0, 3).equals("ID:")){
                    // check if motif exists
                    if (motifs.containsKey(line.substring(3))){
                        // add to that motif if so
                        curMotif = motifs.get(line.substring(3));
                    } else { // new motif
                        curMotif = new Motif(line.substring(3), motifSize);
                    }
                    if ((line = strReader.readLine()) != null) {
                        line = line.replaceAll("\\s","");// remove all spaces
                        curMotif.newInstance(line, g);
                    }
                }
            }
        } catch (IOException e){
            e.printStackTrace();
        }
    }

    // Get the JSON representation for the graph and the motifs


}