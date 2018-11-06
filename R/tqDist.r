#' Triplet and quartet distances with tqDist
#' 
#' Functions to calculate triplet and quartet distances between pairs of trees.
#' 
#' @param file,file1,file2 Paths to files containing a tree or trees in Newick format.
#' 
#' @return The distance between the requested trees.
#' 
#' @author Martin R. Smith, after Andreas Sand
#' 
#' @references \insertRef{Sand2014}{Quartet}
#'   \insertRef{Brodal2013}{Quartet}
#' @export
QuartetDistance <- function(file1, file2) {
  ValidateQuartetFile(file1)
  ValidateQuartetFile(file2)
  .Call('_Quartet_tqdist_QuartetDistance', as.character(file1), as.character(file2));
}

#' @describeIn QuartetDistance Returns a vector of length four, listing (1)
#' the Quartet Distance; (2) the number of resolved quartets that agree ('A');
#' (3) the number of quartets that are unresolved in both trees ('E'); (4) the
#' total number of quartets. See Brodal et al. (2013).
#'  
#' @export
QuartetStatus <- function(file1, file2) {
  ValidateQuartetFile(file1)
  ValidateQuartetFile(file2)
  .Call('_Quartet_tqdist_QuartetStatus', as.character(file1), as.character(file2));
}

#' @export
#' @importFrom ape read.tree
#' @describeIn QuartetDistance Quartet distance between the tree on each line of `file1`
#'   and the tree on the corresponding line of `file2`
PairsQuartetDistance <- function(file1, file2) {
  ValidateQuartetFile(file1)
  ValidateQuartetFile(file2)
  trees1 <- read.tree(file1)
  trees2 <- read.tree(file2)
  if (length(trees1) != length(trees2) || class(trees1) != class(trees2)) {
    stop("file1 and file2 must contain the same number of trees")
  }
  .Call('_Quartet_tqdist_PairsQuartetDistance', as.character(file1), as.character(file2));
}

#' @export
#' @describeIn QuartetDistance Quartet distance between each tree listed in `file` and 
#'   each other tree therein
AllPairsQuartetDistance <- function(file) {
  ValidateQuartetFile(file)
  .Call('_Quartet_tqdist_AllPairsQuartetDistance', as.character(file));
}

#' @export
#' @describeIn QuartetDistance Triplet distance between the single tree given 
#'   in each file
TripletDistance <- function(file1, file2) {
  ValidateQuartetFile(file1)
  ValidateQuartetFile(file2)
  .Call('_Quartet_tqdist_TripletDistance', as.character(file1), as.character(file2));
}

#' @export
#' @describeIn QuartetDistance Triplet distance between the tree on each line of `file1`
#'   and the tree on the corresponding line of `file2`
PairsTripletDistance <- function(file1, file2) {
  ValidateQuartetFile(file1)
  ValidateQuartetFile(file2)
  .Call('_Quartet_tqdist_PairsTripletDistance', as.character(file1), as.character(file2));
}

#' @export
#' @describeIn QuartetDistance Triplet distance between each tree listed in `file` and 
#'   each other tree therein
AllPairsTripletDistance <- function(file) {
  ValidateQuartetFile(file)
  .Call('_Quartet_tqdist_AllPairsTripletDistance', as.character(file));
}

#' Validate filenames
#' 
#' Verifies that file parameters are character strings describing files that exist
#' 
#' @param file Variable to validate
#' 
#' @return `TRUE` if `file` is a character vector of length one describing 
#'   a file that exists, a fatal error otherwise.
#' 
#' @author Martin R. Smith
#' 
#' @export
#' @keywords internal
ValidateQuartetFile <- function (file) {
  if (length(file) != 1) {
    stop("file must be a character vector of length one")
  }
  if (!file.exists(file)) {
    stop("file ", file, " not found")
  }
}