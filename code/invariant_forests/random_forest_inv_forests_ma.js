var roi = ee.FeatureCollection("users/elacerda/bhrsj"),
    af_samples = ee.FeatureCollection("users/elacerda/samples_forest_sj"),
    ltr_samples = ee.FeatureCollection("users/elacerda/ltr_loss_samples"),
    other_samples = ee.FeatureCollection("users/elacerda/other_samples"),
    img_ts = ee.Image("users/elacerda/bhrsj_ts"),
    centroids = ee.FeatureCollection("users/elacerda/ma_path_rows_centroids"),
    pathrows = ee.FeatureCollection("users/elacerda/ma_path_rows");

var geet = require('users/elacerda/geet:geet'); 

var coords = centroids.geometry().coordinates();
var points_size = centroids.size().getInfo();
var centroid_info = centroids.getInfo();

for (var i = 0; i < 3; i++) {
  switch(i) {
    case 0:
      af_samples = af_samples.map(function(feature) { return feature.set('class', i); });
    case 1:
      ltr_samples = ltr_samples.map(function(feature) { return feature.set('class', i); });
    case 2:
      other_samples = other_samples.map(function(feature) { return feature.set('class', i); });
  }
}

var samplesfc = af_samples.merge(ltr_samples).merge(other_samples);

var bands = [];
for (var i = 0; i < 32; i++) {
  if (i === 0) {
    bands.push("BLUE");
    bands.push("GREEN");
    bands.push("RED");
    bands.push("SWIR1");
    bands.push("SWIR2");
    bands.push("NIR");
    bands.push("NDVI");
    bands.push("NDMI");
    bands.push("SAVI");
  } else {
    bands.push("BLUE_" + i.toString());
    bands.push("GREEN_" + i.toString());
    bands.push("RED_" + i.toString());
    bands.push("SWIR1_" + i.toString());
    bands.push("SWIR2_" + i.toString());
    bands.push("NIR_" + i.toString());
    bands.push("NDVI_" + i.toString());
    bands.push("NDMI_" + i.toString());
    bands.push("SAVI_" + i.toString());
  }
}

var merge_bands = function(image, previous) {
  return ee.Image(previous).addBands(image);
};

for (var i = 0; i < 2; i++) {
  var aoi = ee.Geometry.Point(coords.get(i));
  var ls_timeseries = geet.build_annual_landsat_timeseries(aoi);
  var ts_final = ls_timeseries.iterate(merge_bands, ee.Image([]));
  var imgClass = geet.rf(ee.Image(ts_final), bands, samplesfc, 'class', 100, 30, 0.7);
  var output_name = 'ma_invariant_for_'
      + (centroid_info.features[i].properties.PATH).toString() + "_" 
      + (centroid_info.features[i].properties.ROW).toString();
  var region = aoi.buffer(100000).bounds();
  var exportImg = imgClass.clip(region).unmask(0).short();
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
  Map.addLayer(imgClass)
}
