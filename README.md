## Launch and monitor a python script with Monit on Docker

Clone the repository, and add your script in the scripts/ folder. 
If you need pip dependencies, put them in the requirements.txt file.  

Then build the image :  
`docker build -t me/my_monitored_python_script .`

And run it :  
`docker run -it -p 2812:2812 me/my_monitored_python_script`

Monit will launch the main.py and monitor it as script_wrapper.  
  
To access it, go to localhost:2812 on your web browser.  
The script may take a few moments to appear as running in Monit, but it still starts immediately.  
