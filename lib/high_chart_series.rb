class HighChartSeries
  require "high_chart"

  PIE_CHART_TYPE = "pie"

  class << self

    # builds an array of series from the same data set
    # series_name_attribute - string of method to call to get series name
    # attribute_of_interest - method with the numeric data to build the chart
    # chart_data - array of query results with which to build a series
    def multi_series(series_name_attribute, attribute_of_interest, chart_data, series_options={})
      series = []

      for datum in chart_data
        if datum.kind_of?(Hash)
          series << self.single_series(datum.fetch(series_name_attribute), attribute_of_interest, datum.fetch(attribute_of_interest))
        else
          series << self.single_series(datum.send(series_name_attribute.to_sym), attribute_of_interest, datum.send(attribute_of_interest.to_sym))
        end
      end

      return series
    end

    # will generate a hash for an individual series
    # {:name => "My Wonderful Series", :data => [0, 1, 2, 3]
    # series_options => used to define individual options for series
    def single_series(series_name, attribute_of_interest, chart_series_data, series_options={})
      series_data = []

      if chart_series_data.kind_of?(Array)
        for datum in chart_series_data
          series_data << datum.send(attribute_of_interest)
        end
      else
        series_data << chart_series_data
      end

      unless series_options == nil
        final_series = {:name => series_name, :data => series_data}.merge(series_options)
      else
        final_series = {:name => series_name, :data => series_data}
      end


      return final_series
    end

    # generates a hash for a pie chart
    #  {:type => 'pie', :name => "MyChart", :data => [ [ "event1", 1], ["event2", 2] ] }
    def pie_series(series_name, key, value, chart_series_data)
      final_series = []
      series_data = []

      for datum in chart_series_data
          series_data << [datum.fetch(key), datum.fetch(value)]
      end

      final_series << {:type => PIE_CHART_TYPE, :name => series_name, :data => series_data}

      return final_series
    end

    # accommodates multi-dimensional pivot tables from Ruport
    # also generates your x-axis labels
    def pivot_series(series_name_attribute, attribute_of_interest, chart_data, options={})
      series = []
      x_labels = []
      ignore = nil

      if options && options[:ignore]
        ignore = options[:ignore]
      end

      sample_data_hash = chart_data[0].send(attribute_of_interest.to_sym)
      series_builder = {}

      unless sample_data_hash.is_a?(Hash)
        raise HighChartError, "Please use the multi_series method.  This is not the appropriate chart type for you."
      end

      for datum in chart_data
        data_hash = datum.send(attribute_of_interest)

        data_hash.each do |k, v|
          unless k.to_s == ignore || (ignore && ignore.include?(k.to_s))
            series_builder[k] ||= []
            series_builder[k] << v
          end

          unless x_labels.include?(datum.send(series_name_attribute))
            x_labels << datum.send(series_name_attribute)
          end
        end
      end

      series_builder.each do |k, v|
        series << {:name => k, :data => v}
      end

      return x_labels, series
    end

    # for building multiple, non-identical series for combo line/bar charts from multiple data sets
    # series_name_attributes - attributes to get "name" keys from
    # attributes_of_interest - array of strings naming the attributes to examine
    # chart_data - the data to build the chart from, an array of arrays, if you will
    # series_options - array of hashes to be passed to single_series
    def multi_axis_series(series_name_attributes, attributes_of_interest, chart_data_arr, series_options=[{}, {"type" => "spline"}, {"type" => "spline"}])
      series = []

      chart_data_arr.each_with_index do |chart_data, index|
        inner_series = HighChartSeries.single_series(series_name_attributes[index], attributes_of_interest[index], chart_data, series_options[index])
        series << inner_series
      end

      return series
    end
  end
end