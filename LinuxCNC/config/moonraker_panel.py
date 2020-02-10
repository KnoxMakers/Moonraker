print("Loading moonraker_panel.py...")

def laser_hide(widget):
    widget.winfo_manager()
    widget.tk.call(widget.winfo_manager(), "forget", widget)

# Remove view angles which make no sense for a laser cutter
laser_hide(widgets.view_z2)
laser_hide(widgets.view_x)
laser_hide(widgets.view_y)
laser_hide(widgets.view_p)

# Force view to top-down on startup
commands.set_view_z()

# Attach table U to traditional Pg Up/Dn
bind_axis("Next", "Prior", 6)
bind_axis("KP_Next", "KP_Prior", 6)

# Make Z accessible with [] just in case
bind_axis("bracketleft", "bracketright", 2)

if hal_present:
    boundcomp = hal.component("boundaries")
    boundcomp.newpin("xmin",hal.HAL_FLOAT,hal.HAL_OUT)
    boundcomp.newpin("xmax",hal.HAL_FLOAT,hal.HAL_OUT)
    boundcomp.newpin("ymin",hal.HAL_FLOAT,hal.HAL_OUT)
    boundcomp.newpin("ymax",hal.HAL_FLOAT,hal.HAL_OUT)
    boundcomp.newpin("zmin",hal.HAL_FLOAT,hal.HAL_OUT)
    boundcomp.newpin("zmax",hal.HAL_FLOAT,hal.HAL_OUT)
    boundcomp.ready()


if vars.metric.get():
    conv = 1
else:
    conv = 1/25.4

last_running = None
run_start = None
run_time = 0

def runtimelog():
    global last_running
    global run_start
   
    r = running() and not s.paused

    if last_running != r:
        if r:
            run_start = time.time()
            print "{}: started".format(s.file)
        elif run_start:
            timediff = time.time()-run_start
            f = open("run.log","a")
            if s.paused:
                f.write("{}:paused:{}\n".format(s.file, timediff))
                print "{}: paused ({} seconds)".format(s.file, timediff)
            else:
                f.write("{}:stopped:{}\n".format(s.file, timediff))
                print "{}: stopped ({} seconds)".format(s.file, timediff)
            f.close()
            run_start = None
        last_running = r
    

# this function is called at [DISPLAY]CYCLE_TIME interval
def user_live_update():
    runtimelog()
    
    min_extents = from_internal_units(o.canon.min_extents, conv)
    max_extents = from_internal_units(o.canon.max_extents, conv)
    boundcomp['xmin'] = min_extents[0]
    boundcomp['xmax'] = max_extents[0]
    boundcomp['ymin'] = min_extents[1]
    boundcomp['ymax'] = max_extents[1]
    boundcomp['zmin'] = min_extents[2]
    boundcomp['zmax'] = max_extents[2]
