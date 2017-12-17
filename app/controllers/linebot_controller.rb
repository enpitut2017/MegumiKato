class LinebotController < ApplicationController
  require 'line/bot'
  require 'rest-client'

  protect_from_forgery :except => [:callback]

  $status = false

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
      return
    end

    events = client.parse_events_from(body)
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          profile = SocialProfile.where(provider: 'line', uid: event.source['userId']).first
          current_status = profile.user.bicycles.first.status
          if /終/ =~ event.message['text'] && current_status == true then
            message = {
              type: 'text',
              text: '警備を終了します'
            }
            # TODO 警戒状態をやめる
            profile.user.bicycles.each { |bycycle|
              bicycle.status = false
              bicycle.save
            }
          elsif /終/ =~ event.message['text'] && current_status == false then
            message = {
              type: 'text',
              text: '警備していません'
            }
          elsif (/警備/ =~ event.message['text'] || /始/ =~ event.message['text']) && current_status == false then
            message = {
              type: 'text',
              text: '警備を開始します'
            }
            # TODO 警戒状態にする
            profile.user.bicycles.each { |bycycle|
              bicycle.status = true
              bicycle.save
            }
          elsif (/警備/ =~ event.message['text'] || /始/ =~ event.message['text']) && current_status == true then
            message = {
              type: 'text',
              text: '警備中です'
            }
          else
            message = {
              type: 'text',
              # text: event.message['text']
              text: "#{current_status ? 警戒中です : 警備していません}"
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
