#Shiny Application for QTM 151 Project
library(shiny)

states <- read.csv("/Users/alexfan/Desktop/Emory Compiled/Emory Sem 4/QTM 151/Lab Project/states.csv")
country_boi <- read.csv("/Users/alexfan/Desktop/Emory Compiled/Emory Sem 4/QTM 151/Lab Project/country.csv")
# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Maps that are cool"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "maptype", label = "What Map would you like today?",
                  choices = c("US-Foreign", "US-US"), selected = "US-Foreign"
      )
    ),
  mainPanel(
    plotlyOutput("plot")
  )
)
)
# Define server logic required to draw a histogram
server <- function(input, output){
  output$plot <- renderPlotly({
    if(input$maptype == "US-US"){
      gg_plot_US <- ggplot(data = states) +
        geom_polygon(aes(x = long, y = lat, group = group, fill = Total), color ="black") +
        scale_fill_gradient(low = "#FFD5CC", high = "#FF2D00")
      
      gg1 <- ggplotly(gg_plot_US)
      gg1 <- layout(gg1, dragmode = "pan")
      gg1
      
    }else if(input$maptype == "US-Foreign"){
      gg_world_plot <- country_boi %>%
        ggplot() +
        geom_polygon(data = country_boi, aes(x = long, y = lat, group = group, 
                                             fill=total_bookings)) +
        scale_fill_gradient2(low = ("yellow"), mid = "red",
                             high = ("blue"), midpoint = 5000, space = "Lab",
                             na.value = "grey50", guide = "colourbar", aesthetics = "fill")+
        theme(axis.text = element_blank(), axis.title = element_blank())+
        labs(fill="Total Bookings")
      
      gg2 <- ggplotly(gg_world_plot)
      gg2 <- layout(gg2, dragmode = "pan" )
      gg2
    }}
  )
}

# Run the application 
shinyApp(ui = ui, server = server)

