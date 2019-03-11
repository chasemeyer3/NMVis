import java.io.*; // InputStream
import java.util.HashMap;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

public class Motif {

    private String id;
    private Integer size;
    private Graph parentGraph;
    private Graph motifGraph;
    private double stdDev;
    private double pValue;
    private double zScore;
    private int count;
    private double freqRand;
    private double freqOrig;

    public Motif(){

    }
}
