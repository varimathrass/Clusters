install.packages("ggplot2")
install.packages("datasets")
library(datasets)
head(iris)
library(ggplot2)

#     MAIN

#     TASK 1
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()
#     Task 2
# K = 2
set.seed (0) 
irisCluster <- kmeans (iris [, 3: 4], 2, nstart = 20) 

irisCluster 

table(irisCluster$cluster, iris$Species)

irisCluster$cluster <- as.factor(irisCluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = irisCluster$cluster)) + geom_point()

# K = 3
set.seed (0) 
irisCluster <- kmeans (iris [, 3: 4], 3, nstart = 20) 

irisCluster 

table(irisCluster$cluster, iris$Species)

irisCluster$cluster <- as.factor(irisCluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = irisCluster$cluster)) + geom_point()

# k = 4 
set.seed (0) 
irisCluster <- kmeans (iris [, 3: 4], 4, nstart = 20) 

irisCluster 

table(irisCluster$cluster, iris$Species)

irisCluster$cluster <- as.factor(irisCluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = irisCluster$cluster)) + geom_point()
#           Task 3
set.seed (0)
irisCluster <- kmeans (iris [, 3: 4], 2, nstart = 20) 
#           TASK 4
set.seed(0) 
N=matrix(rnorm(10*5))
hc.complete = hclust(dist(N), method="complete") 
plot(hc.complete) 
cutree(hc.complete,h = 4.9)


print(sample(1:30, size = 5, replace = FALSE))






d <- data.frame(x1=rnorm(10),
                x2=rnorm(10),
                x3=rnorm(10))
cor(d)







cbind(c(1,2,3),c(4,5,6))







