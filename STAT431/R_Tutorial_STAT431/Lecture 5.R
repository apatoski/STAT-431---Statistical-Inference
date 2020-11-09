

father.son <- read.table("pearson.txt", sep=" ")[,-1]
names(father.son) <- c("fheight", "sheight")
fheight <- father.son$fheight
sheight <- father.son$sheight

## Scatter plot of fheight vs. sheight
## Note that we are calling the column names of the data frame directly here
plot(fheight, sheight)

## We can use the labels we like by invoking the xlab and ylab arguments of
## the plot function
## Type ?plot at the prompt to see a list of other arguments of the function
plot(fheight, sheight, xlab = "Father's height", ylab = "Son's height", main="Height Scatter Plot")



## Sample correlation coefficient
## R function cor can be used for computing sample correlation

## Father Son Data
## We have not attached father.son, so cannot call fheight or sheight directly
cor(father.son$fheight, father.son$sheight)

##Guessing Correlation

a<-read.table(file='Uniform_Points.txt')[,1]


##Example 1 

x<-a
y<-a^2
plot(x, y)
cor(x, y)
summary(lm(y~x))

##Example 2

x<-c(a, -5, -5)
y<-c(a, 100, 101)
plot(x, y)
cor(x, y)


##Example 3

x<-c(rep(1, 99), 5)
y<-a
plot(x, y)
cor(x, y)

##Example 4

x<-c(a, a+100)
y<-c(2*a, -3*a)
plot(x, y)
cor(x, y)

dev.off()

## Put a line on a scatter plot
plot(fheight, sheight, xlab = "Father's height", ylab = "Son's height")
x.bar <- mean(fheight)
s.x <- sd(fheight)
y.bar <- mean(sheight)
s.y <- sd(sheight)
r <- cor(fheight, sheight)
abline(y.bar - x.bar * r*s.y/s.x, r*s.y/s.x, col = "red")


