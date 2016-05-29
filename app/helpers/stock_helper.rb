module StockHelper
	def stock_list
	 arr = [['Select stock','none']]
	 Stock::STOCKS_MAP.each{|k,v| arr << [v,k.to_s]}
     arr
	end
end
