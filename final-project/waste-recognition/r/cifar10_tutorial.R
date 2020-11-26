library(keras)
library(tensorflow)


# why not use r?
# https://blogs.rstudio.com/ai/posts/2019-08-29-using-tf-from-r/
# The short answer is, you have keras, tensorflow and reticulate installed. reticulate embeds a Python session within the R process.


cifar = dataset_cifar10()


# classnames derinition
class_names = c("airplane","automobile","bird","cat","deer","dog","frog","horse","ship","truck")
index = 1:30


par(mfcol = c(5,6), mar = rep(1, 4), oma = rep(0.2, 4))
cifar$train$x[index,,,] %>% 
  purrr::array_tree(1) %>%
  purrr::set_names(class_names[cifar$train$y[index] + 1]) %>% 
  purrr::map(as.raster, max = 255) %>%
  purrr::iwalk(~{plot(.x); title(.y)})


# create model
model <- keras_model_sequential() %>% 
  layer_conv_2d(filters = 32, kernel_size = c(3,3), activation = "relu", 
                input_shape = c(32,32,3)) %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_conv_2d(filters = 64, kernel_size = c(3,3), activation = "relu") %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_conv_2d(filters = 64, kernel_size = c(3,3), activation = "relu")


summary(model)


model %>% 
  layer_flatten() %>% 
  layer_dense(units = 64, activation = "relu") %>% 
  layer_dense(units = 10, activation = "softmax")


summary(model)



# compile model 
model %>% compile(
  optimizer = "adam",
  loss = "sparse_categorical_crossentropy",
  metrics = "accuracy"
)

history <- model %>% 
  fit(
    x = cifar$train$x, y = cifar$train$y,
    epochs = 10,
    validation_data = unname(cifar$test),
    verbose = 2
  )



# evaluate model 
plot(history)
evaluate(model, cifar$test$x, cifar$test$y, verbose = 0)




##########
# transfer learning
# https://tensorflow.rstudio.com/tutorials/advanced/images/transfer-learning-hub/
########## 
library(keras)
library(tfhub)
library(tfhub)

# image classification models 
# https://tfhub.dev/s?module-type=image-classification

classifier_url ="https://tfhub.dev/google/tf2-preview/mobilenet_v2/classification/2"
image_shape = c(224L,224L,3L)

classifier = layer_hub(handle=classifier_url, input_shape=image_shape)


# run it on a single image 
image_url <- "https://storage.googleapis.com/download.tensorflow.org/example_images/grace_hopper.jpg"

img <- pins::pin(image_url, name = "grace_hopper") %>%
  tensorflow::tf$io$read_file() %>% 
  tensorflow::tf$image$decode_image(dtype = tf$float32) %>% 
  tensorflow::tf$image$resize(size = image_shape[-3])
img %>% 
  as.array() %>% 
  as.raster() %>% 
  plot()


result <- img %>% 
  tf$expand_dims(0L) %>% 
  classifier()

predicted_class <- tf$argmax(result, axis = 1L) %>% as.integer()
predicted_class


labels_url <- "https://storage.googleapis.com/download.tensorflow.org/data/ImageNetLabels.txt"

imagenet_labels <- pins::pin(labels_url, "imagenet_labels") %>% 
  readLines()


img %>% 
  as.array() %>% 
  as.raster() %>% 
  plot()
# 
title(paste("Prediction:" , imagenet_labels[predicted_class + 1]))
flowers <- pins::pin("https://storage.googleapis.com/download.tensorflow.org/example_images/flower_photos.tgz", "flower_photos")
image_generator <- image_data_generator(rescale=1/255)
image_data <- flowers[1] %>% 
  dirname() %>% 
  dirname() %>% 
  flow_images_from_directory(image_generator, target_size = image_shape[-3])
str(reticulate::iter_next(image_data))
