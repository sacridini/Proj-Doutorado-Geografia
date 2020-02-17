// var points_list = centroids.geometry().geometries();
// var path = pathrows.filter(ee.Filter.eq('PATH', 224));
// var row = pathrows.filter(ee.Filter.eq('ROW', 80));
// var pp = centroids.filterBounds(path).filterBounds(row)

var coords = centroids.geometry().coordinates()
var points_size = centroids.size().getInfo();
var centroid_info = centroids.getInfo()

var ganho_perda = "gain";
var tipo_mudança = "fastest";

for (var i = 0; i < points_size; i++) {
  // define collection parameters
  var startYear = 1985;
  var endYear = 2017;
  var startDay = '01-01';
  var endDay = '12-31';
  var aoi = ee.Geometry.Point(coords.get(i));
  var index = 'NDVI';
  var maskThese = ['cloud', 'shadow', 'snow', 'water'];
  
  // define landtrendr parameters
  var runParams = { 
    maxSegments:            12,
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
    year:   {checked:false, start:1986, end:2017},
    mag:    {checked:false, value:0,  operator:'>'},
    dur:    {checked:false, value:0,    operator:'>'},
    preval: {checked:false, value:0,  operator:'>'},
    mmu:    {checked:false, value:11},
  };
  
  // load the LandTrendr.js module
  var ltgee = require('users/emaprlab/public:Modules/LandTrendr.js'); 
  
  // add index to changeParams object
  changeParams.index = index;
  
  // run landtrendr
  var lt = ltgee.runLT(startYear, endYear, startDay, endDay, aoi, index, [], runParams, maskThese);
  
  // get the change map layers
  var changeImg = ltgee.getChangeMap(lt, changeParams);
  
  // export change data to google drive
  var region = aoi.buffer(100000).bounds();
  var exportImg = changeImg.clip(region).unmask(0).short();
  
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