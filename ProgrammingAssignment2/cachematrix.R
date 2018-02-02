## This set of functions caches the inverse of a matrix which minimizes the
## computation time on recalculations.


## This function creates a list of functions to get and set the matrix and
## functions to set and get the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  
    M <- NULL
    set <- function(y) {
      x <<- y
      M <<- NULL
    }
    
    get <- function() x
    setImatrix <- function(solve) M <<- solve
    getImatrix <- function() M
    list(set = set, get = get,
         setImatrix = setImatrix,
         getImatrix = getImatrix)
  }



## In this function, the inverse of the matrix contained within the list
## returned by the first function is calculated. The inverse is only calculate
## in cases where the inverse of the matrix does not already exist.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  
    M <- x$getImatrix()
    if(!is.null(M)) {
      message("getting cached data")
      return(M)
    }
    
    data <- x$get()
    M <- solve(data, ...)
    x$setImatrix(M)
    M
  }

