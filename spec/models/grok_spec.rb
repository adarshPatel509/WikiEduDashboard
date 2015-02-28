require 'rails_helper'

describe Grok do


  describe "API requests" do

    it "should get page view data for a given article" do
      VCR.use_cassette "grok/pageview_data" do
        response = Grok.get_views_since_date_for_article("History of Biology", "2014-08-01".to_date)
        expect(response).to be
      end
    end

  end

  describe "API response parsing" do

    it "should return page views for a given article in a certain date range" do
      VCR.use_cassette "grok/pageview_data" do
        views = Grok.get_views_since_date_for_article "History of biology", "2014-09-18".to_date

        # Check for the expected total views over a date range.
        view_sum = 0
        views.each do |day, count|
          if day.to_date <= "2014-12-23".to_date
            view_sum += count
          end
        end
        # The exact values seem to vary a bit, possibly because of updates to
        # the data on stats.grok.se. This should be in the ballpark, though.
        expect(view_sum).to eq(22961)

        # Check for the expected views on a single day.
        expect(views["2014-09-30"]).to eq(267)

      end
    end

  end


  describe "Public methods" do
  end

end
