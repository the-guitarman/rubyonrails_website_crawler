[![Build Status](https://travis-ci.org/the-guitarman/rubyonrails_website_crawler.svg?branch=master)](https://travis-ci.org/the-guitarman/rubyonrails_website_crawler)

# Website Crawler

This is an after work project, which runs at my raspberry pi at home. 

The app checks some urls for existence and looks for new posts at the website of my village to tweet it. 

__Intension:__ I started the project during the corona pandemic. Hopefully it will help other residents and I to be informed as soon as the municipality publishes new rules, recommendations and information.

At the moment it checks to tweet at [Twitter/claussnitz_de](https://twitter.com/claussnitz): 
- Posts from [claussnitz.de/index.php/aktuelles-2](https://claussnitz.de/index.php/aktuelles-2)
- New PDF files under [claussnitz.de/index.php/amtsblatt](https://claussnitz.de/index.php/amtsblatt)

There are no information added or removed. It reads und posts 1:1 from the urls behind it.

## License

MIT

## TODOs:
- [ ] rake tasks to zip db dump
- [ ] better hash tags
- [ ] test tweet order

## Note

Please give improvements back.
