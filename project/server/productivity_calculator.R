calculateProductivity <- function(startTime,endTime,Activity,result) {
  if (Activity == "sleep") {
    counter = result$sleep
    return(c(calulateSleepProductivity(startTime,endTime),counter))
  } else if (Activity == "work") {
    counter = result$work
      return(c(calulateWorkProductivity(startTime,endTime),counter))
  }
  else if (Activity == "socialise") {
    counter = result$socialise
      return(c(calulateSocialiseProductivity(startTime,endTime),counter))
  }
  else if (Activity == "rest") {
    counter = result$rest
      return(c(calulateBreakProductivity(startTime,endTime),counter))
  }
  else if (Activity == "study") {
    counter = result$study
    return(c(calulateStudyProductivity(startTime,endTime),counter))
 }
 else if (Activity == "sports") {
   counter = result$sports
    return(c(calulateSportsProductivity(startTime,endTime),counter))
 }
}

calulateSleepProductivity <- function(startTime,endTime) {
  startHour <- hour(as_datetime(startTime,  tz = "Asia/Singapore"))
  endHour <- hour(as_datetime(endTime,  tz = "Asia/Singapore"))
  point = 0
  if (startHour<22 && startHour>8) {
    point= point-2
  } else {
    point= point+2
  }
  if (endHour<22 && endHour>8) {
    point= point-2
  } else {
    point= point+2
  }
  duration = endHour - startHour
  if (duration < 7) {
    point= point-3
  } else {
    point= point+3
  }
  return(point)
}

calulateWorkProductivity <- function(startTime,endTime) {
  startHour <- hour(as_datetime(startTime,  tz = "Asia/Singapore"))
  endHour <- hour(as_datetime(endTime,  tz = "Asia/Singapore"))
  point = 0
  if (startHour<22 && startHour>5) {
    point= point+2
  } else {
    point= point-2
  }
  if (endHour<22 && endHour>5) {
    point= point+2
  } else {
    point= point-2
  }
  duration = endHour - startHour
  if (duration < 8 && duration > 3) {
    point= point-3
  } else {
    point= point+3
  }
  return(point)
}

calulateSocialiseProductivity <- function(startTime,endTime) {
  startHour <- hour(as_datetime(startTime,  tz = "Asia/Singapore"))
  endHour <- hour(as_datetime(endTime,  tz = "Asia/Singapore"))
  point = 0
  
  if (startHour<23 && startHour>8) {
    print("bonus start")
    point= point+1
  } else {
    point= point-1
  }
  if (endHour<23 && endHour>8) {
    print("bonus end")
    point= point+1
  } else {
    point= point-1
  }
  duration = (endTime - startTime)/60
  if (duration < 3) {
    print("bonus duration")
    point= point+1
  } else {
    point= point-1
  }
  return(point)
}

calulateBreakProductivity <- function(startTime,endTime) {
  point = 0
  duration = (endTime - startTime)
  if (duration < 30) {
    point= point+1
  } else {
    point= point-1
  }
  return(point)
}

calulateSportsProductivity <- function(startTime,endTime) {
  point <-0
  duration <- (endTime - startTime)/60
  if (duration > 1 && duration <5) {
    point= point+4
  } else {
    point= point-2
  }
  return(point)
}

calulateStudyProductivity <- function(startTime,endTime) {
  startHour <- hour(as_datetime(startTime,  tz = "Asia/Singapore"))
  endHour <- hour(as_datetime(endTime,  tz = "Asia/Singapore"))
  point = 0
  if (startHour<22 && startHour>5) {
    point= point+1
  } else {
    point= point-1
  }
  if (endHour<22 && endHour>5) {
    point= point+1
  } else {
    point= point-1
  }
  duration = (endTime - startTime)/60
  if (duration < 1) {
    point= point-2
  } else {
    point= point+2
  }
  return(point)
}