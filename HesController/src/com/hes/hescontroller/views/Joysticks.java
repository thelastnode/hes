package com.hes.hescontroller.views;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup.LayoutParams;

public class Joysticks extends View {
	protected int radius = 100;
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
		paint.setColor(0xFFFF0000);
		paint.setStyle(Paint.Style.FILL);
		canvas.drawCircle(100, canvas.getHeight() - radius, radius, paint);
		canvas.drawCircle(canvas.getWidth() - radius, radius, radius, paint);
	}
}
