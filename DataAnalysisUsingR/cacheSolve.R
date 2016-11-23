makeCacheMatrix <- function (x = matrix()) {
        
        inv <- NULL
        
        set <- function (y = matrix()) {
                x <<- y
                inv <<- NULL} 
        
        get <- function (){
                x}
        
        setinverse <- function(i) {
                inv <<- i}
        
        getinverse <- function() {
                inv }
        
        list <- list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}


cacheSolve <- function (x,...) {
       
        inv <- x$getinverse()
        
        if(!is.null(inv)) {
                message("Retrieving cached inverse")
                return(inv)}
        else{
                mat <- x$get()
                inv <- solve(mat)
                
                x$setinverse(inv)
                inv}
}