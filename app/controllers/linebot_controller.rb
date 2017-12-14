class LinebotController < ApplicationController
  require 'line/bot'
  protect_from_forgery :except => [:callback]

  $status = false

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if /終/ =~ event.message['text'] && $status == true then
            message = {
              type: 'text',
              text: '警備を終了します'
            }
            $status = false
            # TODO 警戒状態をやめる
          elsif /終/ =~ event.message['text'] && $status == false then
            message = {
              type: 'text',
              text: '警備していません'
            }
          elsif (/警備/ =~ event.message['text'] || /始/ =~ event.message['text']) && $status == false then
            message = {
              type: 'text',
              text: '警備を開始します'
            }
            $status = true
            @security_pos = Position.last(1);
            @security_pos.save
            # TODO 警戒状態にする
          elsif (/警備/ =~ event.message['text'] || /始/ =~ event.message['text']) && $status == true then
            message = {
              type: 'text',
              text: '警備中です'
            }
          else
            message = {
              type: 'text',
              text: event.message['text']
            }
          end
          response = client.reply_message(event['replyToken'], message)
          p response
        end
      end
    }
    head :ok
  end

  private
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
