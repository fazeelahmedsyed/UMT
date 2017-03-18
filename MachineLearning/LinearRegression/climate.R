climate <- read.csv("climate_change.csv")
str(climate)
sum(!complete.cases(climate)) #no missing values

train <- climate$Year<2006
summary(train)

test <- !train
summary(test)

lm_fit <- lm(Temp ~. -Year -Month, data = climate, subset = train)
summary(lm_fit)

cor(climate)
lm2_fit <- lm(Temp ~ MEI+TSI+Aerosols+N2O, data = climate, subset = train)
summary(lm2_fit)

step_fit <- step(lm_fit)
step_fit$coefficients

final <- lm(Year ~ MEI +CO2 +N2O +CFC.11 +CFC.12 +TSI +Aerosols, data = climate, subset =train)
summary(final)

preds <- predict(final, newdata = climate[test,])
length(preds)

RSS <- sum((preds - climate$Year[test])^2)
SSE <- sqrt(RSS)
SSE
