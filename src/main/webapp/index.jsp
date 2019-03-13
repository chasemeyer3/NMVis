<!-- Chase Meyer - NMVis -->

<%-- For vis.js software:
Copyright (C) 2010-2017 Almende B.V.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.--%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="Description" content="A web-based network motif visualization tool.">
    <meta name="keywords" content="Chase Meyer, Network Motif, Bioinformatics, Visualization, NMVis, Network Motif Visualization">
    <meta name="theme-color" content="#2B2B2B"/>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="./nmvis.css" >

    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
    <!-- Flavicon -->
    <%-- <link rel="icon" type="image/ico" href="flav.ico" >
    <link rel="shortcut icon" type="image/ico" href="flav.ico" > --%>
    <!-- Title shown on tab -->
    <title>NMVis</title>
    <!-- Jquery - Microsoft CDN -->
    <%-- <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script> --%>
    <!-- vis.js -->
    <%-- <script src="./exampleGraphJSON.js"></script> --%>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css" rel="stylesheet" type="text/css">

    <%-- For Jstl support --%>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

  </head>

  <!-- Scrollspy is used to track users position of the page and automatically highlight
       the corresponding nav bar element to indicate the section currently displayed. -->
  <body>
    <div class="container-fluid">
      <header>
        <h1>Welcome to NMVis!</h1>
        <br>
        <h3>NMVis is a visualization tool for network motifs.</h3>
      </header>
    </div>

    <div class="container">

      <h3>To get started, simply paste the motif and network data from your graph into the box below and click "Show Network Motifs".</h3>
      <h4>The format of supplied data can be found <a href="#">here</a>.</h4>
      <h4>If you are new to the site and want to learn more click <a href="#">here</a>.</h4>

      <form id="dataForm" action="https://nmvis.azurewebsites.net/graph" method="post" enctype="multipart/form-data" roll="form">
        <textarea name="graphData" class="textInput" id="graphData" rows="8" cols="80" value="" placeholder="Paste network data here"></textarea>

        <div class="uploadFile">
          <label for="graphFile">Or, upload a file containing the network data in a valid format:</label>
          <input class="form-control-file" name="graphFile" id="graphFile" type="file" accept=".txt">

          <%-- file upload for nemoCollect for testing purposes --%>
          <label for="nemoCollectFile">Upload a file containing the nemoCollect data in its valid format:</label>
          <input class="form-control-file" name="nemoCollectFile" id="nemoCollectFile" type="file" accept=".txt" required>
        </div>

        <br>
        <%-- Select desired motif options for size and number of random subgraphs generated --%>
        <div class="optionsGroup row">
          <div class="col">
            <label for="motifSize">Select the Motif Size: </label>
            <select class="form-control" name="motifSize" id="motifSize">
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
            </select>
          </div>
          <div class="col">
            <%-- For specifying number of random graphs to generate --%>
            <label for="numRand">Number of Random Graphs Generated: </label>
            <input class="form-control" type="text" name="numRand" id="numRand" value="1000">
          </div>
        </div>

        <br>
        <%-- Checkbox to specify if full graph should be displayed --%>
        <%-- <input type="checkbox" id="displayGraphCB" name="displayGraphCB" aria-label="Checkbox for displaying full graph. This is not suggested for graphs over 500 nodes."> Select to display full graph. This is not recommended for graphs over 500 nodes, as it will be slow to render.<br> --%>

        <button class="btn btn-lg btn-primary btn-block" id="submitButton" type="button" onclick="submitForm()">Show Network Motifs</button>

      </form>

    </div>

    <%-- <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner">
        <div class="carousel-item active">
          <div class="container d-block w-100" id="visBox"></div>
        </div>
        <div class="carousel-item">
          <div class="container d-block w-100" id="visBox"></div>
        </div>
        <div class="carousel-item">
          <img src="..." class="d-block w-100" alt="...">
        </div>
      </div>
      <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        <i class="fa fa-chevron-left"></i>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <i class="fa fa-chevron-right"></i>
        <span class="sr-only">Next</span>
      </a>
    </div> --%>

    <%-- Code for loader and Graph box, which shows if requested by user --%>
    <br>
    <div id="loaderDiv">
      <div id="loader"></div>
    </div>

    <div class="container" id="progressBarBox">
      <h3>Loading Graph...</h3>
      <div id="myProgress">
        <div id="myProgressBar">0%</div>
      </div>
    </div>

    <div class="container animate-bottom" id="graphDisplayBox">
      <label for="showGraphBtn">Network Motifs Generated! Would you like to display the entire graph?</label>
      <br>
      <button type="button" class="btn btn-primary btn-lg btn-block" id="showGraphBtn" onclick="generateGraph()">Yes! Display the Graph</button>
      <br>
      *This is not recommended for graphs over 1000 nodes, as they can take a while to render.
    </div>

    <div class="container" id="myVisBox"></div>

    <section id="motifs">
      <div class="container" id="motifCards">
        <h2>Motifs Found</h2>
        <div class="row justify-content-center no-gutters">
          <div class="col-sm-12 col-md-6 col-lg-4">
            <div class="card border-secondary m-2" id="card0">
              <h5 id="cardID0">ID: 234</h5>
              <div class="mCard" id="motifGraph0"></div>
              <table id="motifTable0">
                <tr>
                  <th>Count</th>
                  <th>Standard Deviation</th>
                </tr>
                <tr>
                  <td id="mCount0">20</td>
                  <td id="mStdDev0">0.0007112</td>
                </tr>
                <tr>
                  <th>Frequency [Original]</th>
                  <th>P-Value</th>
                </tr>
                <tr>
                  <td id="mFreq0">0.54281%</td>
                  <td id="pVal0">0.004</td>
                </tr>
                <tr>
                  <th>Frequency [Random]</th>
                  <th>Z-Score</th>
                </tr>
                <tr>
                  <td id="randFreq0">0.23379%</td>
                  <td id="zScore0">4.3452</td>
                </tr>
              </table>
              <button type="button" class="btn btn-primary btn-sm" id="btnCard" onclick="highlightInGraph(0, 0);">Show in Graph</button>
            </div>
            <div class="card border-secondary m-2" id="card1">
              <h5 id="cardID1">ID: 234</h5>
              <div class="mCard" id="motifGraph1"></div>
              <table id="motifTable1">
                <tr>
                  <th>Count</th>
                  <th>Standard Deviation</th>
                </tr>
                <tr>
                  <td id="mCount1">20</td>
                  <td id="mStdDev1">0.0007112</td>
                </tr>
                <tr>
                  <th>Frequency [Original]</th>
                  <th>P-Value</th>
                </tr>
                <tr>
                  <td id="mFreq1">0.54281%</td>
                  <td id="pVal1">0.004</td>
                </tr>
                <tr>
                  <th>Frequency [Random]</th>
                  <th>Z-Score</th>
                </tr>
                <tr>
                  <td id="randFreq1">0.23379%</td>
                  <td id="zScore1">4.3452</td>
                </tr>
              </table>
              <button type="button" class="btn btn-primary btn-sm" id="btnCard" onclick="highlightInGraph(0, 1);">Show in Graph</button>
            </div>
          </div>
          <div class="col-sm-12 col-md-6 col-lg-4">
            <div class="card border-secondary m-2" id="card2">
              <h5 id="cardID2">ID: 234</h5>
              <div class="mCard" id="motifGraph2"></div>
              <table id="motifTable2">
                <tr>
                  <th>Count</th>
                  <th>Standard Deviation</th>
                </tr>
                <tr>
                  <td id="mCount2">20</td>
                  <td id="mStdDev2">0.0007112</td>
                </tr>
                <tr>
                  <th>Frequency [Original]</th>
                  <th>P-Value</th>
                </tr>
                <tr>
                  <td id="mFreq2">0.54281%</td>
                  <td id="pVal2">0.004</td>
                </tr>
                <tr>
                  <th>Frequency [Random]</th>
                  <th>Z-Score</th>
                </tr>
                <tr>
                  <td id="randFreq2">0.23379%</td>
                  <td id="zScore2">4.3452</td>
                </tr>
              </table>
              <button type="button" class="btn btn-primary btn-sm" id="btnCard" onclick="highlightInGraph(0, 2);">Show in Graph</button>
            </div>
            <div class="card border-secondary m-2" id="card3">
              <h5 id="cardID3">ID: 234</h5>
              <div class="mCard" id="motifGraph3"></div>
              <table id="motifTable3">
                <tr>
                  <th>Count</th>
                  <th>Standard Deviation</th>
                </tr>
                <tr>
                  <td id="mCount3">20</td>
                  <td id="mStdDev3">0.0007112</td>
                </tr>
                <tr>
                  <th>Frequency [Original]</th>
                  <th>P-Value</th>
                </tr>
                <tr>
                  <td id="mFreq3">0.54281%</td>
                  <td id="pVal3">0.004</td>
                </tr>
                <tr>
                  <th>Frequency [Random]</th>
                  <th>Z-Score</th>
                </tr>
                <tr>
                  <td id="randFreq3">0.23379%</td>
                  <td id="zScore3">4.3452</td>
                </tr>
              </table>
              <button type="button" class="btn btn-primary btn-sm" id="btnCard" onclick="highlightInGraph(0, 3);">Show in Graph</button>
            </div>
          </div>
          <div class="col-sm-12 col-md-6 col-lg-4">
            <div class="card  border-secondary m-2" id="card4">
              <h5 id="cardID4">ID: 234</h5>
              <div class="mCard" id="motifGraph4"></div>
              <table id="motifTable4">
                <tr>
                  <th>Count</th>
                  <th>Standard Deviation</th>
                </tr>
                <tr>
                  <td id="mCount4">20</td>
                  <td id="mStdDev4">0.0007112</td>
                </tr>
                <tr>
                  <th>Frequency [Original]</th>
                  <th>P-Value</th>
                </tr>
                <tr>
                  <td id="mFreq4">0.54281%</td>
                  <td id="pVal4">0.004</td>
                </tr>
                <tr>
                  <th>Frequency [Random]</th>
                  <th>Z-Score</th>
                </tr>
                <tr>
                  <td id="randFreq4">0.23379%</td>
                  <td id="zScore4">4.3452</td>
                </tr>
              </table>
              <button type="button" class="btn btn-primary btn-sm" id="btnCard" onclick="highlightInGraph(0, 4);">Show in Graph</button>
            </div>
            <div class="card border-secondary m-2" id="card5">
              <h5 id="cardID5">ID: 234</h5>
              <div class="mCard" id="motifGraph5"></div>
              <table id="motifTable5">
                <tr>
                  <th>Count</th>
                  <th>Standard Deviation</th>
                </tr>
                <tr>
                  <td id="mCount5">20</td>
                  <td id="mStdDev5">0.0007112</td>
                </tr>
                <tr>
                  <th>Frequency [Original]</th>
                  <th>P-Value</th>
                </tr>
                <tr>
                  <td id="mFreq5">0.54281%</td>
                  <td id="pVal5">0.004</td>
                </tr>
                <tr>
                  <th>Frequency [Random]</th>
                  <th>Z-Score</th>
                </tr>
                <tr>
                  <td id="randFreq5">0.23379%</td>
                  <td id="zScore5">4.3452</td>
                </tr>
              </table>
              <button type="button" class="btn btn-primary btn-sm" id="btnCard" onclick="highlightInGraph(0, 5);">Show in Graph</button>
            </div>
          </div>
        </div>

        <div class="btnPageGroup">
          <button type="button" class="btn btn-lg btn-primary" id="prevPageBtn" onclick="pgBack()" disabled><</button>
          <button type="button" class="btn btn-lg btn-primary" id="nextPageBtn" onclick="pgFwd()" disabled>></button>
        </div>
      </div>
    </section>


    <script type="text/javascript">

      var jsonData;
      var curPage = 0;
      var index; // index of motif cards, for pages
      var graphDisplayed = false;
      var nodes;  // nodes and edges DataSet Obj for network, global for manipulation with motif data
      var edges;
      var curHLCard = -1; // current hightlighted card, -1 if none highlighted. Used to readjust colors
      var curHLIndex = -1;
      var network;

      // this function will highlight the motifs in the graph and zoom in on them
      // curMotifIndex is the index in the motifSubgraphs array that is next to be highlighted
      function highlightInGraph(cardNum, curMotifIndex){
        // first display the full network if it is not displayed
        if (graphDisplayed == false){
          generateGraph();
        }
        // unhighlight nodes/edges currently highlighted
        if (curHLCard != -1 /*&& curHLIndex != -1*/){ // should both be -1 at same time always
          unhighlightLast(curHLCard, curHLIndex);
          // going to assume here that if the above are -1 that the user view is likely on the
          // motif cards (as they wouldv'e just clicked those buttons) and therefore,
          // need to move the view to look at the graph. Doing this here
          document.getElementById("myVisBox").scrollIntoView();
        }
        // get the specific motif array
        var motifArr = jsonData.motifs[index + cardNum].motifSubgraphs[curMotifIndex];
        var nodesToFocus = [];
        for (i = 0; i < motifArr.edges.length; i++){
          console.log("changing edge:" + motifArr.edges[i].id);
          edges.update({id: motifArr.edges[i].id, color: {color: 'green'}});
        }
        for (i = 0; i < motifArr.nodes.length; i++){
          nodesToFocus.push(motifArr.nodes[i].id);
          console.log("changing node color of node :" + motifArr.nodes[i].id);
          nodes.update({id: motifArr.nodes[i].id, color: 'green'});
        }

        // now zoom the graph to the specific nodes
        //network.fit({nodes: [nodesToFocus]});

        curHLCard = cardNum;
        curHLIndex = curMotifIndex;
      }

      function unhighlightLast(cardNum, lastMotifIndex){
        // get the specific motif array
        var motifArr = jsonData.motifs[index + cardNum].motifSubgraphs[lastMotifIndex];

        for (i = 0; i < motifArr.edges.length; i++){
          edges.update({id: motifArr.edges[i].id, color: {color: '#848484'}});
        }
        // change node color back
        for (i = 0; i < motifArr.nodes.length; i++){
          nodes.update({id: motifArr.nodes[i].id, color: {border: '#2B7CE9', background: '#D2E5FF'}});
        }

        curHLCard = -1;
        curHLIndex = -1;
      }

      function pgBack() {
        populateCardsPage(-1);
        // if any motifs highlighed, unhighlight them first
        if (curHLCard != -1 && curHLIndex != -1){
          unhighlight(curHLCard, curHLIndex);
        }
      }

      function pgFwd() {
        populateCardsPage(1);
        // if any motifs highlighed, unhighlight them first
        if (curHLCard != -1 && curHLIndex != -1){
          unhighlight(curHLCard, curHLIndex);
        }
      }
      // will display the cards div and populate it with the motif data recieved
      // from the JSON response
      // ASSUMES: nemoCollectFile was provided and submitForm() has been called
      // to get jsonData
      // move = -1 will mean moving back a page, move = 1 moving forward a page,
      // and move = 0 is populating page for first time
      function populateCardsPage(move) {
        if (move == 0) {
          curPage++;
          index = 0; // starting index
        }
        if (move == -1){
          curPage--;
          index -= 6; // starting index
        }
        if (move == 1){
          curPage++;
          index += 6; // starting index
        }
        var motifs = jsonData.motifs;
        var curIndex = 0;
        // enable/disable prev/next button depending on index
        if (index >= 6){
          document.getElementById("prevPageBtn").disabled = false;
        } else {
          document.getElementById("prevPageBtn").disabled = true;
        }
        if (motifs.length > index + 6) {
          document.getElementById("nextPageBtn").disabled = false;
        } else {
          document.getElementById("nextPageBtn").disabled = true;
        }

        // 6 cards per page
        while (index + curIndex < motifs.length  && curIndex < 6){
          var curMotif = motifs[curIndex];
          var curCardGraphDiv = document.getElementById("motifGraph" + curIndex);
          // since they should all be the same, displaying first subgraph
          generateMotifGraph(curMotif.motifSubgraphs[0].nodes, curMotif.motifSubgraphs[0].edges, curCardGraphDiv);
          populateMotifCard(curIndex, curMotif);
          curIndex++;
        }

        // make any cards that aren't populated with data not displayed
        for (i = curIndex; i < 6; i++){
          document.getElementById("card" + i).style.display = 'none';
        }

      }

      // this function takes the card index and motif JSON data and populates the card
      // TODO - would be best to template entire card but no time for now
      function populateMotifCard(i, motif){
        var curCardGraphDiv = document.getElementById("motifGraph" + i);
        // since they should all be the same, displaying first subgraph
        generateMotifGraph(motif.motifSubgraphs[0].nodes, motif.motifSubgraphs[0].edges, curCardGraphDiv);
        document.getElementById("motifGraph" + i);
        document.getElementById("cardID" + i).innerHTML = "ID: " + motif.id;
        document.getElementById("mCount" + i).innerHTML = motif.count;
        document.getElementById("mStdDev" + i).innerHTML = motif.stdDev;
        document.getElementById("mFreq" + i).innerHTML = motif.freqOrig;
        document.getElementById("pVal" + i).innerHTML = motif.pValue;
        document.getElementById("randFreq" + i).innerHTML = motif.freqRand;
        document.getElementById("zScore" + i).innerHTML = motif.zScore;
      }

      // Function will generate vis.js graph for the motif cards
      function generateMotifGraph(mNodes, mEdges, graphDiv){
        // make delet label since it can be for multiple subgraphs
        for (i = 0; i < mNodes.length; i++){
          mNodes[i].label = "";
        }

        var nodesMG = new vis.DataSet(mNodes);
        var edgesMG = new vis.DataSet(mEdges);

        // provide the data in the vis format
        var data = {
            nodes: nodesMG,
            edges: edgesMG
        };

        var options = {
          nodes: {
            color: {
              //background: 'orange',
              border: 'black'
            }
          }
        };

        // initialize network
        var nwkMotifCard = new vis.Network(graphDiv, data, options);
      }

      // to display the progress bar (if passed true), or not display (if passed false)
      function showProgress(display){
        var progBox = document.getElementById("progressBarBox");
        if (display){
          progBox.style.display = 'block';
          // move down to this position on the page
          progBox.scrollIntoView();
        }
        else {
          progBox.style.display = 'none';
        }
      }

      // to display the loading indicator (if passed true), or not display (if passed false)
      function showLoading(display) {
        var loadIndicator = document.getElementById("loaderDiv");
        if (display){
          loadIndicator.style.display = "block";
          // move down to this position on the page
          loadIndicator.scrollIntoView();
        } else {
          loadIndicator.style.display = "none";
        }
        console.log("finished showLoading " + display);
      }

      function checkNumRandGraphs() {
        var numInput = document.getElementById("numRand").value;
        if (numInput == 0 || numInput == "") {
          alert("Please enter a valid number of random graphs to generate. The default of 1000 will be used if 0 or nothing is entered.");
          numInput = 1000;
          return false;
        }
        if (numInput < 100) {
          if (!confirm("Generating less than 100 subgraphs will likely mean that results are in insugnificant. Please confirm if this is okay.")){
            // if not confirmed, go back to default
            numInput = 100;
            return false;
          }
          return true;
        }
        if (numInput > 1500) {
          alert("This tool currently only supports a maximum of 1500 random subgraphs, though 1000 random graphs will typically produce significant results. Sorry for the inconvenience.");
          numInput = 1500;
          return false;
        }
        return true;
      }

      function validateForm() {
        // check that vaild number of subgraphs was input
        if (!checkNumRandGraphs()){
          return false;
        }
        // check if file was input
        if (document.getElementById("graphFile").files.length != 0){
          var inFile = document.getElementById("graphFile").files[0];
          // going to check that the file size is within limits
          if (inFile.size > 100000){  // limit is 100 KB -> 100000 bytes
            alert("The provided file is too large. Text file with graph data should be 100 KB or less. Graphs this large are difficult to visualize, we're sorry for the inconvenience.");
            return false;
          }
          return true;
        } else if (document.getElementById("graphData").value != ""){
          return true;
        } else {
          // if no file or text input, alert user
          alert("Please input a file or input graph data.");
          return false;
        }
      }

      function generateGraph() {

        // hide the user prompt
        document.getElementById("graphDisplayBox").style.display = 'none';

        // show loading screen
        showProgress(true);
        console.log("in generate Graph");
        // create an array with nodes
        nodes = new vis.DataSet(jsonData.graph.nodes);
        edges = new vis.DataSet(jsonData.graph.edges);
        // create a network
        var container = document.getElementById('myVisBox');
        // provide the data in the vis format
        var data = {
            nodes: nodes,
            edges: edges
        };
        //console.log(data);
        var options = {
          nodes : {
            color: {border: '#2B7CE9', background: '#D2E5FF'}
          },
          edges: {
            color: {
              color: '#848484',
              inherit: false
            }
          }
        };

        // initialize your network!
        console.log("about to initialize the network");
        network = new vis.Network(container, data, options);

        // for large graphs, disable smooth curves
        if (edges.length > 500) {
          network.setOptions({edges:{smooth:{type:'continuous'}}});
        }

        console.log("done initializing network");
        var progBar = document.getElementById('myProgressBar');

        network.on("stabilizationProgress", function(params) {
          var widthFactor = params.iterations/params.total;
          //var width = Math.max(minWidth,maxWidth * widthFactor);
          console.log("in stabilization, width is  :");
          console.log(widthFactor * 100);
          progBar.style.width = widthFactor * 100 + '%';
          progBar.innerHTML = Math.round(widthFactor*100) + '%';
        });

        network.once("stabilizationIterationsDone", function() {
          progBar.innerHTML = '100%';
          progBar.style.width = '100%';
          showProgress(false);
          // display the graph div
          document.getElementById("myVisBox").style.display = 'block';
          document.getElementById("myVisBox").scrollIntoView();
          graphDisplayed = true;
        });

      }

      function submitForm() {
        if (validateForm()) {
          // disable the button after it is clicked and the form is validated
          // to prevent multiple requests to the server.
          var formBtn = document.getElementById("submitButton");
          formBtn.disabled = "disabled";

          showLoading(true);
          console.log("Getting to showLoading!");
          var request = new XMLHttpRequest();
          // Open a new connection, using the GET request on the URL endpoint
          request.open('POST', 'https://nmvis.azurewebsites.net/graph', true);

          request.onload = function () {
            jsonData = JSON.parse(this.response);

            showLoading(false);
            console.log("finishedProcessing request!");
            // display the button to ask if user wants to show the graph
            document.getElementById("graphDisplayBox").style.display = 'block';
            // Show the network motifs found
            populateCardsPage(0);
            var mCardsView = document.getElementById("motifCards");
            mCardsView.style.display = 'block';
          }
          console.log("Doing request.");
          var formData = new FormData(document.getElementById("dataForm"));
          // send the request
          request.send(formData);
        }
      }

      // document.getElementById('submitButton').onclick =
      //   function(e){
      //
      //     var request = new XMLHttpRequest();
      //
      //     // Open a new connection, using the GET request on the URL endpoint
      //     request.open('POST', 'https://nmvis.azurewebsites.net/graph', true);
      //
      //     request.onload = function () {
      //       // Begin accessing JSON data here
      //       var data = JSON.parse(this.response);
      //
      //       const respP = document.createElement('p');
      //       respP.value = data;
      //
      //     }
      //
      //     // send the request
      //     request.send();
      //
      //
      //     var nodeSet = new Set();
      //     var edges = [];
      //     var nodes = [];
      //     // check if a file was input, if so use the file
      //     if (document.getElementById("graphFile").files.length != 0){
      //       var inFile = document.getElementById("graphFile").files[0];
      //       // going to check that the file size is within limits
      //       if (inFile.size > 100000){  // limit is 100 KB -> 100000 bytes
      //         alert("The provided file is too large. Text file with graph data should be 100 KB or less. Graphs this large are difficult to visualize, we're sorry for the inconvenience.");
      //         return;
      //       }
      //       // if the file size is very small, the browser will display the inital graph
      //       else if (inFile.size < 5000){
      //         const reader = new FileReader();
      //         // reader will call this onload callback when it has finished reading the file
      //         reader.onload = function () {
      //           reader.result.split('\n').map(function (line) {
      //             line.trim();
      //             const curLine = line.split('\t');
      //             if (curLine.length == 2){
      //               var fromInt = parseInt(curLine[0]);
      //               var toInt = parseInt(curLine[1]);
      //               // if key not in set, add it
      //               if (!nodeSet.has(fromInt)){
      //                 nodeSet.add(fromInt);
      //                 //nodes.push({id: fromInt, label: 'Protein ' + curLine[0]});
      //                 nodesTest.add([{id: fromInt, label: 'Protein ' + curLine[0]}]);
      //               }
      //               if (!nodeSet.has(toInt)) {
      //                 nodeSet.add(toInt);
      //                 //nodes.push({id: toInt, label: 'Protein ' + curLine[1]});
      //                 nodesTest.add([{id: toInt, label: 'Protein ' + curLine[1]}]);
      //               }
      //               // add the edge to the edge array
      //               edgesTest.add([{from: fromInt, to: toInt}]);
      //               //edges.push({from: fromInt, to: toInt});
      //             }
      //           });
      //         }
      //         reader.readAsText(inFile);
      //       }
      //       // else the server needs to process the data, will return JSON
      //       else {
      //         var request = new XMLHttpRequest();
      //
      //         // Open a new connection, using the GET request on the URL endpoint
      //         request.open('GET', 'https://nmvis.azurewebsites.net/graph', true);
      //
      //         request.onload = function () {
      //           // Begin accessing JSON data here
      //           var data = JSON.parse(this.response);
      //
      //           const respP = document.createElement('p');
      //           respP.value = data;
      //
      //         }
      //         // send the request
      //         request.send();
      //       }
      //
      //   }
      //   // else check if graph data was pasted in
      //   else if (document.getElementById("graphData").value != ""){
      //     // TODO - validate format here first
      //     var text = document.getElementById("graphData").value;
      //     text.split('\n').map(function (line) {
      //       line.trim();
      //       const curLine = line.split('\t');
      //       if (curLine.length == 2){
      //         var fromInt = parseInt(curLine[0]);
      //         var toInt = parseInt(curLine[1]);
      //         // if key not in set, add it
      //         if (!nodeSet.has(fromInt)){
      //           nodeSet.add(fromInt);
      //           nodes.push({id: fromInt, label: "Protein " + curLine[0]});
      //         }
      //         if (!nodeSet.has(toInt)) {
      //           nodeSet.add(toInt);
      //           nodes.push({id: toInt, label: "Protein " + curLine[1]});
      //         }
      //         // add the edge to the edge array
      //         edges.push({from: fromInt, to: toInt});
      //       }
      //     });
      //   }
      //   else {
      //     alert("No graph was inserted. Please add file or paste network in correct format.");
      //     return;
      //   }
      //   console.log(nodes);
      //
      //   generate the inital network
      //   generateGraph(nodes, edges);
      //   generateGraph(nodesTest, edgesTest);
      // }

    </script>

    <footer>
      &copy;2019 Chase Meyer
      <br>
      Graphs generated using vis.js library. &copy; 2010-2017 Almende B.V.
    </footer>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

  </body>
</html>
