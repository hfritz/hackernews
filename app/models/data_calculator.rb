class DataCalculator
  attr_accessor :results
  
  def initialize()
    @values = calculate_data
    @results = show_results
    send_results_email
  end
  
  
  def calculate_data
    response = HTTParty.get('http://api.ihackernews.com/page')
    return response.code != 500 ? response["items"].map{|i| i["points"]} : backup_data
  end
  
  def show_results
    {"mean" => mean, "median" => median, "mode" => mode}
  end
  
  private
  
  def send_results_email
    UserMailer.send_results(@results, "test_receiver@paddypower.com").deliver
  end
  
  def mean
    @values.sum.to_f/@values.length if @values.length > 0 
  end
  
  def median
    length = @values.length
    sorted_values = @values.sort
    median = length % 2 == 1 ? sorted_values[length/2] : (sorted_values[length/2 - 1] + sorted_values[length/2]).to_f / 2
    median
  end
  
  def mode
    @values.group_by(&:to_s).values.max_by(&:size).try(:first)
  end
  
  def backup_data
    [116, 72, 201, 42, 59, 386, 9, 17, 144, 18, 17, 337, 370, 7, 86, 70, 23, 7, 28, 63, 124, 12, 85, 9, 57, 74, 172, 5, 44, 215]
  end
  
end