library(deldir)
library(gpclib)
library(maps)

source("http://github.com/JoFrhwld/Mapping-Scripts/raw/master/sample.data.R")
source("http://github.com/JoFrhwld/Mapping-Scripts/raw/master/clip.border.R")
source("http://github.com/JoFrhwld/Mapping-Scripts/raw/master/regions.border.R")

us <- data.frame(map("world", regions = "USA", exact = T,plot = F)[c("x","y")])
longisland <- data.frame(map("world", regions = "USA:New York:Long Island", exact = T,plot = F)[c("x","y")])

us <- fix.border(us)
longisland <- fix.border(longisland)

us.deldir <- deldir(samp$Longitude, samp$Latitude)

tess <- clip.border(us.deldir, list(us, longisland))

tess <- cbind(tess,samp[tess$ID,c("CitState","Dialect","oZ.F2")])

dialect.borders <- regions.border(tess, "Dialect")

d <- ggplot(data = tess, aes(x,y))+
		geom_polygon(aes(group = group, fill = Dialect))+
		geom_path(data = dialect.borders)+
		coord_map()
		
print(d)

o <- ggplot(data = tess, aes(x,y))+
		geom_polygon(aes(group = group, fill = oZ.F2))+coord_map()
print(o)

o+scale_fill_gradient2(mid = "grey80", midpoint = -0.5)

tess$o.Cat <- cut(tess$oZ.F2, 3, labels = c("Back","Neutral","Front"))

o.borders <- regions.border(tess, "o.Cat")

o2 <- ggplot(data = tess, aes(x,y))+
		geom_polygon(aes(group = group, fill = o.Cat))+
		#geom_path(data = o.borders)+
		coord_map()
		
print(o2)