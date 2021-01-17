c.url.default_page = "https://startpage.com/"
c.url.searchengines = {"DEFAULT": "https://startpage.com/sp/search?q={}"}
c.url.start_pages = "https://startpage.com"
c.auto_save.session = False
c.content.cookies.accept = "no-3rdparty"
c.new_instance_open_target = "tab-silent"
c.content.notifications = False

config.set("content.cookies.accept", "all", "*://*.microsoft.com")
config.set("content.notifications", True, "https://web.whatsapp.com")
config.set("content.cookies.accept", "all", "https://*.wolframalpha.com")
config.set("content.cookies.accept", "all", "https://*.github.com")
config.set("content.cookies.accept", "never", "https://*.youtube.com")