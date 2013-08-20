json.array!(@players) do |player|
  json.extract! player, :first_name, :last_name, :position_id, :team
  json.url player_url(player, format: :json)
end
