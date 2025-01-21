# 1 PACKAGES

libs <- c(
  "giscoR", "terra", "sf",
  "elevatr", "png", "rayshader"
)

installed_libs <- libs %in% rownames(
  installed.packages()
)

if(any(installed_libs == F)){
  install.packages(
    libs[!installed_libs],
    dependencies = T
  )
}

invisible(
  lapply(
    libs, library,
    character.only = T
  )
)

# 2. AFRICA, ASIA and EUROPE SHAFILE

africa_sf <- giscoR::gisco_get_countries(
  region = c(
    "Africa", "Asia", "Europe"
  ),
  resolution = "3"
) |>
  sf::st_union()

plot(sf::st_geometry(africa_sf))

# 3. NORTH AFRICA OLD TOPO MAP

north_africa_topo_tif <- terra::rast(
  "africa-north-per-4b235eadb17448f9.tiff"
)

terra::plotRGB(north_africa_topo_tif)

# 4. NORTH AFRICA EXTENT

north_africa_bbox <- terra::ext(
  north_africa_topo_tif
) |>
  sf::st_bbox(crs = 3857) |>
  sf::st_as_sfc(crs = 3857) |>
  sf::st_transform(crs = 4326) |>
  sf::st_intersection(africa_sf)

plot(sf::st_geometry(north_africa_bbox))

