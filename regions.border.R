## This will return the borders of regions as defined by some categorical feature.
## This output is not appropriate for plotting as polygons.

## df = a data frame of tessellating polygons, as produced by clip.border()
## region = the factor defining regions
regions.border <- function(df, region){
	require(gpclib)
	borders <- {}
	for(i in as.character(unique(df[,region]))){
		
		## Take the subset of polygons within a region
		sub <- df[df[ ,region] == i,]
		poly <- as(matrix(ncol = 2), "gpc.poly")
		
		## Take the union of all polygons 
		for(j in unique(sub$group)){
			subsub <- subset(sub, group ==j)
			subpoly <- as(subsub[,c("x","y")], "gpc.poly")
			poly <- union(subpoly, poly)
		}

		for(j in seq(along = poly@pts)){
			poly.df <- data.frame(x = poly@pts[[j]]$x, y = poly@pts[[j]]$y)
			poly.df <- rbind(poly.df, poly.df[1,],c(NA,NA,NA))
			borders <- rbind(borders, poly.df)
		}
	}
	return(borders)
}
