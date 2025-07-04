import catppuccin

config.load_autoconfig(False)

c.url.start_pages = "about:blank"
c.url.default_page = "about:blank"
c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    'gh': 'https://github.com/search?o=desc&q={}&s=stars',
    'yt': 'https://www.youtube.com/results?search_query={}',
    'mdn': 'https://developer.mozilla.org/en-US/search?q={}',
    'ciu': 'https://caniuse.com/?search={}',
    'tldr': 'https://tldr.inbrowser.app/pages/common/{}',
    'oed': 'https://www.oed.com/search/dictionary/?scope=Entries&q={}'
}

c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
c.tabs.indicator.width = 0
c.tabs.width = '7%'

c.fonts.default_size = '12pt'

c.content.blocking.enabled = True

config.bind("<Shift-J>", "tab-prev")
config.bind("<Shift-K>", "tab-next")
config.bind('gJ', 'tab-move -')
config.bind('gK', 'tab-move +')
config.bind('cc', 'jseval -q document.activeElement.blur()')

catppuccin.setup(c, "mocha", True)
