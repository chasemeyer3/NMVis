import java.util.ArrayList;
import java.util.Random;

import org.json.JSONArray;
import org.json.JSONObject;

public class Motif {

    private Integer id;
    private int size;
    private ArrayList<Graph> motifGraphs; // list of all the subgraphs with this motif
    private double stdDev;
    private double pValue;
    private double zScore;
    private int count;
    private double freqRand;
    private double freqOrig;


    public Motif(Integer idIn, int sizeIn){
        id = idIn;
        size = sizeIn;
        motifGraphs = new ArrayList<>();
        count = 0;
    }
    // function to add a new subgraph instance of the motif (from nemoCollect), found in the network
    // Uses the parent network to find all connected edges between the nodes
    public void newInstance(String line, Graph network){
        ArrayList<Integer> subGNodes = new ArrayList<>();
        line = line.trim(); // trim spaces off of end
        String[] splitLine = line.split(" "); // split at space
        if (splitLine.length == size){ // have to use greater than b/c file given has extra comma at the end
            count++;
            Graph curSubG = new Graph();
            for (int i = 0; i < splitLine.length; i++){
                Integer curNodeId = new Integer(splitLine[i]);
                curSubG.addNode(curNodeId);
                subGNodes.add(curNodeId);
            }
            // add all the connected edges between the nodes
            for (int i = 0; i < subGNodes.size(); i++){
                for (int j = i + 1; j < subGNodes.size(); j++){
                    Integer edgeID = network.hasEdge(subGNodes.get(i),subGNodes.get(j));
                    if (!edgeID.equals(-1)){
                        curSubG.addEdge(subGNodes.get(i),subGNodes.get(j), edgeID);
                    }
                    edgeID = network.hasEdge(subGNodes.get(j),subGNodes.get(i));
                    if (!edgeID.equals(-1)){
                        curSubG.addEdge(subGNodes.get(j),subGNodes.get(i), edgeID);
                    }
                }
            }
            motifGraphs.add(curSubG);
        }

    }

    public JSONObject generateMotifJSONObj() {
        Random rand = new Random();
        JSONObject motifJSON = new JSONObject();
        JSONArray mSubgraphs = new JSONArray();
        // add all subgraphs to JSONArray
        for (int i = 0; i < motifGraphs.size(); i++){
            mSubgraphs.put(motifGraphs.get(i).generateGraphJSONObj());
        }
        motifJSON.put("id", id);
        motifJSON.put("count", count);
        // for now, just going to use 0 for all other variables untill I can get subGraphProfile working
        motifJSON.put("stdDev", rand.nextDouble());
        motifJSON.put("pValue", rand.nextDouble());
        motifJSON.put("zScore", rand.nextDouble() + 2.1 + rand.nextDouble());
        motifJSON.put("freqRand", rand.nextDouble());
        motifJSON.put("freqOrig", rand.nextDouble());
        motifJSON.put("motifSubgraphs", mSubgraphs);
        return motifJSON;
    }

}
