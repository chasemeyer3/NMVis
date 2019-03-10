import java.io.*; // InputStream
import java.util.HashMap;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

public class Graph {

    protected class Node {
        private Integer id;
        private ArrayList<Node> edges;
        private ArrayList<String> motifs; // ids of the motifs that the Node contains
        public Node(Integer idIn){
            edges = new ArrayList<Node>();
            motifs = new ArrayList<String>();
            id = idIn;
        }
        public void addEdge(Node newEdge){
            edges.add(newEdge);
        }
        public void addMotif(String newMotif){
            motifs.add(newMotif);
        }
        public ArrayList<String> getMotifs(){
            return motifs;
        }
        public ArrayList<Node> getEdges(){
            return edges;
        }
    }

    private int size;  // will be -1 if error occurs
    private HashMap<Integer, Node> nodes;
    private JSONArray edgesJSONArray;
    private JSONArray nodesJSONArray;

    public Graph(InputStream fileData){
        edgesJSONArray = new JSONArray();
        nodesJSONArray = new JSONArray();
        nodes = new HashMap<Integer, Node>();
        try (BufferedReader strReader = new BufferedReader(new InputStreamReader(fileData))){
            String line = null;
            while((line = strReader.readLine()) != null) {
                line = line.trim();
                String[] splitLine = line.split("\t");
                if (splitLine.length == 2){
                    Integer n1 = new Integer(splitLine[0]);
                    Integer n2 = new Integer(splitLine[1]);
                    addEdge(n1, n2);
                }
                else {
                    size = -1; // going to indicate an error occured
                    break;
                }

            }
        } catch (IOException e){
            e.printStackTrace();
        }
    }

    public Graph(String textData){
        edgesJSONArray = new JSONArray();
        nodesJSONArray = new JSONArray();
        String[] lines = textData.split("[\\r\\n]+");
        for (String line : lines){
            line = line.trim();
            String[] splitLine = line.split("\t");
            if (splitLine.length == 2){
                Integer n1 = new Integer(splitLine[0]);
                Integer n2 = new Integer(splitLine[1]);
                addEdge(n1, n2);
            }
            else {
                size = -1; // going to indicate an error occured
                break;
            }
        }
    }

    public Graph(){
        edgesJSONArray = new JSONArray();
        nodesJSONArray = new JSONArray();
        nodesJSONArray.put(new JSONObject().put("id", 0).put("label", "ERROR!!"));
    }

    // adds new edge from n1 to n2
    public void addEdge(Integer n1, Integer n2) {
        if (!nodes.containsKey(n1)){
            nodesJSONArray.put(new JSONObject().put("id", n1).put("label", "Protein " + n1.toString()));
            nodes.put(n1, new Node(n1));
            size++;
        }
        // add the new edge
        if (!nodes.containsKey(n2)){
            nodesJSONArray.put(new JSONObject().put("id", n2).put("label", "Protein " + n2.toString()));
            nodes.put(n2, new Node(n2));
            size++;
        }
        // adding to both so that either can be searched for edge
        edgesJSONArray.put(new JSONObject().put("from", n1).put("to", n2));
        nodes.get(n1).addEdge(nodes.get(n2));
        nodes.get(n2).addEdge(nodes.get(n1));
    }

    public String generateJSON() {
        JSONObject graphRep = new JSONObject().put("nodes", nodesJSONArray).put("edges", edgesJSONArray);
        return graphRep.toString();
    }
}