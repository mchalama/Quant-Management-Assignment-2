install.packages("lpSolveAPI")
library(lpSolveAPI)
help(add.constraint)

### Weigelt Production Problem
mylp <- make.lp(9, 8)

# Set Objective Function
set.objfn(mylp, c(420, 360, 300, 420, 360, 300, 420, 360))

# Set values for the rows
set.row(mylp, 1, c(1, 1, 1), indices = c(1, 2, 3))
set.row(mylp, 2, c(1, 1, 1), indices = c(4, 5, 6))
set.row(mylp, 3, c(1, 1), indices = c(7, 8)) #,9
set.row(mylp, 4, c(20, 15, 12), indices = c(1, 2, 3))
set.row(mylp, 5, c(20, 15, 12), indices = c(4, 5, 6))
set.row(mylp, 6, c(20, 15), indices = c(7, 8)) #,9
set.row(mylp, 7, c(1, 1, 1), indices = c(1, 4, 7))
set.row(mylp, 8, c(1, 1, 1), indices = c(2, 5, 8))
set.row(mylp, 9, c(1, 1), indices = c(3, 6)) #,9

# Set Right Hand side
rhs <- c(750, 900, 450, 13000, 12000, 5000, 900, 1200, 750)
set.rhs(mylp, rhs)

#set Constraint type
set.constr.type(mylp, rep("<=", 9))

# finally, name the decision variables (column) and constraints (rows)
lp.colnames <- c("P1L", "P1M", "P1S", "P2L", "P2M", "P2S", "P3L", "P3M") #, "P3S")
lp.rownames <- c("P1 Capacity", "P2 Capacity", "P3 Capacity", "P1 Storage", "P2 Storage", "P3 Storage", "Large Sales", "medium Sales", "Small Sales")
dimnames(mylp) <- list(lp.rownames, lp.colnames)

# view the linear program object to make sure it's correct
mylp

# now solve the model
solve(mylp)
# --> A return value of 0 indicates that the model was successfully solved.

# let's look at objecrtive function value
get.objective(mylp)

# how about the optimal decision variable values?
get.variables(mylp)

# how about constraints?
get.constraints(mylp)

# look at surplus for each constraint
get.constraints(mylp) - rhs