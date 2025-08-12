# app/workers/sentiment_batch_worker.rb
class SentimentBatchWorker
  include Sidekiq::Worker

  def perform
    Crypto.find_each do |crypto|
      TwitterSentimentWorker.perform_async(crypto.symbol)
    end
  end
end
