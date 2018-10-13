if("plotly" %in% installed.packages("plotly") == FALSE)install.packages("plotly")
library(plotly)
library(shiny)
data <- data.frame(
  Population <- sample(1:20,10,replace = T),
  HouseHolds <- sample(1:20,10,replace = T),
  year <- sample(c(2000,2010),10,replace = T)
)

ui <- fluidPage(
  titlePanel(
  title = h4("인구 조사", align = "center")
),
  sidebarPanel(
   sidebarLayout(
    radioButtons("YEAR","10년 주기선택",
                 choices = c("2000", "2010"),
                 selected = "2000"
                 )
   )
  ),
  mainPanel(
    plotOutput("bar",height=500)
  )
)

server <- function(input, output, session){
  reactive_data <- reactive({
    selected.year <- as.numeric(input$YEAR)
    return(data[data$year == selected_year])
  })
  output$bar <- renderPlot({
    color <- c("blud", "red")
    our_data <- reactive_data()
    barplot(colSums(our_data[,c("Population","HouseHolds")]),
      ylab <- "Total",
      xlab <- "Census Year",
      names.arg = c("Population","HouseHolds"),
      col = color)
  })
}

shinyApp(ui, server)
