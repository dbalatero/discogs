#!/usr/bin/env ruby

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

  <<-EOF
    <div class="release">
      <div class="thumbnail">
        <a href="#{info['resource_url']}" target="_blank">
          <img src="#{info['thumb']}" />
        </a>
      </div>
      <div class="info">
        <div class="artist-title">
          <span class="artists">#{artist_links(info['artists'])}</span>
          &mdash;
          <a href="#{info['resource_url']}" target="_blank" class="title">#{info['title']}</a>
        </div>

        <ul class="info">
          #{notes_li(release['notes'])}
        </ul>

        <a class="youtube" href="https://www.youtube.com/results?search_query=#{CGI.escape(info['title'])}" target="_blank">Search Youtube</a>
      </div>
    </div>
  EOF
end

html = releases.map do |release|
  release_html(release)
end.join("\n\n")

puts html
