json.array!(@payments) do |payment|
  json.extract! payment, :id, :amount, :responseCode, :responseMessage
  json.url payment_url(payment, format: :json)
end
