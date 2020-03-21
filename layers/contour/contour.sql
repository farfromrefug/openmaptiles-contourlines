
-- etldoc: ne_10m_rivers_lake_centerlines ->  contours_z6
CREATE OR REPLACE VIEW contours_z9 AS (
    SELECT geometry, ele, 2 as index
    FROM osm_contour
    WHERE ele % 500 = 0
);

CREATE OR REPLACE VIEW contours_z10 AS (
    SELECT geometry, ele, 10 as index
    FROM osm_contour
    WHERE ele % 200 = 0
);

CREATE OR REPLACE VIEW contours_z11 AS (
    SELECT geometry, ele, 
     CASE
        WHEN ele = 0 THEN -1
        WHEN ele % 1000 = 0 THEN 10
        WHEN ele % 500 = 0 THEN 5
        WHEN ele % 200 = 0 THEN 2
        ELSE 1
    END as index
    FROM osm_contour
    WHERE ele % 100 = 0
);

CREATE OR REPLACE VIEW contours_z12 AS (
    SELECT geometry, ele, 
     CASE
        WHEN ele = 0 THEN -1
        WHEN ele % 500 = 0 THEN 10
        WHEN ele % 250 = 0 THEN 5
        WHEN ele % 100 = 0 THEN 2
        ELSE 1
    END as index
    FROM osm_contour
    WHERE ele % 50 = 0
);

CREATE OR REPLACE VIEW contours_z13 AS (
    SELECT geometry, ele, 
     CASE
        WHEN ele = 0 THEN -1
        WHEN ele % 200 = 0 THEN 10
        WHEN ele % 100 = 0 THEN 5
        WHEN ele % 40 = 0 THEN 2
        ELSE 1
    END as index
    FROM osm_contour
    WHERE ele % 20 = 0
);
CREATE OR REPLACE VIEW contours_z14 AS (
    SELECT geometry, ele, 
     CASE
        WHEN ele = 0 THEN -1
        WHEN ele % 100 = 0 THEN 10
        WHEN ele % 50 = 0 THEN 5
        WHEN ele % 20 = 0 THEN 2
        ELSE 1
    END as index
    FROM osm_contour
    WHERE ele % 10 = 0
);

CREATE OR REPLACE FUNCTION layer_contour(bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, ele int, index int) AS $$
    SELECT geometry, ele,
    index
    FROM (
        -- etldoc: contours_z9 ->  layer_contours:z9
        SELECT * FROM contours_z9 WHERE zoom_level = 9
        UNION ALL
        -- etldoc: contours_z10 ->  layer_contours:z10
        SELECT * FROM contours_z10 WHERE zoom_level = 10
        UNION ALL
        -- etldoc: contours_z11 ->  layer_contours:z11
        SELECT * FROM contours_z11 WHERE zoom_level = 11
        UNION ALL
        -- etldoc: contours_z12 ->  layer_contours:z12
        SELECT * FROM contours_z12 WHERE zoom_level = 12
        UNION ALL
        -- etldoc: contours_z13 ->  layer_contours:z13
        SELECT * FROM contours_z13 WHERE zoom_level = 13
        UNION ALL
        -- etldoc: contours_z14 ->  layer_contours:z14
        SELECT * FROM contours_z14 WHERE zoom_level >= 14
    ) AS zoom_levels
    WHERE geometry && bbox;
$$ LANGUAGE SQL IMMUTABLE;
