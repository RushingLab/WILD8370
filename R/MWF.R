MW <- function(first.day, last.day){
  last.wday <- lubridate::wday(last.day)

  if(last.wday == 2){
    last.m <- as.Date(last.day)
    last.w <- as.Date(last.day) - 5
  }

  if(last.wday == 3){
    last.m <- as.Date(last.day) - 1
    last.w <- as.Date(last.day) - 6
  }

  if(last.wday == 4){
    last.m <- as.Date(last.day) - 2
    last.w <- as.Date(last.day)
  }

  if(last.wday == 5){
    last.m <- as.Date(last.day) - 3
    last.w <- as.Date(last.day) - 1
  }

  if(last.wday == 6){
    last.m <- as.Date(last.day) - 4
    last.w <- as.Date(last.day) - 2
  }


  if(lubridate::wday(first.day) == 2){
    Md <- lubridate::day(seq(as.Date(first.day), last.m, "7 days"))
    Mm <- lubridate::month(seq(as.Date(first.day), last.m, "7 days"), label = TRUE)

    Wd <- lubridate::day(seq(as.Date(first.day) + 2, last.w, "7 days"))
    Wm <- lubridate::month(seq(as.Date(first.day) + 2, last.w, "7 days"), label = TRUE)

    M <- paste(Mm, Md, sep = ". ")
    W <- paste(Wm, Wd, sep = ". ")

    if(length(M) > length(W)){
      W <- c(W, rep("", length(M) - length(W)))
    }
    dates <- c(rbind(M,W, rep("", length(M))))
    dates <- dates[-length(dates)]
  }else{
    first.m <- as.Date(first.day) + lubridate::days(2 - lubridate::wday(as.Date(first.day)) + 7)
    first.w <- as.Date(first.day) + lubridate::days(4 - lubridate::wday(as.Date(first.day)))

    Md <- lubridate::day(seq(first.m, last.m, "7 days"))
    Mm <- lubridate::month(seq(first.m, last.m, "7 days"), label = TRUE)

    Wd <- lubridate::day(seq(first.m + 2, last.w, "7 days"))
    Wm <- lubridate::month(seq(first.m + 2, last.w, "7 days"), label = TRUE)

    M <- paste(Mm, Md, sep = ". ")
    W <- paste(Wm, Wd, sep = ". ")

    dates <- c(rbind(M,W, rep("", length(M))))
    dates <- dates[-length(dates)]

    if(lubridate::wday(as.Date(first.day)) < 5){
      Wed <- paste(lubridate::month(first.w, label = TRUE), lubridate::day(first.w), sep = ". ")
      Fri <- paste(lubridate::month(first.f, label = TRUE), lubridate::day(first.f), sep = ". ")
      dates <- c(Wed, Fri, "", dates)
    }else{
      Fri <- paste(lubridate::month(first.f, label = TRUE), lubridate::day(first.f), sep = ". ")
      dates <- c(Fri, "", dates)
    }
  }

  if(last.wday %in% c(2,3)){
    dates <- dates[-length(dates)]
  }

  if(last.wday %in% c(4, 5)){
    dates <- dates[-length(dates)]
  }

  return(dates)
}
