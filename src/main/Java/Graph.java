import java.io.*; // InputStream
import java.util.HashMap;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

public class Graph {

    protected class Node {
        private Integer id;
        // edge index has edgeID at corresponding index in edgeIDs
        private ArrayList<Node> edges;
        private ArrayList<Integer> edgeIDs;

        public Node(Integer idIn){
            edges = new ArrayList<Node>();
            edgeIDs = new ArrayList<Integer>();
            id = idIn;
        }
        public void addEdge(Node newEdge, Integer eID){
            edges.add(newEdge);
            edgeIDs.add(eID);
        }

        public Integer hasEdge(Integer id) {
            for (int i = 0; i < edges.size(); i++){
                if (edges.get(i).getID().equals(id)){
                    // returns edgeID
                    return edgeIDs.get(i);
                }
            }
            return -1;
        }

        public Integer getID(){
            return id;
        }

        public ArrayList<Node> getEdges(){
            return edges;
        }
    }

    private int size;  // will be -1 if error occurs
    protected HashMap<Integer, Node> nodes;
    protected JSONArray edgesJSONArray;
    protected JSONArray nodesJSONArray;

    public Graph(InputStream fileData){
        // TESTING: calling exe from here
        //Runtime runtimeProcess = Runtime.getRuntime().exec("D:\\\\test\\NemoLib.exe", null, new File("c:\\program files\\test\\"));
        //int processComplete = runtimeProcess.waitFor();
        Integer edgeID = 0; // unique id assigned to each edge (for color changing in vis.js), will be same as motif edge
        edgesJSONArray = new JSONArray();
        nodesJSONArray = new JSONArray();
        nodes = new HashMap<Integer, Node>();
        try (BufferedReader strReader = new BufferedReader(new InputStreamReader(fileData))){
            String line = null;
            while((line = strReader.readLine()) != null) {
                if (line.charAt(0) == '\n'){
                    continue;
                }
                line = line.trim();
                String[] splitLine = line.split("\t");
                if (splitLine.length == 2){
                    Integer n1 = new Integer(splitLine[0]);
                    Integer n2 = new Integer(splitLine[1]);
                    addEdge(n1, n2, edgeID);
                    edgeID++;
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
        Integer edgeID = 0;
        edgesJSONArray = new JSONArray();
        nodesJSONArray = new JSONArray();
        nodes = new HashMap<Integer, Node>();
        String[] lines = textData.split("[\\r\\n]+");
        for (String line : lines){
            line = line.trim();
            String[] splitLine = line.split("\t");
            if (splitLine.length == 2){
                Integer n1 = new Integer(splitLine[0]);
                Integer n2 = new Integer(splitLine[1]);
                addEdge(n1, n2,edgeID);
                edgeID++;
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
        nodes = new HashMap<Integer, Node>();
    }

    // to add a node to the graph without adding edges (used by the Motif class)
    public void addNode(Integer n) {
        if (!nodes.containsKey(n)){
            nodesJSONArray.put(new JSONObject().put("id", n).put("label", "Protein " + n.toString()));
            nodes.put(n, new Node(n));
            size++;
        }
    }

    // adds new edge from n1 to n2, edgeID is unique and also the index in the array list of edges
    public void addEdge(Integer n1, Integer n2, Integer eID) {
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
        edgesJSONArray.put(new JSONObject().put("from", n1).put("to", n2).put("id", eID));
        nodes.get(n1).addEdge(nodes.get(n2), eID);
        //nodes.get(n2).addEdge(nodes.get(n1)); // might want this later but will make it not work for directed graph
    }

    public String generateGraphJSON() {
        JSONObject graphRep = new JSONObject().put("nodes", nodesJSONArray).put("edges", edgesJSONArray);
        return graphRep.toString();
    }

    public JSONObject generateGraphJSONObj() {
        return new JSONObject().put("nodes", nodesJSONArray).put("edges", edgesJSONArray);
    }

    // returns -1 if the edge does not exist or the id of the edge if it does
    public Integer hasEdge(Integer n1, Integer n2){
        if (nodes.containsKey(n1) && nodes.containsKey(n2)) {
            // returns edgeID
            return nodes.get(n1).hasEdge(n2);
        }
        return -1;
    }
}