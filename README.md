## Launch and monitor a python script with Monit on Docker

You need to have priorly installed and configured [Docker](https://www.docker.com/). 

Clone the repository, and add your python script(s) in the `scripts/` folder.  
By default, Monit will look for a `main.py` file, but you can change it in the `script_wrapper`.  
If you need pip dependencies, put them in the `requirements.txt` file.  

In the `Dockerfile`, replace the `SCRIPT_NAME` environment variable with the script name you want to see in Monit.  

Then build the image :  
`docker build -t me/my_monitored_python_script .`

And run it :  
`docker run -it -p 2812:2812 me/my_monitored_python_script`

Monit will launch the `main.py` and monitor it with the name set in the `Dockerfile`.  
  
To access it, go to `localhost:2812` on your web browser.  
The script may take a few moments to appear as running in Monit, but it still starts immediately.  

If you wish to manage several scripts, you will need to create a script wrapper for every script, and add a "check process" order for them in the `conf.d/` folder.  
