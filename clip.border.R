clip.border <- function(deldir.obj, border){
	## deldir.obj = output of deldir::deldir
	## border = list of borders defined in data frames
	##		Importantly, with columns called "x" and "y" 
	require(gpclib)

	## bord will be a gpc polygon of all of the regions given to the argument "border"
	bord <- as(matrix(ncol = 2), "gpc.poly")
	for(i in seq(along = border)){
		b <- as(border[[i]], "gpc.poly")
		bord <- union(b, bord)
	}

	## Extract the polygons from the deldir object
	tiles <- tile.list(deldir.obj)
	out <- {}
	## Keep track of polygon identity
	group <- 1
	for(i in seq(along = tiles)){

		## Represent each tile as a gpc polygon
		poly <- cbind(tiles[[i]]$x, tiles[[i]]$y)
		poly <- as(poly, "gpc.poly")

		## THIS IS THE CRUCIAL FUNCTION
		poly <- intersect(poly, bord)

		## bookkeeping and reporting
		excluded <- 0

		## Formatting output
		if(length(poly@pts)>0){
			for(j in seq(along=poly@pts)){
				poly.df <- data.frame(x = poly@pts[[j]]$x, y =poly@pts[[j]]$y)
				poly.df$ID <- i
				poly.df$group <- group
				group <- group + 1
				out <- rbind(out, poly.df)
			}
		}else{
			excluded <- excluded + 1
		}
	}
	cat(excluded)
	cat(" polygon(s) entirely outside border")
	return(out)
}

## out$group defines polygon groups
## out$ID defines the data point id's
## group to ID relationship may be many to one

## out$Feature <- original.data[out$ID, ]$Feature
