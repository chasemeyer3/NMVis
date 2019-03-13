import org.json.JSONObject;
import org.json.JSONArray;

import java.io.*; // InputStream
import java.util.HashMap;
import java.util.Iterator;

public class GraphService {

    private Graph network; // the complete network
    private HashMap<Integer, Motif> motifs; // a list of all the motifs in the graph (from NemoCollect)

    // this is here for testing, will not really be used at this point
    public GraphService(Graph g){
        motifs = new HashMap<>();
        network = g;
    }

    // Constructor initializes the motif array and assigns all of the motifs found in
    public GraphService(Graph g, InputStream fileData, Integer motifSize){
        network = g;
        motifs = new HashMap<>();
        try (BufferedReader strReader = new BufferedReader(new InputStreamReader(fileData))){
            String line = null;
            Motif curMotif;
            while((line = strReader.readLine()) != null) {
                // three kinds of line possible (starts with "ID:", contains '\n' only, or contains comma and space separated nodes)
                if (line.length() == 0 || line.charAt(0) == '\n'){
                    continue;
                }
                else if (line.substring(0, 3).equals("ID:")){
                    line = line.replaceAll("\\s","");// remove all spaces
                    // check if motif exists
                    Integer id = Integer.parseInt(line.substring(3));
                    if (motifs.containsKey(id)){
                        // add to that motif if so
                        curMotif = motifs.get(id);
                    } else { // new motif
                        curMotif = new Motif(id, motifSize);
                        //add to hashmap
                        motifs.put(id, curMotif);
                    }
                    if ((line = strReader.readLine()) != null) {
                        line = line.replaceAll(",","");// remove all commas
                        curMotif.newInstance(line, g);
                    }
                }
            }
        } catch (IOException e){
            e.printStackTrace();
        }
    }

    // Get the JSON representation for the graph and the motifs in the graph
    public String generateJSON(){
        JSONObject graphMotifJSON = new JSONObject();
        graphMotifJSON.put("graph", network.generateGraphJSONObj());

        // make JSON array of Motif objects
        JSONArray motifsJSONArray = new JSONArray();
        for (Motif m : motifs.values()) {
            motifsJSONArray.put(m.generateMotifJSONObj());
        }
        graphMotifJSON.put("motifs", motifsJSONArray);

        return graphMotifJSON.toString();
    }

}