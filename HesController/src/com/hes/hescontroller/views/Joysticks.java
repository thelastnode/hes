package com.hes.hescontroller.views;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup.LayoutParams;

public class Joysticks extends View {
	protected int radius = 100;
	protected float width, height;
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
		paint.setColor(0xFFFF0000);
		paint.setStyle(Paint.Style.FILL);
		canvas.drawCircle(radius, canvas.getHeight() - radius, radius, paint);
		canvas.drawCircle(canvas.getWidth() - radius, radius, radius, paint);
	}
	
	public boolean isInLeft(float x, float y) {
		float cX = radius, cY = height - radius;
		return x >= cX - radius && x <= cX + radius && y >= cY - radius && y <= cY + radius;
	}
	
	public boolean isInRight(float x, float y) {
		float cX = width - radius, cY = radius;
		return x >= cX - radius && x <= cX + radius && y >= cY - radius && y <= cY + radius;
	}
	
	public float getLeftXCoord(float x) {
		return 0.0f;
	}
	
	public float getLeftYCoord(float y) {
		return 0.0f;
	}
	
	public float getRightXCoord(float x) {
		return 0.0f;
	}
	
	public float getRightYCoord(float x) {
		return 0.0f;
	}
}
