library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title or header
  titlePanel(title = h4("Analysis of fitbit data",align="center")),
  sidebarLayout(
    # siderbar panel
    sidebarPanel(
      fileInput("file","Please upload your file"),
      tags$hr(),
      bootstrapPage(
      div(style = "display:block",uiOutput("idchoices")),
      div(style = "display:block",uiOutput("daychoices")),
      div(style = "display:block", uiOutput("threshold")),
      div(style = "display:block", uiOutput("downloadflagbutton"))     
      )
      
      # conditionalPanel(condition = "input.tabselected==3",
      #                  #fileInput("file","Please upload your file"),
      #                  tags$hr(),
      #                  bootstrapPage(
      #                    div(style = "display:block",uiOutput("idchoices")),
      #                    div(style = "display:block",uiOutput("daychoices")),
      #                    div(style = "display:block", uiOutput("threshold"))
      #                    )
    #)
    ),
    
    mainPanel(
        tabsetPanel(
          tabPanel("About file",value = 1,tableOutput("filedf")),
                    tabPanel("Summary",value = 2, tableOutput("sum")),
                    tabPanel("Plot", value = 3, plotOutput("plot")),
          id = "tabselected"
          )
    )
  )
))


