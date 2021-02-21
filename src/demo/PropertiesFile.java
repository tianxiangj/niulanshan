package demo;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

public class PropertiesFile {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Properties settings = new Properties();

		try {
			settings.load(new FileInputStream("d:\\count.txt"));
		} catch (Exception e) {
			settings.setProperty("count", new Integer(0).toString());
		}
		int c = Integer.parseInt(settings.getProperty("count")) + 1;
		System.out.println("这是本程序被第" + c + "次使用");
		settings.put("ciunt", new Integer(c).toString());

		try {
			settings.store(new FileOutputStream("d:\\count.txt"), "Properties");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		}

	}
}
