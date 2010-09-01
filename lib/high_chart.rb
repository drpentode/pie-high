class HighChart
  attr_accessor :chart, :credits, :colors, :global, :labels, :lang, :legend, :loading, :plot_options, :point, :series,
                :subtitle, :symbols, :title, :toolbar, :tooltip, :x_axis, :y_axis, :x_axis_labels,
                :chart_div, :chart_type, :width

  def initialize(series, options={})
    unless series.kind_of?(Array)
      raise HighChartError, "series must be an Array"
    end

    if options[:x_axis_labels] == nil
      raise HighChartError, "X-Axis labels are required"
    end

    if options[:colors] != nil && !options[:colors].kind_of?(Array)
      raise HighChartError, "Colors must be an Array"
    end

    read_defaults(options[:config_file])

    options.each do |k, v|
      if self.respond_to?(k.to_sym)
        merged_value = merge_defaults(k, v)
        self.instance_variable_set(("@#{k.to_s}").to_sym, merged_value)
      end
    end

    @series = series
  end

  def merge_defaults(key, value)
    default_value = self.send(key.to_s.to_sym)
    if default_value.kind_of?(Hash) && value.kind_of?(Hash)
      default_value.stringify_keys!.merge!(value.stringify_keys!)
    else
      default_value = value
    end

    return default_value
  end

  # read a yaml file of defaults and write out the options
  def read_defaults(config_file)
    begin
      defaults = nil

      if config_file == nil
        defaults = YAML.load_file(RentalAddressConfig.config.high_charts_defaults_file)
      else
        defaults = YAML.load_file(config_file)
      end

      unless defaults == false
        defaults.each do |k, v|
          if self.respond_to?(k.to_sym)
            self.instance_variable_set(("@" + k.to_s).to_sym, v)
          end
        end
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace
      raise e
    end
  end

  def chart
    if @chart_div == nil
      @chart_div = "high-chart-container"
    end

    if @chart_type == nil
      @chart_type = "bar"
    end

    default_chart = {"renderTo" => @chart_div, "defaultSeriesType" => @chart_type}
    default_chart.merge!({"width" => @width}) if width.present?
    default_chart.merge!(@chart) if @chart

    return default_chart
  end

  def colors
    if @colors != nil
      return @colors
    end
  end

  def title
    return {"text" => @title}
  end

  def x_axis
    x_axis_hash = {}
    x_axis_hash["categories"] = @x_axis_labels
    x_axis_hash.merge!(@x_axis) if @x_axis
    return x_axis_hash
  end

  def y_axis
    return @y_axis
  end

  def to_json
    json_hash = {
            :chart => chart,
            :colors => colors,
            :credits => credits,
            :global => global,
            :labels => labels,
            :lang => lang,
            :legend => legend,
            :loading => loading,
            :plotOptions => plot_options,
            :point => point,
            :subtitle => subtitle,
            :symbols => symbols,
            :title => title,
            :toolbar => toolbar,
            :tooltip => tooltip,
            :xAxis => x_axis,
            :yAxis => y_axis,
            :series => series,
            :width => width
    }

    clean_json_hash = json_hash.reject do |key, value|
      value == nil
    end

    return clean_json_hash.to_json
  end
end

class HighChartError < StandardError
end
