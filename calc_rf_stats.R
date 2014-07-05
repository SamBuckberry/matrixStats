library(tools)

#' @param dataDirectory Character string of directory containing matrix files
#' @param filePattern Character string identifying matrix files. Default=".rf"
#' @return Total A data frame containing the statistics for each matrix file

calc_rf_stats <- function(dataDirectory, filePattern=".rf"){
        
        # Get the matrix files for calculating stats
        filenames <- list.files(path=dataDirectory, pattern=filePattern,
                                full.names=TRUE)
        
        # Function for calculating matrix stats
        stats <- function(filename) {
                        ## Load data matrices from HashRF analysis
                        file <- filename
                        T <- as.matrix(read.table(file))
                        
                        # Discard diagonal and lower triangle of symmetrical matrix
                        T[lower.tri(T, diag=TRUE)] <- NA
                        #print(T) ## just to check has done the replacement by NA
                        
                        # Return the statistics for the matrix
                        return(c(mean(T, na.rm=TRUE), sd(T, na.rm=TRUE), 
                          median(T, na.rm=TRUE),max(T, na.rm=TRUE),
                          min(T, na.rm=TRUE)))
                }

        # apply the stats function to the list of files
        result <- lapply(X=filenames, FUN=stats)
        # convert results list into data.frame
        result <- do.call(rbind.data.frame, result, quote=FALSE)
        colnames(result) <- c("Mean", "StdDev", "Median", "Max", "Min")
        
        # Add the names for each file as row.names for results
        row.names(result) <- lapply(X=filenames,
                                    FUN=function(x){file_path_sans_ext(basename(x))})
        
        # Calculate normalised mean and add to results
        tot <- colSums(result)
        GENE_tot <- as.matrix(result[,1]/tot[1])
        colnames(GENE_tot) <- c("Norm_Mean")
        Total <- cbind(result, GENE_tot)
        
        # Return the data frame of results
        return(Total)
}

