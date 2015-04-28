
function(input, output, session) {
  # Define a reactive expression for the document term matrix
  updateFax <- reactive({
    # Change when the "update" button is pressed...
    input$update
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing...")
        #getTermMatrix(input$selection)
        neighbor = getNeighourhood_byAddress(input$address)
        print(neighbor)
        getFax(neighbor)

      })
    })
  })

  # Make the wordcloud drawing predictable during a session
  #wordcloud_rep <- repeatable(wordcloud)

  output$plot <- renderPlot({
    v <- updateFax()
    print(v)

    wordcloud(formattedNames(v), as.numeric(v), scale=c(8,0.5),
#                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Dark2"))
  })
}
