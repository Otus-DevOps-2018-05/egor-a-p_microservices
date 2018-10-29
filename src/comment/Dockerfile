FROM ruby:2.4.4-alpine3.6

WORKDIR /app

RUN apk --no-cache add make libxml2 libxslt-dev g++

ENV COMMENT_DATABASE_HOST=comment_db \
    COMMENT_DATABASE=comments

COPY Gemfile* config.ru helpers.rb comment_app.rb ./

RUN bundle install

CMD ["puma"]
