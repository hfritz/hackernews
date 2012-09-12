desc "gets hackernews homepage data, calculate mean, median and mode and send an email with it"
task :calculate_data_and_send_results => :environment do
  DataCalculator.new
end