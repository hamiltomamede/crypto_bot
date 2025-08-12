# app/workers/twitter_sentiment_worker.rb
class TwitterSentimentWorker
    include Sidekiq::Worker

    def perform(symbol)
        script_path = Rails.root.join("app", "scripts", "sentiment.py")
      result = `python3 #{script_path} #{symbol}`

      begin
        parsed = JSON.parse(result)
        sentiment = parsed["average_sentiment"] || 0

        crypto = Crypto.find_by(symbol: symbol)
        crypto.update(sentiment: sentiment)

        Rails.logger.info("Sentimento de #{symbol} atualizado: #{sentiment}")
      rescue => e
        Rails.logger.error("Erro ao processar #{symbol}: #{e.message}")
      end
    end
end
