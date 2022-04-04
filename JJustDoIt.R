#Step1:Call the Libraries
library(ggplot2)# Data Visualisation
library(sentimentr)
library(dplyr) #Data Wrangling
library(RSentiment) #Sentiment Analysis
library(rtweet)
library(ROAuth)
library(janeaustenr)
library(reshape2)
library(devtools)
library(widyr)
library(lubridate) # Date & Time
library(ggplot2)# Data Visualisation
library(tm) #df Mining
library(wordcloud)
library(readr)
library(tidyr) #Tidy df
library(RColorBrewer) #Data Visualisation
library(stringr) #String Manipulation
library(cowplot) #Plot Arrange
library(ggthemes) #Data Visualisation
library(knitr)
library(kableExtra)
library(ggmap)
library(tm)
library(purrr)
library(twitteR)
library(httpuv)
library(scales)
library(syuzhet)
library(ggmap)
library(stringr)

#Step2:Upload the file
f <- file.choose("justdoit_tweets_2018_09_07_2.csv")
df <- read.csv(f)

#Step3: Process each set of tweets into tidy tweet_full_df or corpus objects.
df = df %>% select(user_screen_name, tweet_full_text)
df

#Step4:Preprocess the Tweets
# Get the text column
tweet_full_text <- df$tweet_full_text
# Set the text to lowercase
tweet_full_text <- tolower(tweet_full_text)
# Remove mentions, urls, emojis, numbers, punctuations, etc.
tweet_full_text <- gsub("@\\w+", "", tweet_full_text)
tweet_full_text <- gsub("https?://.+", "", tweet_full_text)
tweet_full_text <- gsub("\\d+\\w*\\d*", "", tweet_full_text)
tweet_full_text <- gsub("#\\w+", "", tweet_full_text)
tweet_full_text <- gsub("[^\x01-\x7F]", "", tweet_full_text)
tweet_full_text <- gsub("[[:punct:]]", " ", tweet_full_text)
# Remove spaces and newlines
tweet_full_text <- gsub("\n", " ", tweet_full_text)
tweet_full_text <- gsub("^\\s+", "", tweet_full_text)
tweet_full_text <- gsub("\\s+$", "", tweet_full_text)
tweet_full_text <- gsub("[ |\t]+", " ", tweet_full_text)
tweet_full_text

#Step5:Using regular expression with grep, extract tweets with #nike 
nike_df <- df[grep("nike", df$tweet_full_text, value=FALSE), ]
nike_df

#Step6: Dataframe of #nike
nike_df <- data_frame(nike_df)
nike_df

#Step7: Calculate Sentiment Score in each row
library(data.table)
nike_df <- iconv(nike_df$tweet_full_text)
x1 <- rbindlist(lapply(nike_df[1:10],sentiment_by))
x1[,element_id:=.I]
nike <- sentiment_by(nike_df[1:10])

summary(nike$ave_sentiment)

#Step8: Sentiment Histogram for #nike
library(ggplot2)
qplot(nike$ave_sentiment,   geom="histogram",binwidth=0.1,main="Sentiment Histogram for #nike")

#Step9: Using regular expression with grep, extract tweets with #kaepernick
kaepernick_df <- df[grep("kaepernick", df$tweet_full_text, value=FALSE), ]
kaepernick_df

#Step10: Dataframe of #kaepernick
kaepernick_df <- data_frame(kaepernick_df)
kaepernick_df

#Step11: Calculate Sentiment Score in each row

library(data.table)
kaepernick_df <- iconv(kaepernick_df$tweet_full_text)
x1 <- rbindlist(lapply(kaepernick_df[1:10],sentiment_by))
x1[,element_id:=.I]
kaepernick <- sentiment_by(kaepernick_df[1:10])

summary(kaepernick$ave_sentiment)

#Step12: Sentiment Histogram for #kaepernick
library(ggplot2)
qplot(kaepernick$ave_sentiment,   geom="histogram",binwidth=0.1,main="Sentiment Histogram for #kaepernick")


