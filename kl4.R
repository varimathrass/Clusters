library(R.utils)
library(pracma)
library(knitr)
library(RColorBrewer)
library(Rtsne)
library(rpart)
library(DMwR)

#download.file("http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz",
              "train-images-idx3-ubyte.gz")
#download.file("http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz",
              "train-labels-idx1-ubyte.gz")
#download.file("http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz",
              "t10k-images-idx3-ubyte.gz")
#download.file("http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz",
              "t10k-labels-idx1-ubyte.gz")

#R.utils::gunzip("train-images-idx3-ubyte.gz")
#R.utils::gunzip("train-labels-idx1-ubyte.gz")
#R.utils::gunzip("t10k-images-idx3-ubyte.gz")
#R.utils::gunzip("t10k-labels-idx1-ubyte.gz")

show_digit = function(img) {
  dit <- flip(matrix(rev(as.numeric(DATASET.train[img,-c(1, 786)])), nrow = 28)) #look at one digit
    image(dit, col = grey.colors(255))
}

load_image_file = function(filename) {
  ret = list()
  f = file(filename, 'rb')
  readBin(f, 'integer', n = 1, size = 4, endian = 'big')
  n    = readBin(f, 'integer', n = 1, size = 4, endian = 'big')
  nrow = readBin(f, 'integer', n = 1, size = 4, endian = 'big')
  ncol = readBin(f, 'integer', n = 1, size = 4, endian = 'big')
  x = readBin(f, 'integer', n = n * nrow * ncol, size = 1, signed = FALSE)
  close(f)
  data.frame(matrix(x, ncol = nrow * ncol, byrow = TRUE))
}

load_label_file = function(filename) {
  f = file(filename, 'rb')
  readBin(f, 'integer', n = 1, size = 4, endian = 'big')
  n = readBin(f, 'integer', n = 1, size = 4, endian = 'big')
  y = readBin(f, 'integer', n = n, size = 1, signed = FALSE)
  close(f)
  y
}

train_all = load_image_file("train-images-idx3-ubyte")
digit = train_all[1:20000,]
#digit <- digit/255
test  = load_image_file("t10k-images-idx3-ubyte")


# Divide data in 80:20 ratio - training:test
samp_size <-floor(0.80* nrow(digit))
train_ind <-sample(seq_len(nrow(digit)), size = samp_size)

# Training data
DATASET.train <- as.data.frame(digit[train_ind,])

# Test Data
DATASET.test <-  as.data.frame(digit[-train_ind,])


flip <- function(matrix){
    apply(matrix, 2, rev)
}

par(mfrow=c(3,3))
for (i in 1:27){
    dit <- flip(matrix(rev(as.numeric(DATASET.train[i,-c(1, 786)])), nrow = 28)) #look at one digit
    image(dit, col = grey.colors(255))
}

#barplot(table(DATASET.train$X5), main="Total Number of Digits (Training Set)", col=brewer.pal(9,"Set1"), xlab="Numbers", ylab = "Frequency of Numbers")
#barplot(table(DATASET.test$X5), main="Total Number of Digits (Training Set)", col=brewer.pal(9,"Set1"), xlab="Numbers", ylab = "Frequency of Numbers")


#tsne <- Rtsne(DATASET.train[1:300,-1], dims = 2, perplexity=20, verbose=TRUE, max_iter = 500)

#colors = rainbow(length(unique(DATASET.train$X5)))
#names(colors) = unique(DATASET.train$X5)
#plot(tsne$Y, t='n', main="tsne")


features<-digit[,-1]
pca<-princomp(features)
std_dev <- pca[1:260]$sdev
pr_var <- std_dev^2
prop_varex <- pr_var/sum(pr_var)

plot(cumsum(prop_varex[1:760]), xlab = "Principal Component",
     ylab = "Cumulative Proportion of Variance Explained",
     type = "b")


new_digit<-data.frame(number = digit[,], pca$scores)
new_digit<- new_digit[,1:260]
samp_size <-floor(0.80* nrow(new_digit))
train_ind <-sample(seq_len(nrow(new_digit)), size = samp_size)
train_set <- new_digit[train_ind,]
test_set  <-new_digit[-train_ind,]


kmean <- kmeans(train_set, 10)

str(kmean)

table(kmean$cluster, test_set$number)

pc <- proc.time()
model.rpart <- rpart(train_set$number ~ .,method = "class", data = train_set)
proc.time() - pc

printcp(model.rpart)

train_normalize <- digit/255

covariance_matrix <- cov(train_normalize)
self_values <- eig(covariance_matrix)
plot(self_values)


self_values_normalize <- NULL
N <- -1
for (k in 1:784){
  norm <- sum(self_values[1:k])/sum(self_values[1:784])
  self_values_normalize <- c(self_values_normalize, norm)
  if (norm > 0.95 && N == -1) {
    N <- k
  }
}

plot(self_values_normalize, col = "blue")
plot(self_values_normalize[1:150], col = "blue")
lines(rep(0.95, 99999), col = "red")

indxs <- NULL
for (i in 1:784) {
  if (var(covariance_matrix[i,] > self_values[N])) {
    indxs <- c(indxs, i)
  }
}

pca <-prcomp(train)


summary(pca)


