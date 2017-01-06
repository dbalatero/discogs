#!/usr/bin/env ruby

require 'bundler'
Bundler.setup
Bundler.require :default

require 'json'
require 'discogs-wrapper'

api_token = ENV['DISCOGS_API_KEY']
wrapper = Discogs::Wrapper.new("Test OAuth", user_token: api_token)

username = "dbalatero"
folders = wrapper.get_user_folders(username)

folder = folders['folders'].detect do |folder|
  folder['name'] == "Sell"
end

releases = wrapper.get_user_folder_releases(
  username,
  folder['id'],
  sort: 'artist',
  per_page: 100
)

releases2 = wrapper.get_user_folder_releases(
  username,
  folder['id'],
  sort: 'artist',
  per_page: 100,
  page: 2
)

releases = releases['releases'] + releases2['releases']

File.open("releases.json", "wb") do |f|
  f.write releases.to_json
end

puts "DONE"
