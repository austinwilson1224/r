xor2 = function(x, y) {
  #(x == TRUE & y == FALSE) | (x == FALSE & y == TRUE)
  #(x & !y) | (!x & y)
  (x | y) & !(x & y)
  
}


xor2(TRUE,FALSE)
xor2(TRUE, TRUE)
xor2(FALSE, TRUE)
xor2(FALSE, FALSE)
