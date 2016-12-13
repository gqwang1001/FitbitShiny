
library(shiny)

devtools::install_github("actcool","junruidi")
library(actcool)
library(accelerometry)
library(dplyr)

shinyServer(function(input, output) {
   
  data = reactive({
      file1 = input$file
      if(is.null(file1)){return()}
      read.csv(file = file1$datapath)
    })
  
  output$filedf = renderTable({
    if(is.null(data())){return()}
    input$file
  })
  
  output$idchoices = renderUI({
    if(is.null(data())){return()}
    selectInput("ID", label = "ID", choices = unique(data()$ID))
  })
  
  output$threshold = renderUI({
    if(is.null(data())){return()}
    sliderInput("threshold", label = "Choose your threshold", 
                min = 1,max = 1000,value = 100,step = 1)
  })
  
  output$daychoices = renderUI({
    if(is.null(data())){return()}
    day.dat = filter(data(),ID%in%input$ID)
    selectInput("Day", label = "Day", choices = sort(unique(day.dat$Day)))
  })
  
# summary
  output$sum = renderTable({
    if(is.null(data())){return()}
    selected = selct(data = data(),
                  id = as.numeric(input$ID), 
                  day = as.numeric(input$Day))
    flag.selected = WNW(x = selected)
    accelsummary(x=selected, w= flag.selected,h=input$threshold)
  })
  
# plot  
  output$plot <- renderPlot({
    if(is.null(data())){return()}
    flag = WNW_data(data())
    activity_profile(data = data(), wear = flag,
                     id = input$ID, day = input$Day,h = input$threshold)
  })
  
  # output$contents = renderUI({
  #   if(is.null(data())){return()}
  #   else
  #     tabsetPanel(tabPanel("About file",tableOutput("filedf")),
  #                 tabPanel("Summary",tableOutput("sum")),
  #                 tabPanel("Plot", plotOutput("plot")))
  # })
  
})
