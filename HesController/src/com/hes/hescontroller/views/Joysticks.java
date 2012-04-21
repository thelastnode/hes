package com.hes.hescontroller.views;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup.LayoutParams;

public class Joysticks extends View {
	protected int radius = 150;
	protected float width, height;
	private int color = 0xFF0066ff;
	private final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
	
	public Joysticks(Context c, AttributeSet as) {
		super(c, as);
	}
	
	public Joysticks(Context context, boolean isLeft) {
		super(context);
		setLayoutParams(new LayoutParams(100, 100));
	}
	
	@Override
	protected void onDraw(Canvas canvas) {
		super.onDraw(canvas);
		width = canvas.getWidth();
		height = canvas.getHeight();
		paint.setColor(color);
		paint.setStyle(Paint.Style.FILL);
		canvas.drawCircle(radius, canvas.getHeight() - radius, radius, paint);
		canvas.drawCircle(canvas.getWidth() - radius, radius, radius, paint);
	}
	
	public boolean isInLeft(float x, float y) {
		float cX = radius, cY = height - radius;
		//return x >= cX - radius && x <= cX + radius && y >= cY - radius && y <= cY + radius;
		return x < width/2;
	}
	
	public boolean isInRight(float x, float y) {
		float cX = width - radius, cY = radius;
		//return x >= cX - radius && x <= cX + radius && y >= cY - radius && y <= cY + radius;
		return x >= width/2;
	}
	
	public float getLeftXCoord(float x) {
		float cX = radius, cY = height - radius;
		return Math.min(1.0f, Math.max(-1.0f, (x - cX) / radius));
	}
	
	public float getLeftYCoord(float y) {
		float cX = radius, cY = height - radius;
		return Math.min(1.0f, Math.max(-1.0f, -1*(y - cY) / radius));
	}
	
	public float getRightXCoord(float x) {
		float cX = width - radius, cY = radius;
		return Math.min(1.0f, Math.max(-1.0f, (x - cX) / radius));
	}
	
	public float getRightYCoord(float y) {
		float cX = width - radius, cY = radius;
		return Math.min(1.0f, Math.max(-1.0f, -1*(y - cY) / radius));
	}
	
	public void setColor(int color) {
		this.color = color;
		invalidate();
	}
}
