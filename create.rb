#!/usr/bin/env ruby

require 'bundler'
Bundler.setup
Bundler.require :default

require 'discogs-wrapper'

api_token = ENV['DISCOGS_API_KEY']
$wrapper = Discogs::Wrapper.new("Test OAuth", user_token: api_token)

require 'json'
require 'pp'
require 'cgi'

releases = JSON.parse(File.read("releases.json"))

def artist_links(artists)
  artists.map do |artist|
    %Q{<a href="#{artist['resource_url']}" target="_blank">#{artist['name']}</a>}
  end.join(", ")
end

def notes_li(notes)
  notes.map do |note|
    name = {
      1 => "Disc Condition",
      2 => "Sleeve Condition",
      3 => "Extra Notes"
    }[note['field_id']]

    %Q{<li class="note"><span class="note-name">#{name}:</span> #{note['value']}</li>}
  end.join("\n")
end

def release_html(release)
  info = release['basic_information']

  api_data = $wrapper.get_release(release['basic_information']['id'])

  url = api_data['resource_url']
    .gsub(/api./, "")
    .gsub("releases", "release")

  price = sprintf "%0.2f", api_data['lowest_price'].to_f

  <<-EOF
    <div class="release">
      <div class="thumbnail">
        <a href="#{url}" target="_blank">
          <img src="#{info['thumb']}" />
        </a>
      </div>
      <div class="info">
        <div class="artist-title">
          <span class="artists">#{artist_links(info['artists'])}</span>

          &mdash;

          <a href="#{url}" target="_blank" class="title">#{info['title']}</a>
        </div>

        <ul class="info">
          #{notes_li(release['notes'])}
        </ul>

        <a class="youtube" href="https://www.youtube.com/results?search_query=#{CGI.escape(info['title'])}" target="_blank">Search Youtube</a>
        <a class="prices" href="#{url}" target="_blank">Check prices (lowest price: $#{price})</a>
      </div>
    </div>
  EOF
end

html = releases.map do |release|
  release_html(release)
end.join("\n\n")

puts html
