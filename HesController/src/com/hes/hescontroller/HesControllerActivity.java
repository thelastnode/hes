package com.hes.hescontroller;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.ArrayList;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.os.Vibrator;
import android.util.Base64;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.view.Window;
import android.view.WindowManager;

import com.hes.hescontroller.views.Joysticks;

public class HesControllerActivity extends Activity {
	private boolean stopped = false;
	private ArrayList<String> buffer = new ArrayList<String>();
	private Vibrator v;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.main);
        v = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
        
        new Thread(new Runnable() {
        	Socket s = null;
            public void run() {
            while (true) {
            	try {
                    s = new Socket("143.215.105.147",4000);
                    BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(s.getOutputStream()));
                    BufferedReader input = new BufferedReader(new InputStreamReader(s.getInputStream()));
                    while (!stopped) {
                    	sendNewMoves(bw);
                    	if (s.getInputStream().available() > 0)
                    		receiveCommands(input);
                    }
            } catch (UnknownHostException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
            } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
            } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
            }
            }
          }
        }).start();
        
        final Joysticks joys = (Joysticks) findViewById(R.id.joysticks);
        joys.setOnTouchListener(new OnTouchListener() {
			public boolean onTouch(View v, MotionEvent event) {
				Log.d("HES",""+event.getAction());
				float x = event.getX(0);
				float y = event.getY(0);
				float x2 = 0, y2 = 0;
				if (event.getPointerCount() > 1) {
					x2 = event.getX(1);
					y2 = event.getY(1);
				}
				float lx = 0, ly = 0, rx = 0, ry = 0;
				boolean send = false;
				if (joys.isInLeft(x, y)) {
					send = true;
					Log.d("HES", "Hit");
					lx = joys.getLeftXCoord(x);
					ly = joys.getLeftYCoord(y);
				} else if (joys.isInLeft(x2, y2) && event.getPointerCount() > 1) {
					send = true;
					Log.d("HES", "Hit2");
					lx = joys.getLeftXCoord(x2);
					ly = joys.getLeftYCoord(y2);
				}
				if (joys.isInRight(x, y)) {
					send = true;
					rx = joys.getRightXCoord(x);
					ry = joys.getRightYCoord(y);
				} else if (joys.isInRight(x2, y2) && event.getPointerCount() > 1) {
					send = true;
					rx = joys.getRightXCoord(x2);
					ry = joys.getRightYCoord(y2);
				}
				if (send) {
					buffer.add(toCommand(lx, ly, rx, ry));
				}
				return !false;
			}
        });
    }
    
    public String toCommand(float x, float y, float x2, float y2) {
    	String ret = "{";
    	if (x != 0.0f || y != 0.0f) {
    		ret += "\"left\": {\"x\":" + x + ", \"y\":" + y + "}";
    	}
    	if (x2 != 0.0f || y2 != 0.0f) {
    		if (ret.length() > 1) {
    			ret += ", ";
    		}
    		ret += "\"right\": {\"x\":" + x2 + ", \"y\":" + y2 + "}";
    	}
    	return ret + "}";
    }
    
    
    public void sendNewMoves(BufferedWriter out) throws IOException {
    	while (!buffer.isEmpty()) {
    		out.write(Base64.encodeToString(buffer.remove(0).getBytes(), Base64.NO_WRAP) + "\n");
    		out.flush();
    	}
    }
    
    public void receiveCommands(BufferedReader br) throws IOException, JSONException {
    	String s = null;
    	Log.d("HES", "ENTER");
    	if ((s = br.readLine()) != null) {
    		Log.d("HES", s);
    		JSONObject j = new JSONObject(s);
    		if (!j.isNull("vibrate")) {
    			v.vibrate(j.getInt("vibrate"));
    		}
    	}
    	Log.d("HES", "EXIT");
    }
    
}