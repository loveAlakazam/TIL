package com.kh.project.mini.cafe.view;

import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.JFrame;

public class MainFrame extends JFrame{
	
	public MainFrame() {
		setBounds(700,300,300,400);
		
		new MainView(this);
		
		try {
			setIconImage(ImageIO.read(new File("image/coffee.PNG")));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		setResizable(false);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setVisible(true);
	}

}
