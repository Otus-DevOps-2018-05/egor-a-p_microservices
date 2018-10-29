FROM ruby:2.4.4-alpine3.6

WORKDIR /app

RUN apk --no-cache add make libxml2 libxslt-dev g++

ENV POST_SERVICE_HOST=post \
    POST_SERVICE_PORT=5000 \
    COMMENT_SERVICE_HOST=comment \
    COMMENT_SERVICE_PORT=9292

COPY Gemfile* config.ru helpers.rb middleware.rb ui_app.rb ./
COPY views/* ./views/

RUN bundle install

CMD ["puma"]
