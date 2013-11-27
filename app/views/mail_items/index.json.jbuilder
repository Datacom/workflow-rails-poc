json.array!(@mail_items) do |mail_item|
  json.extract! mail_item, :name, :watermark, :date, :item_id, :subject, :body, :sender, :from, :is_read
  json.url mail_item_url(mail_item, format: :json)
end
