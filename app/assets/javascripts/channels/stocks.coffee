App.stocks = App.cable.subscriptions.create "StocksChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel

    if data['message']['success']
     console.log(data)
     $('#stock_list')[0].value = data['message']['stock']
     window.chart.setTitle({ text: 'Refreshed Real time Stock price of ' + data['message']['stock']})
     window.chart.xAxis[0].setCategories(data['message']['dates'])
     window.chart.series[0].setData (data['message']['close_prices'])
     window.chart.series[1].setData (data['message']['open_prices'])
     window.chart.redraw()
    else
      alert "There was an error"
  speak:(message) ->
    @perform 'speak',message: message

 $(document).on 'click', '#show-realtime', (event) ->
    console.log 'in client side sending message as stock', $('#stock_list')[0].value
    if $('#stock_list')[0].value is 'none'
      alert 'Please select a stock value from Dropdown'
    else  
     App.stocks.speak $('#stock_list')[0].value
     event.target.value = ''
     event.preventDefault()  
