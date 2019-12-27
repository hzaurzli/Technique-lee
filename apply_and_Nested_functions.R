diff_cor = function(x,z,w){
  apply(x,2,function(y){
    a = cor(y,z) - cor(y,w)
    return(a)
  })
}
