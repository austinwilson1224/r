# https://boostedml.com/2019/06/binary-classification-in-r-logistic-regression-probit-regression-and-more-2.html

data_url = "https://www.kaggle.com/andrewmvd/heart-failure-clinical-data/download"
# this is the current directory 
directory_of_this_file = dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(directory_of_this_file)
getwd()
install.packages("neuralnet")
library("neuralnet")

cardio = read.csv("heart_failure_clinical_records_dataset.csv")
head(cardio)

dim(cardio)
summary(cardio)
colnames(cardio)

# lets see which of these are binary 
sapply(cardio, unique)
sum(cardio$DEATH_EVENT == 0)
sum(cardio$DEATH_EVENT == 1)


test_model = glm(DEATH_EVENT ~ ., data = cardio, family = "binomial")
summary(test_model)

model1 = glm(DEATH_EVENT ~ age + sex + smoking, data = cardio, family = "binomial")
model1

summary(model1)

model = lm(DEATH_EVENT ~ age + anaemia + creatinine_phosphokinase + diabetes + ejection_fraction + high_blood_pressure + platelets + serum_creatinine + serum_sodium + sex + smoking + time, data = cardio, family = "binomial")
model
