// var points_list = centroids.geometry().geometries();
// var path = pathrows.filter(ee.Filter.eq('PATH', 224));
// var row = pathrows.filter(ee.Filter.eq('ROW', 80));
// var pp = centroids.filterBounds(path).filterBounds(row)

var coords = centroids.geometry().coordinates()
var points_size = centroids.size().getInfo();

for (var i = 0; i < points_size; i++) {
  // define collection parameters
  var startYear = 1985;
  var endYear = 2017;
  var startDay = '01-31';
  var endDay = '12-31';
  var aoi = ee.Geometry.Point(coords.get(i));
  var index = 'NDVI';
  var maskThese = ['cloud', 'shadow', 'snow', 'water'];
  
  // define landtrendr parameters
  var runParams = { 
    maxSegments:            6,
    spikeThreshold:         0.9,
    vertexCountOvershoot:   3,
    preventOneYearRecovery: true,
    recoveryThreshold:      0.25,
    pvalThreshold:          0.05,
    bestModelProportion:    0.75,
    minObservationsNeeded:  6
  };

  // define change parameters
  var changeParams = {
    delta:  'gain',
    sort:   'newest',
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
  
  var output_name = 'ltgee_loss_disturbance_' + i.toString();
  
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
  
  //var link = exportImg.getDownloadURL({'name': output_name, 'scale': 30 });
  //print(link);
}