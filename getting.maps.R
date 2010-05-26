## This is some sample code for getting boundary data from the maps package
## If the output of this data contains any NAs, you should use fix.borders(), or some other function

## usa, national
## for maps strictly of the US, or some sub region, use the "usa" map, as it is of higher quality

us.bord <- data.frame(map("usa", region = "main", plot = F)[c("x","y")])
li.bord <- data.frame(map("usa", region = "long island", plot = F)[c("x","y")])

## us.states

pa.bord <- data.frame(map("state", region = "pennsylvania", plot = F)[c("x","y")])

## some other countries

fr.bord <- data.frame(map("map", region = "France", exact = T, plot = F)[c("x","y")])
## see also, map("map", region = "France", exact = T, plot = F)$name
