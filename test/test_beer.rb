# encoding: utf-8
#
# = test_beer.rb
#
# Unit Tests for beer model (beer.rb)
#
# Author: James Finlay
##

require 'test/unit'
require 'json'
require 'sqlite3'
require_relative 'helper'
require_relative '../src/beer.rb'

class TestBeer < Test::Unit::TestCase

    def test_populateFromJsonList
        data = Helper.loadMockData("test/mocks/DistinctBeerList.json")
        response = data["response"]

        assert_not_nil response
        assert response["beers"]["count"] > 0

        result = BeerModel.populateFromJsonList(response)

        assert_equal response["beers"]["count"], result.length
    end

    def test_populateFromCrawler

        db = SQLite3::Database.open "test/mocks/TotalWine.db"
        assert_equal db.execute("SELECT * FROM totalWine").length, 50

        result = BeerModel.new(*db.execute("SELECT * FROM totalWine").first)
        assert_not_nil result
        assert_not_nil result.name
    end

end