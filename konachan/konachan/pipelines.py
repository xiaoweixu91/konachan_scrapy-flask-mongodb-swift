# -*- coding: utf-8 -*-

import pymongo
from scrapy.conf import settings
from scrapy.exceptions import DropItem
from scrapy import log

	
class MongoDBPipeline(object):
    def __init__(self):
        client = pymongo.MongoClient()
        	
        db = client['konachan']
        self.collection = db['kona']
        
    def process_item(self, item, spider):
        valid = True
        
        for data in item:
            if not data:
                valid = False
                raise DropItem("Missing {0}!".format(data))
        if valid:
    		self.collection.insert(dict(item))
    		log.msg("Kona added to MongoDB database! FUCK YOU!",
    			level = log.DEBUG, spider = spider)
        return item


    