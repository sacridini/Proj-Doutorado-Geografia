// var points_list = centroids.geometry().geometries();
// var path = pathrows.filter(ee.Filter.eq('PATH', 224));
// var row = pathrows.filter(ee.Filter.eq('ROW', 80));
// var pp = centroids.filterBounds(path).filterBounds(row)

var centroids = ee.FeatureCollection("users/elacerda/ma_path_rows_centroids"),
    pathrows = ee.FeatureCollection("users/elacerda/ma_path_rows");

var coords = centroids.geometry().coordinates();
var points_size = centroids.size().getInfo();
var centroid_info = centroids.getInfo();

var ganho_perda = "gain";
var tipo_mudança = "greatest";

for (var i = 0; i < points_size; i++) {
  // define collection parameters
  var startYear = 1985;
  var endYear = 2018;
  var startDay = '01-01';
  var endDay = '12-31';
  var aoi = ee.Geometry.Point(coords.get(i));
  var index = 'NDVI';
  var maskThese = ['cloud', 'shadow', 'snow', 'water'];
  
  // define landtrendr parameters
  var runParams = { 
    maxSegments:            6,
    spikeThreshold:         0.2,
    vertexCountOvershoot:   3,
    preventOneYearRecovery: true,
    recoveryThreshold:      0.25,
    pvalThreshold:          0.05,
    bestModelProportion:    0.75,
    minObservationsNeeded:  6
  };

  // define change parameters
  var changeParams = {
    delta:  ganho_perda,
    sort:   tipo_mudança,
    year:   {checked:true, start:1986, end:2013},
    mag:    {checked:true, value:199,  operator:'>'},
    dur:    {checked:true, value:4,    operator:'>'},
    preval: {checked:true, value:400,  operator:'>'},
    mmu:    {checked:false, value:11},
  };
  
  // load the LandTrendr.js module
  var ltgee = require('users/emaprlab/public:Modules/LandTrendr.js'); 
  
  // add index to changeParams object
  changeParams.index = index;
  
  // run landtrendr
  var lt = ltgee.runLT(startYear, endYear, startDay, endDay, aoi, index, [], runParams, maskThese);
  var lt_seg = ltgee.getSegmentData(lt, "NDVI", "loss");
  var segStartYr = lt_seg.arraySlice(0, 0, 1)
  var bigDelta = segStartYr.arraySlice(1, 0, 1);
  var bigDelta2 = segStartYr.arraySlice(1, 1, 2);
  var bigDelta3 = segStartYr.arraySlice(1, 2, 3);
  var bigDelta4 = segStartYr.arraySlice(1, 3, 4);
  var new_img = ee.Image(bigDelta4.arrayProject([1]).arrayFlatten([['seg_year_3']]));
  
  // get the change map layers
  var changeImg = ltgee.getChangeMap(lt, changeParams);
  
  // export change data to google drive
  var region = aoi.buffer(100000).bounds();
  var exportImg = changeImg.clip(region).unmask(0).short();
  // var exportImg = new_img.clip(region).unmask(0).short();
  
  var output_name = 'ltgee_' 
      + ganho_perda + '_' + tipo_mudança + '_' 
      + (centroid_info.features[i].properties.PATH).toString() + "_" 
      + (centroid_info.features[i].properties.ROW).toString();
  
  Export.image.toDrive({
    image: exportImg, 
    description: output_name, 
    folder: 'ee', 
    fileNamePrefix: output_name, 
    region: region, 
    scale: 30, 
    crs: 'EPSG:4326', 
    maxPixels: 1e13
  });
}