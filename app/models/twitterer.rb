class Twitterer
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key='qunYhXJtJGrp6NNa5dUoedhSF'
      config.consumer_secret='SCuREtsy3YvJV6XcW2vAz7CWulZxWBjXSoZU35HZTst3apVNG2'
      config.access_token='3794452101-QH27DqU8v25Nq3hJA4T5lNQGyLiCrJI7FtvPzgX'
      config.access_token_secret='PjLB1IUeXSYSz4lqUkxtg1hgGZtRJsVvxJP5cEvEM6kHy'
    end
  end

  def tweet(text)
    begin
      @client.update(text.truncate(140))
    rescue
    end
  end
end