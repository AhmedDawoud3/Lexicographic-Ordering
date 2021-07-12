function love.conf(t)
    t.version = "11.3"
    t.console = false
    t.accelerometerjoystick = false
    t.externalstorage = false
    t.gammacorrect = false

    t.audio.mic = false
    t.audio.mixwithsystem = false

    t.window.title = "Lexicographic Ordering"
    t.window.width = 400
    t.window.height = 300
    t.window.borderless = false
    t.window.resizable = false
    t.window.fullscreen = false
    t.window.fullscreentype = "desktop"

    t.modules.audio = false
    t.modules.data = true
    t.modules.event = true
    t.modules.font = true
    t.modules.graphics = true
    t.modules.image = false
    t.modules.joystick = false
    t.modules.keyboard = false
    t.modules.math = false
    t.modules.mouse = false
    t.modules.physics = false
    t.modules.sound = false
    t.modules.system = false
    t.modules.thread = false
    t.modules.timer = true
    t.modules.touch = false
    t.modules.video = false
    t.modules.window = true
end
