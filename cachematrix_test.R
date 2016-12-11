source("cachematrix.R")

##set.seed(1)
mat <- makeCacheMatrix(matrix(rnorm(1000000), nrow = 1000, ncol = 1000))

test_mat <- function(mat) {
	mat_inv <- cacheSolve(mat)
	result <- round(mat$get() %*% mat_inv)
	if (identical(result, diag(1000))) {
		message("Matrix inverse succeeded!")
	}
}

message("")

message("First round")
Rprof(tmp <- tempfile())
test_mat(mat)
Rprof()
summ <- summaryRprof(tmp)
message(paste("Elapsed time: ", summ$sampling.time))

message("")
message("Second round (should be cached)")
Rprof(tmp <- tempfile())
test_mat(mat)
Rprof()
summ <- summaryRprof(tmp)
message(paste("Elapsed time: ", summ$sampling.time))

message("")
message("Third round (should be cached)")
Rprof(tmp <- tempfile())
test_mat(mat)
Rprof()
summ <- summaryRprof(tmp)
message(paste("Elapsed time: ", summ$sampling.time))

message("")
message("Fourth round (should be cached)")
Rprof(tmp <- tempfile())
test_mat(mat)
Rprof()
summ <- summaryRprof(tmp)
message(paste("Elapsed time: ", summ$sampling.time))
