source("setup.R")

ui <- fluidPage(title = "Flu in the USA",
  tags$head(
    tags$style(
      HTML('
        .mainbar, .sidebar {
          margin-top: 25px
        }

        #title {
          text-align: center;
          font-size: 48pt;
        }
        
        .tabTitle {
          font-size: 16pt;
        }

        .sidebar, #title {
          background-color: #C5CCDB;
        }

        #title, .tabTitle {
          color: #455882;
        }

        body {
          font-family: "Sans-Serif";
          color: #6C7C9E
        }'
      )
    )
  ),
  titlePanel(div("Flu in the USA", id = "title")),
  tabsetPanel(type = "tabs",
    tabPanel(div("The Affects of Age", class = "tabTitle"),
      sidebarLayout(
        sidebarPanel(class = "sidebar",
          br(),
          radioButtons("season", label = "Choose a Season:",
                  c("Seasons 2012-2017" = "12-17",
                    "Seasons 2005-2011" = "05-11",
                    "Seasons 1997-2004" = "97-04")),
          br(),
          p("The plots shown on the right show the amount of people infected
            with the flu in the USA. The plots differ in the type of flu that people were
            infected with, which was predominantly of", strong("type A, type B"),
            "and", strong("type H3N2v."), "The most common strain of the flu
            goes from top to bottom of these plots: type A, type B, and type H3N2v.
            The x-axis contains the age groups, the y-axis contains the number
            of people found positive for that flu type, and the legend shows
            the flu season color-coded by the year."),
          br(),
          p("This section is meant to show a strong correlation between age
            and catching the flu. Our assumption before looking at any data was
            that the oldest and youngest ends of the spectrum were most likely
            to catch the flu, because that when our immune systems are the weakest.
            However, when looking at the graphs, recent years (2012-2017) show
            peaks of catching the flu at ages 5-24. Looking at older data 
            (2005-2011), it's shown that from all three flu types, ages 5-24 was
            still the age group that caught the flu more than others. While we 
            couldn't conclude that ages at both ends of the spectrum were more 
            more likely to catch the flu, we did see that there is indeed a 
            certain an age where one has the highest chance to contract this disease.
            Thus, we can conclude that age does affect how likely we catch the flu.")
        ),
        mainPanel(class = "mainbar",
          plotlyOutput("age.plot.type.A"),
          br(),
          plotlyOutput("age.plot.type.B"),
          br(),
          plotlyOutput("age.plot.type.H")
        )
      )
    ),
    tabPanel(div("Am I Actually Sick?", class = "tabTitle"),
      sidebarLayout(
        sidebarPanel(class = "sidebar",
          selectInput("year.death", "Select a Year", 
                      choices = c(2013, 2014, 2015, 2016), selected = 2016),
          sliderInput("week.slider", "Display weeks of choice", 
                      min = 1, max = 37, value = c(1, 37), sep = 1)
        ),
        mainPanel(class = "mainbar",
          titlePanel("Word of Mouth: A Placebo?"),
          plotlyOutput("ili.map"),
          br(),
          p("This plot displays a visual of", strong("ILI cases (influenza like illnesses)"),
            "alongside a plot of the desired year's deaths from Washington state. 
            The x-axis shows the weeks of that year, whereas the y-axis shows
            the percentage of", strong("mortality"), "and", strong("ILI cases."),
            "To go more in-depth, the ILI rate was the percentage of people that
            came into clinics noting they had flu-like symptoms, such as fevers,
            coughts, etc. and concluding themselves that they thought they had the flu."),
          br(),
          p("Severity of any illness is best represented by the number of 
            deaths it has caused, as the death count with any illness is what
            shocks the media most. When this media coverage happens, it is 
            statistically prevalent that more people are checking into hospitals
            for ILI cases out of concern for having the actual flu. The question
            we were trying to answer was if the severity of the flu in media
            had a psychological effect on people to think they had the flu; similar
            to having a placebo for the flu. Using our dataset, it was seen that
            the trendline for ILI cases nearly matched the shape of the amount
            of deaths by the flu. As you can see above, the shape of the graphs
            for both the ILI and mortality rate for recent years are very similar.
            Using the amount of deaths as an indicator for severity, we concluded
            that the severity of which the media portrays the flu makes more 
            people think they have flu out of concern. Thus, the higher the death
            count, the greater the number of ILI cases in any given year.")
        )
      )
    ),
    tabPanel(div("Urban VS Rural Environments", class = "tabTitle"),
      sidebarLayout(
        sidebarPanel(class = "sidebar",
          checkboxGroupInput("region.select", "Select Region", 
                             c("1 - Connecticut, Maine, Massachusetts, 
                               New Hampshire, Rhode Island, and Vermont",
                               "2 - New Jersey, New York, Puerto Rico, and 
                               the U.S. Virgin Islands",
                               "3 - Delaware, District of Columbia, Maryland, 
                               Pennsylvania, Virginia, and West Virginia",
                               "4 - Alabama, Florida, Georgia, Kentucky, 
                               Mississippi, North Carolina, South Carolina, 
                               and Tennessee",
                               "5 - Illinois, Indiana, Michigan, Minnesota, Ohio, 
                               and Wisconsin", 
                               "6 - Arkansas, Louisiana, New Mexico, Oklahoma, and Texas",
                               "7 - Iowa, Kansas, Missouri, and Nebraska",
                               "8 - Colorado, Montana, North Dakota, South Dakota, Utah, 
                               and Wyoming",
                               "9 - Arizona, California, Hawaii, and Nevada",
                               "10 - Alaska, Idaho, Oregon, and Washington"), 
                             selected = c("10 - Alaska, Idaho, Oregon, and Washington")),
          selectInput("target.select", "Select target", c("Rate" ,"Count"), 
                      selected = "Rate")
        ),
        mainPanel(class = "mainbar",
          titlePanel("Severity of Flu By Region"),
          plotlyOutput("pediatric.plot"),
          br(),
          p("This plot shows the", strong("rate"), "and", strong("count"),
            "of", strong("pediatric"), "deaths due to the flu. There are
            regions that contain certain states as listed left of the graph,
            with seasons shown on the x-axis and rate/count on the y-axis.
            The legend is also color-coded to more clearly show the trends
            for each region."),
          br(),
          p("The question we were trying to answer was if an urban environment
            led to less deaths by the flu because urban areas like New York 
            City and Seattle have more resources at their disposal to quickly 
            respond to emergencies. The data used for this divides areas by 
            regions, rather than at the state level. Now, after
            viewing the trends show in the graph, it's shown region six, which
            included primarily rural areas like Oklahoma and Arkansas, had the
            highest rate of pediatric death for the flu at 7.7%. In addition, regions
            9 and 10, which had an overall flatter trendline than the other regions,
            were comprised of highly urban states such as Washington and California.
            Both regions even achieved a minimum of 0% for its rate of pediatric death.
            Using this data, we indeed saw that urban areas overall had a lower
            rate and count of pediatric death than rural areas, which supports
            our assumption that an urban environment combats the flu better than
            rural areas.")
        )
      )
    ),
    tabPanel(div("Where Flu Started This Year", class = "tabTitle"),
      sidebarLayout(
        sidebarPanel(class = "sidebar",
          br(),
          p("This graph displays the", strong("level of flu activity in the USA"),
            "In each state there are different levels of color to represent
            the level of flu activity. However, the some areas are left blank
            because there has yet to be recorded flu activity from these states.
            In addition, on the x-axis and y-axis you'll see the coordinates of 
            locations by degrees for longtiude and latitude."),
          br(),
          p("In this choropleth map we tried to use visuals to conclude where
            the flu 'spread out' from. Our assumption was from states bordering
            oceans, such as the East and West coast because they tend to have
            colder and rainier seasons that promote the spread of influenza.
            However, looking at this visual we see that at this point in time
            most states in the USA have been noted to have 'widespread activty'.
            Interesting enough, the only states shown to have few flu activity
            were the states bordering the outline of the USA, which include
            Oregon, Minnesota, and Texas. To use a more analytical approach,
            we could only include that the flu spread from the 'inside' of
            the country to outwards, since they've yet to reach the borderline
            states. Therefore, we can conclude that for this current flu season,
            the flu gained traction towards the central areas of the USA.")
        ),
        mainPanel(class = "mainbar",
          titlePanel("Flu Cases in the USA"),
          plotlyOutput("heat.map")
        )
      )
    ),
    tabPanel(div("Resources", class = "tabTitle"),
             br(),
             p("Thankfully the CDC had all the information we needed for this 
               project, as they've been the main source of data revolving 
               around diseases. In the link provided below you'll find
               further details on the flu for the current and past seasons.
               The data shown in this link provides visuals and explanations,
               as well as a good amount of CSV files to manipulate data from."),
             br(),
             a("Click here for where we sources our information from!",
               href = "https://www.cdc.gov/flu/weekly/index.htm",
               target = "_blank")
    )
  )
)

shinyUI(ui)