# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class StocksChannel < ApplicationCable::Channel
  def subscribed
    stream_from "stocks_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    return_data = {}
  	date = Date.today + rand(10)
    new_stock = Stock.new(ticker: data['message'],name: Stock::STOCKS_MAP[data['message']],trade_date: date, open_price: 10.00, close_price: 20.00)
    new_stock.save
    Rails.logger.info "=====data==#{data}====Stock.where(:ticker => data[:message])==#{Stock.where(:ticker => data['message'].to_s).inspect}==="
    if new_stock.save
      return_data[:success] = true
      #return_data[:date] = date
      #return_data[:open_price] = new_stock.open_price.to_f
      #return_data[:close_price] = new_stock.close_price.to_f
      open_prices = []
      close_prices = []
      dates = []
      Stock.where(:ticker => data['message'].to_s).each do |s|
      	open_prices.push(s.open_price.to_f)
        close_prices.push(s.close_price.to_f)
        dates.push(s.trade_date)
      end
      return_data[:stock] = data['message']
      return_data[:dates] = dates
      return_data[:close_prices] = close_prices
      return_data[:open_prices] = open_prices
      #
      #chart = Highchart.new do |chart|
	#		  chart.chart(renderTo: 'graph')
	#		  chart.title('Highcharts Example')
	#		  chart.xAxis(categories: ['October 12', 'October 13', 'October 14'])
	#		  chart.yAxis(title: 'Impressions', min: 0)
	#		  chart.series(name: 'Impressions', yAxis: 0, type: 'line', data: [100000, 122000, 127000])
	#		  chart.legend(layout: 'vertical', align: 'right', verticalAlign: 'top', x: -10, y: 100, borderWidth: 0)
	#		  chart.tooltip(formatter: "function(){ return '<b>' + this.series.name + '</b><br/>' + this.x + ': ' + this.y; }")
    #   end
     #  return_data[:chart] = chart
    else
      return_data = {success: false, :messages => new_stock.errors.inspect}
    end
    Rails.logger.info "====return_data==#{return_data}====="
   ActionCable.server.broadcast 'stocks_channel', message: return_data
  end
end
