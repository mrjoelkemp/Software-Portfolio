package com.findafountain;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;

import android.util.Log;

/**
 * Represents the REST adapter that initiates GET and POST commands
 * to a remote server, and parses the result in a usable format.
 */
public class RestClient 
{
	private static final String TAG = "RestClient";
	//Enumeration of possible http actions
	public enum RequestMethod
	{GET, POST }
	
	//Holds the request parameters
    private ArrayList <NameValuePair> params;
    private ArrayList <NameValuePair> headers;
 
    //The URL of the server to connect to.
    private String url;
 
    //HTML Status/Response Code
    private int responseCode;
    private String message;
    private InputStream instream;
    //Whether or not to destroy/close the input stream in processing.
    //If the JSON being returned from the restful server is very large, then
    //	we should parse the input stream, instead of creating a large string of
    //	the server's response. Large strings are prone to OutOfMemory errors.
    private boolean shouldDestroyInputStream = true;
    //Whether or not to convert the server's response to a string.
    //If the server's response is very large, then we don't want to convert
    //	to a string due to OutOfMemory errors.
    private boolean shouldConvertToString = true;
    private String response;
 
    //Accessors
    public String getResponse() {
        return response;
    }

    public String getErrorMessage() {
        return message;
    }
 
    public int getResponseCode() {
        return responseCode;
    }
    public InputStream getInputStream(){
    	return instream;
    }
    
    //Mutator
    public void shouldDestroyInputStream(boolean v){
    	shouldDestroyInputStream = v;
    }
    public void shouldConvertToString(boolean v){
    	shouldConvertToString = v;
    }
 
    //Constructor
    public RestClient(String url)
    {
        this.url = url;
        params = new ArrayList<NameValuePair>();
        headers = new ArrayList<NameValuePair>();
    }
 
    public void AddParam(String name, String value)
    {
        params.add(new BasicNameValuePair(name, value));
    }
 
    public void AddHeader(String name, String value)
    {
        headers.add(new BasicNameValuePair(name, value));
    }
 
    public void Execute(RequestMethod method) throws Exception
    {
        switch(method){
            case GET: {
                //add parameters
                String combinedParams = "";
                if(!params.isEmpty()){
                    combinedParams += "?";
                    for(NameValuePair p : params){
                        String paramString = p.getName() + "=" + URLEncoder.encode(p.getValue(),"UTF-8");
                        if(combinedParams.length() > 1){
                            combinedParams  +=  "&" + paramString;
                        }
                        else{
                            combinedParams += paramString;
                        }
                    }
                }
 
                HttpGet request = new HttpGet(url + combinedParams);
                Log.d(TAG, "Request: " + url + combinedParams);
                
                //add headers
                for(NameValuePair h : headers){
                    request.addHeader(h.getName(), h.getValue());
                }
 
                executeRequest(request, url);
                break;
            }
            case POST:{
                HttpPost request = new HttpPost(url);
 
                //add headers
                for(NameValuePair h : headers){
                    request.addHeader(h.getName(), h.getValue());
                }
 
                if(!params.isEmpty()){
                    request.setEntity(new UrlEncodedFormEntity(params, HTTP.UTF_8));
                }
 
                executeRequest(request, url);
                break;
            }
        }//end switch
    }//end Execute
 
    private void executeRequest(HttpUriRequest request, String url)
    {
        HttpClient client = new DefaultHttpClient();
        HttpResponse httpResponse;
 
        try {
            httpResponse = client.execute(request);
            responseCode = httpResponse.getStatusLine().getStatusCode();
            message = httpResponse.getStatusLine().getReasonPhrase();
 
            HttpEntity entity = httpResponse.getEntity();
            if(entity == null) {
            	Log.e(TAG, "executeRequest: HTTPEntity is NULL!");	
            	return;
            }
            
            instream = entity.getContent();
            if(shouldConvertToString){
            	response = convertStreamToString(instream);
            	Log.d(TAG, "HTTP Response: " + response);
            }
            
            if(shouldDestroyInputStream){           
	            // Closing the input stream will trigger connection release
	            instream.close(); 
	            Log.d(TAG, "executeRequest: Input Stream closed.");
            }
        } 
        catch (ClientProtocolException e)  {
            client.getConnectionManager().shutdown();
            e.printStackTrace();
        } 
        catch (IOException e) {
            client.getConnectionManager().shutdown();
            e.printStackTrace();
        }
    }
 
    /**
     * Converts the input stream to a string
     * @param is Stream to be converted
     * @return A newline separated string with the content from the inputstream.
     */
    private static String convertStreamToString(InputStream is) 
    { 
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();
 
        String line = null;
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line + "\n");
            }
        } 
        catch (IOException e) {
            e.printStackTrace();
        } 
        finally {
            try {
                is.close();
            } 
            catch (IOException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }
}