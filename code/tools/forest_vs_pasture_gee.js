var fito = ee.FeatureCollection("users/elacerda/fitofisionomias_mata_atlantica"),
    omb = /* color: #d63000 */ee.Geometry.MultiPoint(
        [[-42.78145933352007, -22.476098301123944],
         [-43.58895445070757, -22.623220987659135],
         [-43.239451887231006, -22.318656222777577],
         [-42.80966111753331, -22.222237022988494],
         [-44.97274796242751, -23.136273762815232],
         [-41.835526185094245, -21.83257232441428],
         [-45.737181152293275, -23.46132918075406],
         [-47.11837852199251, -23.730519003278406],
         [-47.67063680233745, -24.078253288334285],
         [-47.45343757009, -24.34950420159275],
         [-48.00953653663101, -24.573416626508276]]),
    ls8 = ee.ImageCollection("LANDSAT/LC08/C01/T1_SR"),
    est = /* color: #98ff00 */ee.Geometry.MultiPoint(
        [[-46.69227346082584, -21.34681606993083],
         [-46.308397584611846, -21.149971570625496],
         [-44.601932040285355, -20.614060049768774],
         [-44.26629610750522, -20.402238811701785],
         [-42.62409440490141, -20.390491318598464],
         [-41.744269162541286, -19.324017588940972],
         [-41.1824006046708, -19.651130191734104],
         [-41.666981775752376, -18.381920050003828],
         [-41.3068964553849, -17.724546500316062],
         [-42.98175130355119, -18.786827706484956],
         [-52.777894873527345, -23.793017379335463]]);


Map.addLayer(fito)
var veg_type = "est";
var omb_buffers = est.buffer(10000);
// var est_buffers = est.buffer(10000)
Map.addLayer(omb_buffers)

function mask_clouds_shadow_ls8(image) {
  // Bits 3 and 5 are cloud shadow and cloud, respectively.
  var cloudShadowBitMask = (1 << 3);
  var cloudsBitMask = (1 << 5);
  // Get the pixel QA band.
  var qa = image.select('pixel_qa');
  // Both flags should be set to zero, indicating clear conditions.
  var mask = qa.bitwiseAnd(cloudShadowBitMask).eq(0)
                 .and(qa.bitwiseAnd(cloudsBitMask).eq(0));
  return image.updateMask(mask);
}

function calc_ndvi(image) {
  var ndvi = image.normalizedDifference(['B5', 'B4']).rename("NDVI");
  var new_image = image.addBands(ndvi);
  return new_image;
}

var geom_list = ee.List(omb_buffers.geometries());
var vec_size = geom_list.size().getInfo();

for(var i = 0; i < vec_size; i++) {
  var imgs = ee.ImageCollection(ls8.filterDate('2015-01-01', '2015-12-31').filterBounds(geom_list.get(i)));
  
  var masked_clouds = imgs.map(mask_clouds_shadow_ls8);
  var masked_ndvi = masked_clouds.map(calc_ndvi);
  var best = masked_ndvi.median();
  var best_ndvi = best.select('NDVI');


  var img_out_filename = veg_type + '_ndvi_ls8_2015_' + i.toString();
  var roi_out_filename = veg_type + '_roi_' + i.toString();
  
  
  Export.image.toDrive({
    image: best_ndvi, 
    description: img_out_filename, 
    folder: 'ee', 
    fileNamePrefix: img_out_filename, 
    region: geom_list.get(i),
    scale: 30, 
    crs: 'EPSG:4326', 
    maxPixels: 1e13
  });
  
  var feat_geom = ee.FeatureCollection(ee.Geometry(geom_list.get(i)))
  
  Export.table.toDrive({
    description: roi_out_filename,
    collection: feat_geom,
    folder: 'ee',
    fileNamePrefix: roi_out_filename,
    fileFormat: "SHP"
  });
}






