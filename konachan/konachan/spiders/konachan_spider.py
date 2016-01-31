from scrapy import Spider
from scrapy.selector import Selector
from konachan.items  import KonachanItem

class KonachanSpider(Spider):
	name = "konachan"
	allowed_domain = "konachan.com"
	start_urls = [
	"http://konachan.com/post",]

	def parse(self, response):
		result = Selector(response).xpath('//ul[@id="post-list-posts"]/li')
		for li in result:
			item = KonachanItem()
			item['dataid']  = li.xpath('@id').extract()[0]
			item['datasrc'] = li.xpath('./div/a/img/@src').extract()[0]
			yield item

