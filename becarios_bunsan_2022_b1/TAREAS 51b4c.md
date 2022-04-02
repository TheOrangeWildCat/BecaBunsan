# TAREAS

# 2 Hands-on 1: Tools

- 2.1 Using wget
    1. Open terminal
    2. Mimic (option –mk) your college website [http://www.bmsce.in](http://www.bmsce.in/), and access
    locally (turn off your internet).
        
        ![Untitled](TAREAS%2051b4c/Untitled.png)
        
        ![2.1.2.2.png](TAREAS%2051b4c/2.1.2.2.png)
        
    3. Download a large file using the --limit-rate=1m e.g.
    [http://rprustagi.com/workshops/bites/bmsce/movie.mp4](http://rprustagi.com/workshops/bites/bmsce/movie.mp4), break the download
    by pressing Ctrl-C after about 5MB is downloaded and then download with
    resume option (-c). Ensure full download occurs and see if you can watch the
    movie after complete download.
        
        ![Untitled](TAREAS%2051b4c/Untitled%201.png)
        
        ![Untitled](TAREAS%2051b4c/Untitled%202.png)
        
        4. Explore other options such as –d for debug headers, -O to save into a file,
        
        ![Untitled](TAREAS%2051b4c/Untitled%203.png)
        
        ![2.1.4.2.png](TAREAS%2051b4c/2.1.4.2.png)
        
        ![Untitled](TAREAS%2051b4c/Untitled%204.png)
        
- 2.5 Using ping
    
    Ping [google.com](http://google.com/) and [yahoo.com](http://yahoo.com/) by sending some fixed count packets
    e.g. 20. Analyze the response times and variation in response times.
    
    ![Untitled](TAREAS%2051b4c/Untitled%205.png)
    
    ![Untitled](TAREAS%2051b4c/Untitled%206.png)
    
    Ping [myweb.com](http://myweb.com/) with count of 10 pacekts.
    
    ![Untitled](TAREAS%2051b4c/Untitled%207.png)
    
    Ping these sites again in quite mode.
    
    ![Untitled](TAREAS%2051b4c/Untitled%208.png)
    
    Use ping with changing interval duration to 0.2s from the default of 1s as well
    as changing packet size from 56bytes to 1000 bytes.
    
    ![Untitled](TAREAS%2051b4c/Untitled%209.png)
    
- 3.1 Status Code 200
    1. Access your college website with wget using debug options e.g.
    a. wget –d [http://www.bmsce.in](http://www.bmsce.in/)
    
    ![Untitled](TAREAS%2051b4c/Untitled%2010.png)
    
    1. Analyze HTTP request and response message i.e.
    a. Request line
    — GET / HTTP/1.1
        
        b. HTTP Request headers
        
        User- Agent
        
        Accept
        
        Accept- Encoding
        
        Host
        
        Connection 
        
        c. Status line of HTTP Response
        
        HTTP/1.1 200 OK
        
        d. HTTP Response headers.
        
        Date
        
        Expires
        
        Cache-control
        
        Content-type
        
        Serve
        
        X-XSS-protection
        
        X- Frame-Options
        
        Set-Cookie
        
    2. Create a simple webpage e.g. welcome.html (7.1). Save this page in
    DocumentRoot directory of Apache web server. Typically, by default this
    value is /var/www/html.
    3. Access the web page in the browser on a different machine i.e.
    http://<serverIP>/welcome.html
    4. Verify the status code 200 and other required headers.
    5. Access the same webpage using ‘wget –d’ and verify the status code.
        
        ![Untitled](TAREAS%2051b4c/Untitled%2011.png)
        
    6. Access the same webpage using ‘nc’ and verify the status code
    nc [myweb.com](http://myweb.com/) 80
        
        GET /welcome.html HTTP/1.1
        Host: [myweb.com](http://myweb.com/)
        
        ![Untitled](TAREAS%2051b4c/Untitled%2012.png)
        
- 3.2 Content-Type
    
    1.Copy welcome.html file as welcome.txt
    2.Access the url [http://myweb.com/welcome.txt](http://myweb.com/welcome.txt).
    
    ![Untitled](TAREAS%2051b4c/Untitled%2013.png)
    
    3.Look at the content displayed on browser.
    4.Analyze the wireshark capture to study the header Content-Type:
    5.Repeat the exercise with wget.
    6.Study the headers.
    
- 3.3 Status code 404
    1. Access a non-existence webpage e.g nonexist.html
    2. Check the status code in wireshark.
    3. Verify this status code using wget as well.
    
    ![Untitled](TAREAS%2051b4c/Untitled%2014.png)
    
- 3.4 Status code 403
    1. Copy welcome.html file as restricted.html
    2. Remove the read permission for others i.e. issue the command on the web
    server ([myweb.com](http://myweb.com/))
    chmod o-r retricted.html
    3. Access this file using browser i.e.
    http:/myweb.com/restricted.html
    4. Browser should display the contents of the file without formatting.
    5. Analyze the response in the browser. Analyze HTTP status codes.
- 4.1 Using Accept-Language  NO ME FUNCIONO
    1. Change the preferred language setting in firefox browser to language of your
    choice.
    
    ![Captura de pantalla de 2022-04-01 23-03-58.png](TAREAS%2051b4c/Captura_de_pantalla_de_2022-04-01_23-03-58.png)
    
    1. Access [google.com](http://google.com/).
        
        ![Untitled](TAREAS%2051b4c/Untitled%2015.png)
        
    2. The browser should display the content of web page in your preferred
    language.
        
        Los menus del navegador si me los muestra en ingles pero la pagina de google sigue en español.
        
    
- 4.4 Status 206: Partial Content Delivery
    1. Create a simple text file req-partial.txt (7.5) to send the HTTP
    headers requesting specific range of content.
    2. Make a request to web server for partial content delivery i.e.
    
    ![Untitled](TAREAS%2051b4c/Untitled%2016.png)
    
    1. Analyze the HTTP response headers as well wireshark capture.
    
    ![Untitled](TAREAS%2051b4c/Untitled%2017.png)
    
- 4.5 Using compression
    1. To ensure that HTTP Request contains header corresponding to compression,
    create a simple text file e.g. req-gzip.txt (7.6) containing header
    Accept-Encoding: gzip.
    2. Make a request using this header e.g.
    cat req-gzip.txt | nc [myweb.com](http://myweb.com/) 80 >abc.html.gz
    
    ![Untitled](TAREAS%2051b4c/Untitled%2018.png)
    
    1. Analyze the response. Uncompress (gunzip abc.html.gz) it to get the
    original contents.
    
    No se pudo descomprimir, el sistema lo abrio como si fuera documento de texto normal
    
    ![Untitled](TAREAS%2051b4c/Untitled%2019.png)
    
    1. Make a request using wget for HTTP response with compression. Use the
    wget option --header to make such a request.
    wget --header=”Accept-Encoding: gzip”
        
        ![Untitled](TAREAS%2051b4c/Untitled%2020.png)
        
        ![Untitled](TAREAS%2051b4c/Untitled%2021.png)
        
- 5.3 Using Caching.
    1. Using wget – [http://rprustagi.com/workshops/web/welcome.html](http://rprustagi.com/workshops/web/welcome.html) , note down
    value of response header “Last-Modified:”, as well as that of “Etags:”
    
    ![Untitled](TAREAS%2051b4c/Untitled%2022.png)
    
    1. Using wget header option, pass on the value corresponding to response header
    “Last-Modified” in previous step, e.g.
    wget --header=”If-Modified-Since: Tue, 03 Jul 2018
    17:27:18 GMT”
    2. Analyze the response and verify that status is 304 and not 200.
    
    ![Untitled](TAREAS%2051b4c/Untitled%2023.png)
    
    1. Create such a file on your webserver ([myweb.com](http://myweb.com/)) and repeat the exercise.
    2. On the web server modify the date/time of the file using touch command e.g.
    touch welcome.html
    3. Make the request again using wget as in step 2. Note down the header values
    of “Last-Modified:” and “Etags:”
    4. You should get the full content with status code 200.
    5. Modify the date/time of welcome.html file
    6. Make another request using the header i.e. “If-None-Match: “ with the value
    corresponding to “Etags:” in the response as in step. e.g.
    wget -d --header='If-None-Match: "xxxx..."'
    [http://myweb.com/accs/welcome.html](http://myweb.com/accs/welcome.html)
    7. Analyze the response and HTTP Status code.