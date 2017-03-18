flu <- read.csv("FluTrain.csv")
str(flu)
summary(flu)
hist(flu$ILI)
hist(flu$Queries)

plot(flu$Queries,log(flu$ILI))

ILI2 <- log(flu$ILI)
flu <- cbind(flu, ILI2)

lm_fit <- lm(ILI2 ~ Queries, data = flu)
summary(lm_fit)
