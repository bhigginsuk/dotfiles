config.load_autoconfig()

c.url.default_page = "https://startpage.com/"
c.url.searchengines = {"DEFAULT": "https://startpage.com/sp/search?q={}"}
c.url.start_pages = "https://startpage.com"
c.auto_save.session = False
c.content.cookies.accept = "no-3rdparty"
c.new_instance_open_target = "tab-silent"
c.content.notifications = False
c.content.headers.do_not_track = False

config.set("content.cookies.accept", "all", "*://*.microsoft.com")
config.set("content.notifications", True, "https://web.whatsapp.com")
config.set("content.cookies.accept", "all", "https://*.wolframalpha.com")
config.set("content.cookies.accept", "all", "https://*.github.com")
config.set("content.cookies.accept", "never", "https://*.youtube.com")

config.bind("<Ctrl-m>", "spawn --userscript umpv {url}")
config.bind("<Ctrl-Shift-m>", "hint links spawn --userscript umpv {hint-url}")
c.aliases["zotero"] = "spawn --userscript zotero"
c.aliases["Zotero"] = "hint links spawn --userscript zotero"
