// This file is part of the  NEMOLIB network motif library, which can be found at:
// https://github.com/drewandersen/nemolib
// Edits were made to the file to adapt it to the NMVis application

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import uwb.*;

public class NetworkMotifDetector {

	private static final double DEFAULT_ZSCORE = 2.0;
	private static final double DEFAULT_PVAL = 0.01;
	private static final int DEFAULT_NUMRANDGRAPHS = 1000;

	public static void main (String[] args) {

	private ArrayList<String> lines;
	private int inputMotifSize;
	private int inputNumRand;
	private double inputPVal; // will be set to 0.01 by default
	private double inputZScore; // will be set to 2.0 by default


	/* This constructor takes in a user input pVal and zScore */
	public NetworkMotifDetector(ArrayList<String> fileLines, int motifSize, int numRandGraphs, double pVal, double zScore) {
		lines = fileLines;
		inputMotifSize = motifSize;
		inputNumRand = numRandGraphs;
		inputPVal = pVal;
		inputZScore = zScore;
	}

	/*
	This constructor is the same as above but uses the default p-value and z-score
	*/
	public NetworkMotifDetector(ArrayList<String> fileLines, int motifSize) {
		lines = fileLines;
		inputMotifSize = motifSize;
		inputNumRand = DEFAULT_NUMRANDGRAPHS;
		inputPVal = DEFAULT_PVAL;
		inputZScore = DEFAULT_ZSCORE;

	}

	 /*
		This is a function for detecting the network motifs present in an input file.
		As of now, this function will only be used for testing purposes.
	 */
	private RelativeFrequencyAnalyzer runDetectorWithFile(String filename) {

		System.out.println("filename = " + filename);//args[0]);
		int motifSize = 3;//Integer.parseInt(args[1]);
		int randGraphCount = 1000;//Integer.parseInt(args[2]);

		if (motifSize < 3) {
			System.err.println("Motif getSize must be 3 or larger");
			System.exit(-1);
		}

		// Hard-code probs for now. This vector will take about ~10% sample
		List<Double> probs = new LinkedList<>();
		for (int i = 0; i < motifSize - 2; i++)
		{
			probs.add(1.0);
		}
		probs.add(1.0);
		probs.add(0.1);

		// parse input graph
		System.out.println("Parsing target graph...");
		Graph targetGraph = null;
		try {
			targetGraph = GraphParser.parse(filename);
		} catch (IOException e) {
			System.err.println("Could not process " + filename);
			System.err.println(e);
			System.exit(-1);
		}

		SubgraphEnumerationResult subgraphCount = new SubgraphCount();
		SubgraphEnumerator targetGraphESU = new ESU();
		TargetGraphAnalyzer targetGraphAnalyzer =
				new TargetGraphAnalyzer(targetGraphESU, subgraphCount);
		Map<String, Double> targetLabelToRelativeFrequency =
				targetGraphAnalyzer.analyze(targetGraph, motifSize);

		SubgraphEnumerator randESU = new RandESU(probs);
		RandomGraphAnalyzer randomGraphAnalyzer =
				new RandomGraphAnalyzer(randESU, randGraphCount);
		Map<String, List<Double>> randomLabelToRelativeFrequencies =
				randomGraphAnalyzer.analyze(targetGraph, motifSize);

		RelativeFrequencyAnalyzer relativeFrequencyAnalyzer =
				new RelativeFrequencyAnalyzer(randomLabelToRelativeFrequencies,
						targetLabelToRelativeFrequency);

		System.out.println(relativeFrequencyAnalyzer);

		System.out.println("Compete");
		return relativeFrequencyAnalyzer;
	}

	/**
	 * Use nemolib to detect the network motifs in the graphs and their data.
	 * This will use the data that is loded in in the lines array when the object is created
	 * @return ArrayList object containing motif frequency data
	 */
	public ArrayList<Motif> runDetector() {

		// TODO - motif size should have been checked prior to this, make sure this is the case
//		if (motifSize < 3) {
//			System.err.println("Motif getSize must be 3 or larger");
//			System.exit(-1);
//		}

		// Hard-code probs for now. This vector will take about ~10% sample (probs == probability??)
		List<Double> probs = new LinkedList<>();
		for (int i = 0; i < inputMotifSize - 2; i++)
		{
			probs.add(1.0);
		}
		probs.add(1.0);
		probs.add(0.1);

		// parse input graph
		System.out.println("Parsing target graph...");
		Graph targetGraph = null;
		try {
			targetGraph = GraphParser.parseGraphList(lines);
		} catch (IOException e) {
			// TODO - make it such that the error in a fashion that can be reported to user
			System.err.println("Could not process the input graph");
			System.err.println(e);
			System.exit(-1);
		}

		SubgraphEnumerationResult subgraphCount = new SubgraphCount();
		SubgraphEnumerator targetGraphESU = new ESU();
		TargetGraphAnalyzer targetGraphAnalyzer =
				new TargetGraphAnalyzer(targetGraphESU, subgraphCount);
		Map<String, Double> targetLabelToRelativeFrequency =
				targetGraphAnalyzer.analyze(targetGraph, inputMotifSize);

		SubgraphEnumerator randESU = new RandESU(probs);
		RandomGraphAnalyzer randomGraphAnalyzer =
				new RandomGraphAnalyzer(randESU, inputNumRand);
		Map<String, List<Double>> randomLabelToRelativeFrequencies =
				randomGraphAnalyzer.analyze(targetGraph, inputMotifSize);

		RelativeFrequencyAnalyzer relativeFrequencyAnalyzer =
				new RelativeFrequencyAnalyzer(randomLabelToRelativeFrequencies,
						targetLabelToRelativeFrequency);

		Map<String, Double> zScores = relativeFrequencyAnalyzer.getZScores();
		Map<String, Double> pValues = relativeFrequencyAnalyzer.getPValues();
		Map<String, Double> randFreq = relativeFrequencyAnalyzer.getRandMeans();
		Map<String, Double> origFreq = relativeFrequencyAnalyzer.getRelFreqs();
		Map<String, Double> stdDevsRand = relativeFrequencyAnalyzer.getRandStdDevs();

		ArrayList<Motif> allMotifs = new ArrayList<Motif>();
        // For each motif in found, make a motif object with all of the associated data
		for(String label : zScores.keySet()){
			Motif curMotif = new Motif(label, stdDevsRand.get(label), pValues.get(label), zScores.get(label), randFreq.get(label), origFreq.get(label));
			allMotifs.add(curMotif);
		}

		return allMotifs;
	}

}
