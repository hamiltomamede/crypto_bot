import tweepy
from textblob import TextBlob
import json
import sys

# Configuração da API do Twitter
bearer_token = "AAAAAAAAAAAAAAAAAAAAAJ4X0wEAAAAAQdZpBuckAN5YU29zfrNHNEbRsOE%3DX4cmEywsZktxG0Y3AO0VacWUqgZDB1tvDoUUJ8zdzuy0NbP5F6"
client = tweepy.Client(bearer_token=bearer_token)
# Buscar tweets sobre uma moeda
query = sys.argv[1] if len(sys.argv) > 1 else "Bitcoin"
response = client.search_recent_tweets(query=f"{query} -is:retweet lang:en", max_results=50)

# Lista para somar polaridades
sentiment_scores = []

if response.data:
    for tweet in response.data:
        analysis = TextBlob(tweet.text)
        sentiment_scores.append(analysis.sentiment.polarity)

    avg_sentiment = sum(sentiment_scores) / len(sentiment_scores)
else:
    avg_sentiment = 0  # Nenhum tweet encontrado

# Resultado em JSON (para o Rails capturar)
print(json.dumps({"symbol": query, "sentiment_score": avg_sentiment}))