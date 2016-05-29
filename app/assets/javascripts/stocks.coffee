# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#stock_list')[0].value = 'none'
  $('#stock_list').change ->
    data = 'stock': $('#stock_list option:selected')[0].value
    if data['stock'] == 'none'
      alert 'Please select one stock from the dropdown'
    else
      $.ajax
        url: '/stocks/add_or_get_stock_item'
        type: 'POST'
        data: data
        error: (response) ->
          alert 'Oops! an error occurred. please try again.'
          return
        success: (data, textStatus, jqXHR) ->
          console.log data
          window.chart = new (Highcharts.Chart)(
            chart: renderTo: '#container'
            title:
              text: 'Stock Price of ' + $('#stock_list option:selected')[0].text
              x: -20
            subtitle:
              text: 'Yahoo finance...'
              x: -20
            xAxis: categories: data['data']['dates']
            yAxis:
              title: text: 'Stock Price in Dollars ($)'
              plotLines: [ {
                value: 0
                width: 1
                color: '#808080'
              } ]
            legend:
              layout: 'vertical'
              align: 'right'
              verticalAlign: 'middle'
              borderWidth: 0
            series: [
              {
                name: 'Close Price'
                data: data['data']['close_prices']
              }
              {
                name: 'Open Price'
                data: data['data']['open_prices']
              }
            ])
          return
    return
  return