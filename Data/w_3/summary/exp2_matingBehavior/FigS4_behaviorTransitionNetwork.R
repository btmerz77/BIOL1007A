
library("igraph")

# labels of each edge
g1 <- graph( edges=c("sig","sig", "follow","sig", "swing","sig", "thrust","sig",
                     "sig","follow", "follow","follow", "swing","follow", "thrust","follow",
                     "sig","swing", "follow","swing", "swing","swing", "thrust","swing",
                     "sig","thrust", "follow","thrust", "swing","thrust", "thrust","thrust"),
             directed = FALSE)
edgeLayout <- layout_in_circle(g1)
tempCoordinate <- edgeLayout[1,]
edgeLayout[1,] <- edgeLayout[2,]
edgeLayout[2,] <- tempCoordinate

# function to make the transition model
behaviorTransition <- function(graphObject)
{
  plot(graphObject, vertex.size = 30, vertex.color = "white",
       vertex.label.color="gray30", vertex.label.font=2, vertex.shape="none",
       edge.width = (E(graphObject)$weight + 1) / 8, layout = edgeLayout)
}


par(mfrow = c(2,2))
# P. reticulata male and P. reticulata female
currentMat <- matrix(c(13, 12, 7, 1,
                       12, 66, 8, 4,
                       6, 9, 8, 0,
                       1, 3, 1, 1), nrow = 4)
# E(g1)$weight <- as.vector(currentMat)
E(g1)$weight <- as.vector(t(currentMat) + currentMat)
g2 <- simplify(g1, remove.multiple = TRUE, remove.loops = TRUE)
behaviorTransition(g2)
text(-1,1, labels = "P_male and P_female", cex = 0.7)


# P. reticulata male and G.affinis female
currentMat <- matrix(c(11, 7, 5, 0,
                  6, 40, 7, 12,
                  6, 7, 5, 4,
                  2, 11, 4, 4), nrow = 4)
# E(g1)$weight <- as.vector(currentMat)
E(g1)$weight <- as.vector(t(currentMat) + currentMat)
g2 <- simplify(g1, remove.multiple = TRUE, remove.loops = TRUE)
behaviorTransition(g2)
text(-1,1, labels = "P_male and G_female", cex = 0.7)

# -----------------------------------------------------
g1 <- graph( edges=c("jolt","jolt", "follow","jolt", "swing","jolt", "thrust","jolt",
                     "jolt","follow", "follow","follow", "swing","follow", "thrust","follow",
                     "jolt","swing", "follow","swing", "swing","swing", "thrust","swing",
                     "jolt","thrust", "follow","thrust", "swing","thrust", "thrust","thrust"),
             directed = FALSE)


# G.affinis male and P.reticulata female
currentMat <- matrix(c(0, 1, 3, 0,
                       1, 2, 0, 2,
                       1, 2, 9, 8,
                       1, 1, 10, 6), nrow = 4)
# E(g1)$weight <- as.vector(currentMat)
E(g1)$weight <- as.vector(t(currentMat) + currentMat)
g2 <- simplify(g1, remove.multiple = TRUE, remove.loops = TRUE)
behaviorTransition(g2)
text(-1,1, labels = "G_male and P_female", cex = 0.7)

# G.affinis male and G.affinis female
currentMat <- c(2, 4, 4, 2,
                0, 7, 3, 4,
                6, 3, 21, 9,
                5, 6, 9, 7)
# E(g1)$weight <- as.vector(currentMat)
E(g1)$weight <- as.vector(t(currentMat) + currentMat)
g2 <- simplify(g1, remove.multiple = TRUE, remove.loops = TRUE)
behaviorTransition(g2)
text(-1,1, labels = "G_male and G_female", cex = 0.7)
lines(c(-2, -1.7),c(-0.6, -0.6), lwd = 1)
lines(c(-2, -1.7),c(-0.8, -0.8), lwd = 5)
lines(c(-2, -1.7),c(-1, -1), lwd = 10)

