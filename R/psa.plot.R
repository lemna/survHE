psa.plot <- function(psa,...) {
  # Plots the survival curves for all the PSA simulations
  # psa = the result of the call to the function make.surv
  # ... = additional arguments
  # xlab = label for the x-axis
  # ylab = label for the y-axis
  # col = vector of colours with which to plot the curves
  # alpha = parameter to determine the transparency (default = 0.1)
  # main = a string to write the title
  # labs = logical (default = TRUE): should text to identify which profile has been plotted printed on the graph?
  # xpos = the point on the x-axis in which to write the legend with the profiles (default = 65% of the x-axis)
  # ypos = the point on the y-axis in which to write the legend with the profiles (default = 100% of the y-axis)
  # cex.txt = the factor by which to write the text (default = .75)
  # offset = how much space between text for each line? (default = .35)
  # nsmall = number of decimal places (default = 2)
  # digits = number of digits used for the numerical values in the labels
  
  n.elements <- length(psa$S[[1]]) 
  times <- psa$S[[1]][[1]][,1]
  exArgs <- list(...)
  if(!exists("xlab",where=exArgs)) {xlab <- "Time"} else {xlab <- exArgs$xlab}
  if(!exists("ylab",where=exArgs)) {ylab="Survival"} else {ylab <- exArgs$ylab}
  if(!exists("col",where=exArgs)) {col <- sample(colors(),n.elements)} else {col <- exArgs$col}
  if(!exists("alpha",where=exArgs)) {alpha <- 0.1} else {alpha <- exArgs$alpha}
  if(!exists("main",where=exArgs)) {main <- ""} else {main <- exArgs$main}
  if(!exists("labs",where=exArgs)) {labs <- TRUE} else {labs <- exArgs$labs}
  if(!exists("xpos",where=exArgs)) {xpos <- max(times)*0.65} else {xpos <- exArgs$xpos}
  if(!exists("ypos",where=exArgs)) {ypos <- 1} else {ypos <- exArgs$ypos}
  if(!exists("cex.txt",where=exArgs)) {cex.txt <- 0.75} else {cex.txt <- exArgs$cex.txt}
  if(!exists("offset",where=exArgs)) {off <- seq(1,nrow(psa$des.mat))*.35} else {off <- seq(1,nrow(psa$des.mat))*exArgs$offset}
  if(!exists("nsmall",where=exArgs)) {nsmall <- 2} else {nsmall <- exArgs$nsmall}
  if(!exists("digits",where=exArgs)) {digits <- 5} else {digits <- exArgs$digits}
  
  # If there's only the average value for the survival curve, simpler plot
  if (psa$nsim==1) {
    alpha <- 1
    plot(psa$S[[1]][[1]][,1:2],t="l",xlab=xlab,ylab=ylab,col=adjustcolor(col[1],alpha),ylim=c(0,1),xlim=range(pretty(times)),
         main=main,axes=F)
    if (n.elements>1) {
      pts2 <- lapply(2:n.elements,function(i) points(psa$S[[1]][[i]],t="l",col=adjustcolor(col[i],alpha)))
    }
  }
  
  # If there are nsim simulations from the survival curves, then more complex plot
  if (psa$nsim>1) {
    tmp <- lapply(1:n.elements,function(j) matrix(unlist(lapply(1:psa$nsim,function(i) psa$S[[i]][[j]][,2])),nrow=psa$nsim,byrow=T))
    q025 <- lapply(1:n.elements, function(j) apply(tmp[[j]],2,function(x) quantile(x,.025)))
    q500 <- lapply(1:n.elements, function(j) apply(tmp[[j]],2,function(x) quantile(x,.5))) 
    q975 <- lapply(1:n.elements, function(j) apply(tmp[[j]],2,function(x) quantile(x,.975))) 
    plot(psa$S[[1]][[1]][,1],q500[[1]],col=adjustcolor(col[1],1),t="l",xlab=xlab,ylab=ylab,ylim=c(0,1),xlim=range(pretty(times)),lwd=2,main=main,axes=F)
    polygon(c(psa$S[[1]][[1]][,1],rev(psa$S[[1]][[1]][,1])),c(q975[[1]],rev(q025[[1]])),col=adjustcolor(col[1],alpha),border=NA)
    if (n.elements==1) {
    }
    if (n.elements>1) {
      lapply(2:n.elements, function(i) {
        pts1 <- points(psa$S[[1]][[i]][,1],q500[[i]],col=adjustcolor(col[i],1),t="l",lwd=2) 
        pts2 <- polygon(c(psa$S[[1]][[i]][,1],rev(psa$S[[1]][[i]][,1])),c(q975[[i]],rev(q025[[i]])),col=adjustcolor(col[i],alpha),border=NA)
      })
    }
  }
  axis(1)
  axis(2)
  if (labs==TRUE) {
    txt1 <- lapply(1:ncol(psa$des.mat),function(i) {
      text(xpos,ypos-(i-1)/40,paste0(colnames(psa$des.mat)[i]," : "),cex=cex.txt,pos=2,col="black")
    })
    txt2 <- lapply(1:ncol(psa$des.mat),function(i) {
      lapply(1:nrow(psa$des.mat),function(j) {
        text(xpos+off[j],ypos-(i-1)/40,format(psa$des.mat[j,i],nsmall=nsmall,digits=digits),cex=cex.txt,pos=2,col=col[j])
      })
    })
  }
}
