## A pair of functions for creating a matrix and computing its inverse in a
## in a way that caches the result of the inverse function, solve. This is
## useful for speeding up long-running functions which may need to repeatedly
## compute the inverse of matrices.

## Creates a matrix which caches the result of an inverse
makeCacheMatrix <- function(x = matrix()) {
	m <- NULL
	set <- function(y) {
		x <<- y
		m <<- NULL
	}
	get <- function() x
	setsolve <- function(solve) m <<- solve
	getsolve <- function() m
	list (set = set, get = get,
		setsolve = setsolve,
		getsolve = getsolve)
}


## Computes the inverse or returns the cached result
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
	m <- x$getsolve()
	if(!is.null(m)) {
		message("Getting cached data.")
		return(m)
	}
	data <- x$get()
	m <- solve(data, ...)
	x$setsolve(m)
	m
}
