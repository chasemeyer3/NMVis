<!DOCTYPE html>
<!-- Chase Meyer - NMVis -->
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
    <%-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css" rel="stylesheet" type="text/css"> --%>

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

      <form id="data-form" action="https://nmvis.azurewebsites.net/graph" method="post" enctype="multipart/form-data" roll="form">
        <textarea name="graphData" class="textInput" id="graphData" rows="8" cols="80" value="" placeholder="Paste network data here"></textarea>

        <div class="uploadFile">
          <p>Or, upload a file containing the network data in a valid format:</p>
          <input name="graphFile" id="graphFile" type="file" accept=".txt">
        </div>

        <button class="btn btn-lg btn-primary btn-block"  id="submitButton" type="button">Show Network Motifs</button>

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

    <script type="text/javascript">
      function processGraph(){

        var request = new XMLHttpRequest();
        //
            // Open a new connection, using the GET request on the URL endpoint
            request.open('POST', 'https://nmvis.azurewebsites.net/graph', true);

            request.onload = function () {
              // Begin accessing JSON data here
              // var response = JSON.parse(xhttp.responseText);
              var data = JSON.parse(this.response);

              const respP = document.createElement('p');
              respP.value = data;

            }

            // send the request
            request.send();

      }

      // function largeGraphTest(){
      //   var container = document.getElementById('myVisBox');
      //
      //   // provide the data in the vis format
      //   var data = {
      //       nodes: nodes,
      //       edges: edges
      //   };
      //
      //   var options = {
      //     nodes: {
      //       shape: 'dot',
      //       scaling: {
      //         min: 10,
      //         max: 30
      //       },
      //       font: {
      //         size: 12,
      //         face: 'Tahoma'
      //       }
      //     },
      //     physics: {
      //       stabilization: false,
      //       barnesHut: {
      //         gravitationalConstant: -80000,
      //         springConstant: 0.001,
      //         springLength: 200
      //       }
      //     },
      //     interaction: {
      //       tooltipDelay: 200,
      //       hideEdgesOnDrag: true
      //     }
      //   };
      //
      //   // initialize your network!
      //   var network = new vis.Network(container, data, options);
      //
      // }
      // largeGraphTest();

      // function generateGraph(nodes, edges){
      //   //console.log(edges);
      //   // create an array with nodes
      //   // var nodesDS = new vis.DataSet(nodes);
      //   // var edgesDS = new vis.DataSet(edges);
      //
      //   // create a network
      //   var container = document.getElementById('myVisBox');
      //
      //   // provide the data in the vis format
      //   var data = {
      //       nodes: nodes,
      //       edges: edges
      //   };
      //   //console.log(data);
      //
      //   var options = {};
      //
      //   // initialize your network!
      //   var network = new vis.Network(container, data, options);
      //
      // }

      // var nodesTest = new vis.DataSet();
      // var edgesTest = new vis.DataSet();
      // generateGraph(nodesTest, edgesTest);

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
      //     // var nodeSet = new Set();
      //     // var edges = [];
      //     // var nodes = [];
      //     // // check if a file was input, if so use the file
      //     // if (document.getElementById("graphFile").files.length != 0){
      //     //   var inFile = document.getElementById("graphFile").files[0];
      //     //   // going to check that the file size is within limits
      //     //   if (inFile.size > 100000){  // limit is 100 KB -> 100000 bytes
      //     //     alert("The provided file is too large. Text file with graph data should be 100 KB or less. Graphs this large are difficult to visualize, we're sorry for the inconvenience.");
      //     //     return;
      //     //   }
      //     //   // if the file size is very small, the browser will display the inital graph
      //     //   else if (inFile.size < 5000){
      //     //     const reader = new FileReader();
      //     //     // reader will call this onload callback when it has finished reading the file
      //     //     reader.onload = function () {
      //     //       reader.result.split('\n').map(function (line) {
      //     //         line.trim();
      //     //         const curLine = line.split('\t');
      //     //         if (curLine.length == 2){
      //     //           var fromInt = parseInt(curLine[0]);
      //     //           var toInt = parseInt(curLine[1]);
      //     //           // if key not in set, add it
      //     //           if (!nodeSet.has(fromInt)){
      //     //             nodeSet.add(fromInt);
      //     //             //nodes.push({id: fromInt, label: 'Protein ' + curLine[0]});
      //     //             nodesTest.add([{id: fromInt, label: 'Protein ' + curLine[0]}]);
      //     //           }
      //     //           if (!nodeSet.has(toInt)) {
      //     //             nodeSet.add(toInt);
      //     //             //nodes.push({id: toInt, label: 'Protein ' + curLine[1]});
      //     //             nodesTest.add([{id: toInt, label: 'Protein ' + curLine[1]}]);
      //     //           }
      //     //           // add the edge to the edge array
      //     //           edgesTest.add([{from: fromInt, to: toInt}]);
      //     //           //edges.push({from: fromInt, to: toInt});
      //     //         }
      //     //       });
      //     //     }
      //     //     reader.readAsText(inFile);
      //     //   }
      //     //   // else the server needs to process the data, will return JSON
      //     //   else {
      //     //     var request = new XMLHttpRequest();
      //     //
      //     //     // Open a new connection, using the GET request on the URL endpoint
      //     //     request.open('GET', 'https://nmvis.azurewebsites.net/graph', true);
      //     //
      //     //     request.onload = function () {
      //     //       // Begin accessing JSON data here
      //     //       var data = JSON.parse(this.response);
      //     //
      //     //       const respP = document.createElement('p');
      //     //       respP.value = data;
      //     //
      //     //     }
      //     //     // send the request
      //     //     request.send();
      //     //   }
      //
      //   // }
      //   // // else check if graph data was pasted in
      //   // else if (document.getElementById("graphData").value != ""){
      //   //   // TODO - validate format here first
      //   //   var text = document.getElementById("graphData").value;
      //   //   text.split('\n').map(function (line) {
      //   //     line.trim();
      //   //     const curLine = line.split('\t');
      //   //     if (curLine.length == 2){
      //   //       var fromInt = parseInt(curLine[0]);
      //   //       var toInt = parseInt(curLine[1]);
      //   //       // if key not in set, add it
      //   //       if (!nodeSet.has(fromInt)){
      //   //         nodeSet.add(fromInt);
      //   //         nodes.push({id: fromInt, label: "Protein " + curLine[0]});
      //   //       }
      //   //       if (!nodeSet.has(toInt)) {
      //   //         nodeSet.add(toInt);
      //   //         nodes.push({id: toInt, label: "Protein " + curLine[1]});
      //   //       }
      //   //       // add the edge to the edge array
      //   //       edges.push({from: fromInt, to: toInt});
      //   //     }
      //   //   });
      //   // }
      //   // else {
      //   //   alert("No graph was inserted. Please add file or paste network in correct format.");
      //   //   return;
      //   // }
      //   //console.log(nodes);
      //
      //   // generate the inital network
      //   //generateGraph(nodes, edges);
      //   //generateGraph(nodesTest, edgesTest);
      // }

    </script>

    <%-- <script type="text/javascript">

      // create an array with nodes
      var nodes = new vis.DataSet([
          {id: 1, label: 'Node 1'},
          {id: 2, label: 'Node 2'},
          {id: 3, label: 'Node 3'},
          {id: 4, label: 'Node 4'},
          {id: 5, label: 'Node 5'}
      ]);

      // create an array with edges
      var edges = new vis.DataSet([
          {from: 1, to: 3},
          {from: 1, to: 2},
          {from: 2, to: 4},
          {from: 2, to: 5}
      ]);

      // create a network
      var container = document.getElementById('myVisBox');

      // provide the data in the vis format
      var data = {
          nodes: nodes,
          edges: edges
      };
      //console.log(data);
      var options = {};

      // initialize your network!
      var network = new vis.Network(container, data, options);
    </script> --%>

    <%-- jQuery to add items to the network visualizations to the carousel --%>
    <%-- <script>
      $(document).ready(function(){
        for(var i=0 ; i< m.length ; i++) {
          $('<div class="item"><img src="'+m[i]+'"><div class="carousel-caption"></div>   </div>').appendTo('.carousel-inner');
          $('<li data-target="#carousel-example-generic" data-slide-to="'+i+'"></li>').appendTo('.carousel-indicators')

        }
        $('.item').first().addClass('active');
        $('.carousel-indicators > li').first().addClass('active');
        $('#carousel-example-generic').carousel();
      });
    </script> --%>

    <footer>© 2019 Chase Meyer</footer>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

  </body>
</html>
