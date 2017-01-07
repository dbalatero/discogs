#!/usr/bin/env ruby

header = <<-EOF
<html>
<head>
  <title>David's Record Sale</title>
  <style type="text/css">
    body {
      font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    }

    .release {
      display: flex;
      margin-bottom: 1em;
      font-size: 1.5em;
      align-items: center;
    }

    .info {
      padding: 1em;
    }

    .info ul {
      padding-top: 0;
      padding-bottom: 0;
    }

    .artist-title { font-weight: bold; }
    .title { font-style :italic; }

    .prices {
      margin-left: 1em;
      font-size: 70%;
    }

    .youtube {
      font-size: 70%;
    }

    .release:nth-child(even) {
      background-color: #eee;
    }
  </style>
</head>
<body>
  <h1>How to buy</h1>
  <ol>
    <li>Make a list of the records you're interested in</li>
    <li>Send it to me either by email (<a href="mailto:dbalatero@gmail.com">dbalatero@gmail.com</a>)
      or private message</li>
    <li>I'll send you the prices back, and you can decide what you want</li>
  </ol>

  <h2>Discounts?</h2>
  <p>I'll be giving discounts for:</p>

  <ol>
    <li>Buying 5 or more records!</li>
    <li>The first 3 people will get an extra 10% off</li>
  </ol>

  <h2>For Sale</h2>

  <div class="releases">
EOF

footer = <<-EOF
  </div>
</body>
</html>
EOF

releases = STDIN.gets

puts "#{header}\n#{releases}\n#{footer}"
