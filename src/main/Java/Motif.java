import java.io.*; // InputStream
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Iterator;

import org.json.JSONArray;
import org.json.JSONObject;

public class Motif {

    public class Subgraph extends Graph {


        public Subgraph() {
            //super();
        }
        public void addNode(Integer n) {
            nodes.put(n, new Node(n));
        }

    }

    private String id;
    private int size;
    private ArrayList<Subgraph> motifGraphs; // list of all the subgraphs with this motif
    private double stdDev;
    private double pValue;
    private double zScore;
    private int count;
    private double freqRand;
    private double freqOrig;


    public Motif(String idIn, int sizeIn){
        id = idIn;
        size = sizeIn;
        motifGraphs = new ArrayList<>();
        count = 0;
    }
    // function to add a new subgraph instance of the motif (from nemoCollect), found in the network
    // Uses the parent network to find all connected edges between the nodes
    public void newInstance(String line, Graph network){
        ArrayList<Integer> subGNodes = new ArrayList<>();
        String[] splitLine = line.split(","); // split at comma
        if (splitLine.length == size){
            count++;
            Subgraph curSubG = new Subgraph();
            for (int i = 0; i < size; i++){
                Integer curNodeId = new Integer(splitLine[i]);
                curSubG.addNode(curNodeId);
                subGNodes.add(curNodeId);
            }
            // add all the connected edges between the nodes
            for (int i = 0; i < subGNodes.size(); i++){
                for (int j = i + 1; j < subGNodes.size(); j++){
                    if (network.hasEdge(subGNodes.get(i),subGNodes.get(j))){
                        curSubG.addEdge(subGNodes.get(i),subGNodes.get(j));
                    }
                    if (network.hasEdge(subGNodes.get(j),subGNodes.get(i))){
                        curSubG.addEdge(subGNodes.get(j),subGNodes.get(i));
                    }
                }
            }
            motifGraphs.add(curSubG);
        }

    }

}
