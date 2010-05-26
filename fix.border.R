## Some of the data from maps is represented kind of strangely
## fix.border() is meant to reformat this data in a more useable way
## but, be sure to double check the output, since the borders may need more fixing than anticipated here.

fix.border <- function(border, rev.first = T){
	if(is.na(sum(border$x))){
	
		out <- {}
		stack <- {}
		seg <- 1
	
		for(i in 1:nrow(border)){
			if(is.na(border[i,]$x)){
				stack$seg <- seg
				seg <- seg+1
				
				if(is.null(out) & rev.first){
					out <- rbind(out, stack[nrow(stack):1,])
				}else if(is.null(out) & !rev.first){
					out <- rbind(out, stack)
				}else{
					n.out <- nrow(out)
					last <- nrow(stack)
					
					head.dist <- sum(c((out[n.out,]$x -  stack[1,]$x),(out[n.out,]$y -  stack[1,]$y))^2)
					tail.dist <- sum(c((out[n.out,]$x -  stack[last,]$x),(out[n.out,]$y -  stack[last,]$y))^2)
				
					if(tail.dist < head.dist){
						stack <- stack[nrow(stack):1,]
					}
					
					out <- rbind(out, stack[-1,])
				}
				
				stack <- {}
						
			}else{
				stack <- rbind(stack, border[i,])
			
			}
		}
		out <- rbind(out, out[1,])
	}else{
		out <- border
	}
	return(out)	
}
