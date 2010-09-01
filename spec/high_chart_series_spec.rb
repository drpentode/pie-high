require "spec_helper"
require "high_chart"
require "high_chart_series"
include Ruport::Data

class ChartData

  def initialize(name="", data=nil)
    @name = name
    @data = data
  end

  attr_accessor :name, :data
end

describe HighChartSeries do

  context "chart data" do
    before(:each) do
      @chart_data = []
      (1..10).each do |i|
        obj = ChartData.new()
        obj.name = rand().to_s
        obj.data = rand().to_s.split(".")[1].slice(0, 3).to_i
        @chart_data << obj
      end
    end

    it "should build a single line of series output" do
      series = HighChartSeries.single_series("my series", "data", @chart_data)
      series.should have_key(:name)
      series.should have_key(:data)
      series.should have_value("my series")
      series.should have_value(@chart_data.collect { |datum| datum.data })
    end

    it "should build multiple lines of series output" do
      series = HighChartSeries.multi_series("name", "data", @chart_data)
      series.size.should == 10
      series.first[:data].size.should == 1
    end

    it "should build a multi-axis series based on multiple discrete data sets" do
      chart_data_sets = []
      (1..5).each do |i|
        chart_data = []
        (1..10).each do |j|
          obj = ChartData.new()
          obj.name = rand().to_s
          obj.data = rand().to_s.split(".")[1].slice(0, 3).to_i
          chart_data << obj
        end
        chart_data_sets << chart_data
      end

      series = HighChartSeries.multi_axis_series(["a", "b", "c", "d", "e"], ["data", "data", "data", "data", "data"], chart_data_sets)
      series.size.should == 5
    end
  end

  context "pivot chart data" do

    let(:series) do
      ChartData.new("Bob", {:bananas => 7, :apples => 13, :ignore_me => 1, :ignore_me_too => 2})
    end

    it "should build a series from pivot table data" do
      x_labels, pivot_series = HighChartSeries.pivot_series("name", "data", [series])
      x_labels.should == [series.name]
      pivot_series.size.should == 4
    end

    it "should build a series from pivot table data, ignoring one of the attributes for the series" do
      x_labels, pivot_series = HighChartSeries.pivot_series("name", "data", [series], :ignore => "ignore_me")
      x_labels.should == [series.name]
      pivot_series.size.should == 3
    end

    it "should build a series from pivot table data, ignoring an array of attributes" do
      x_labels, pivot_series = HighChartSeries.pivot_series("name", "data", [series], :ignore => ["ignore_me", "ignore_me_too"])
      x_labels.should == [series.name]
      pivot_series.size.should == 2
    end

  end

  context "table data" do
    let(:table) do
      Table.new :data => [["Event 1", 2], ["Event 2", 4]], :column_names => %w[ event count ]
    end

    it "should build a multi series from a ruport table" do
      series = HighChartSeries.multi_series("event", "count", table.data.collect(& :data))
      series.size.should == 2
      series.first[:data].first.to_i.should eql(2)
      series.first[:name].should eql("Event 1")
    end

    it "should build a series for a pie chart" do
      series = HighChartSeries.pie_series("Event Compare", "event", "count", table.data.collect(& :data))
      series.first.size.should == 3
      series.first[:type].should eql("pie")
      series.first[:name].should eql("Event Compare")
      series.first[:data].first.first.should eql("Event 1")
    end
  end
end
