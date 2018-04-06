CREATE OR REPLACE FUNCTION layer_contour(bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, ele int) AS $$
    SELECT geometry, ele
    FROM osm_contour
    WHERE geometry && bbox;
$$ LANGUAGE SQL IMMUTABLE;
