username <- reactiveValues(value = NULL,job="NIL", label = NULL)
userdata <-reactiveValues(productivity=0, rest=0,sleep=0,socialise=0,sports=0,study=0,work=0)
current_activity <- reactiveValues(value= "rest",since=as.numeric(Sys.time()))
print(123)
