
import json
import math
import matplotlib.pyplot as plt
import numpy as np
import os
import pandas as pd
import statistics






def main():
    """
    """

    print("running main")

    tasks = [0, 1]

    if 0 in tasks: calculate_parameters()


    print("completed main")



def calculate_parameters(): 
    """
    calculate parameters 
    """

    xx = 75 
    yy = 60 
    zz = 1.85 
    rr = 4 

    offsetx = 16 
    offsety = 6 
    compressiony = 0.9 

    dh = zz+.2 
    dt = 4 
    db = 0.75 

    rh = 0.5 

    data = {}

    data["volume unit"] = "mL"
    data["length unit"] = "mm"
    data["xx"] = xx
    data["yy"] = yy
    data["zz"] = zz
    data["rr"] = rr

    data["dh"] = dh
    data["dt"] = dt
    data["db"] = db

    ii = math.floor((xx-offsetx)/dt)
    jj = math.floor((yy-offsety)/compressiony/dt)
    data["ii"] = ii
    data["jj"] = jj
    data["well count"] = int(data["ii"]*data["jj"])

    reservoir_volume = (ii+1)*dt*(jj+1)*dt*compressiony*rh/1000
    data["reservoir volume"] = reservoir_volume


    # equation 
    # https://mathmonks.com/frustum/truncated-cone
    well_volume = 1/3*3.14159*(zz-rh)*(dt/2*dt/2+db/2*db/2+dt/2*db/2)/1000

    data["well volume"] = well_volume 
    data["total well volume"] = well_volume* data["well count"]

    data["total internal volume"] = data["total well volume"]  +  reservoir_volume 


    print("hello")


    import json
    with open('00106_parameters.json', 'w') as f:
        json.dump(data, f, indent=4)


if __name__ == "__main__":
    main()



