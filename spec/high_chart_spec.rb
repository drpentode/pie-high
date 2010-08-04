require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require "high_chart"

describe HighChart do
  before(:each) do
    @series = [{:name => "series1", :data => [0]}, {:name => "series2", :data => [1]}]
    @x_labels = ["label1", "label2"]
    @y_title = "a title"
    @chart = HighChart.new(@series, {:x_axis_labels => @x_labels, :y_axis_title => @y_title, :title => "chart title"})
  end

  it "should read some defaults from a config file" do
    chart = HighChart.new(@series, {:x_axis_labels => @x_labels, :y_axis_title => @y_title, :title => "chart title", :config_file => File.dirname(__FILE__) + "/../assets/high_chart_defaults.yml"})
    chart.legend.should == {"enabled" => true, "layout" => "vertical"}
  end

  it "should be OK if there is no config file" do
    @chart.should_not be(nil)
  end

  it "should merge options from the hash passed in with the values in the config file" do
    chart = HighChart.new(@series, {:x_axis_labels => @x_labels, :legend => {:enabled => false}, :config_file => File.dirname(__FILE__) + "/../assets/high_chart_defaults.yml"})
    chart.legend.should == {"enabled" => false, "layout" => "vertical"}
  end

  it "should set instance variables from the options hash" do
    chart = HighChart.new(@series, {:x_axis_labels => @x_labels, :y_axis_title => @y_title, :title => "chart title", :legend => {:enabled => false}, :config_file => File.dirname(__FILE__) + "/../assets/high_chart_defaults.yml"})
    chart.title.should == {"text" => "chart title"}
  end

  it "should build a chart" do
    @chart.to_json.should_not be(nil)
  end

  it "should return a colors hash" do
    chart = HighChart.new(@series, {:x_axis_labels => @x_labels, :y_axis_title => @y_title, :title => "chart title", :colors => ["red", "green", "blue"]})
    chart.colors.should == ["red", "green", "blue"]
  end

  it "should raise an error if colors are not an array" do
    lambda {HighChart.new(@series, {:colors => "red", :x_axis_labels => @x_labels})}.should raise_error(HighChartError)
  end

  it "should return a title hash" do
    @chart.title.should == {"text" => "chart title"}
  end

  it "should return an xAxis hash" do
    @chart.x_axis.should == {"categories" => ["label1", "label2"]}
  end

  it "should return a yAxis hash" do
    @chart.y_axis.should == {"title" => "a title"}
  end

  it "should fail if no x_axis_labels are provided" do
    lambda {HighChart.new(@series)}.should raise_error(HighChartError)
  end

  it "should output JSON without null entries" do
    @chart.to_json.should_not match(/null/)
  end

  it "should read colors from a config file" do
    chart = HighChart.new(@series, {:x_axis_labels => @x_labels, :y_axis_title => @y_title, :title => "chart title", :config_file => File.dirname(__FILE__) + "/../assets/high_chart_defaults.yml"})
    chart.colors.should == ['#FFFFFF', '#000000']
  end

  it "should merge default chart options from a config file" do
    chart = HighChart.new(@series, {:x_axis_labels => @x_labels, :y_axis_title => @y_title, :title => "chart title", :config_file => File.dirname(__FILE__) + "/../assets/high_chart_defaults.yml"})
    chart.chart.should == {"defaultSeriesType"=>"bar", "renderTo"=>"high-chart-container", "plotBackgroundColor" => "#000000"}
  end

  it "should raise an error if series is not an array" do
    series = {:name => "series1", :data => [0]}
    x_labels = ["label1", "label2"]
    y_title = "a title"
    lambda {HighChart.new(series, {:x_axis_labels => x_labels, :y_axis_title => y_title, :title => "chart title"})}.should raise_error(HighChartError)
  end
end