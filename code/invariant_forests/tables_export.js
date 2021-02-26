var bhrsj = ee.FeatureCollection("users/elacerda/bhrsj"),
    roi = ee.FeatureCollection("users/elacerda/crop_test"),
    af_samples = ee.FeatureCollection("users/elacerda/AForest_samples"),
    past_samples = ee.FeatureCollection("users/elacerda/APasture_samples"),
    ltr = ee.FeatureCollection("users/elacerda/ltr_change_samples_sj"),
    af_samples_50 = ee.FeatureCollection("users/elacerda/AForest_samples_random_50"),
    ltr_bhrsj = ee.FeatureCollection("users/elacerda/ltr_loss_samples"),
    samples_forest_bhrsj = ee.FeatureCollection("users/elacerda/samples_forest_sj"),
    other = ee.FeatureCollection("users/elacerda/other_samples");

var geet = require('users/elacerda/geet:geet'); 
var ts_collection = geet.build_annual_landsat_timeseries(bhrsj);

var clip_image = function(image) {
  return image.clip(bhrsj);
};
var ts_clipped = ts_collection.map(clip_image);

var merge_bands = function(image, previous) {
  return ee.Image(previous).addBands(image);
};
var ts_stack = ts_clipped.iterate(merge_bands, ee.Image([]));

var ts_final = ee.Image(ts_stack)


var input_features = ts_final.sampleRegions({
  collection: other,
  // properties: ['CID'],
  scale: 30
});

print(input_features)

Export.table.toDrive({
  collection: input_features,
  description:'other_wetness',
  fileFormat: 'CSV'
});