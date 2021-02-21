package user;

import java.util.Scanner;

import com.sun.corba.se.impl.encoding.IDLJavaSerializationInputStream;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class User {
	int a[]={7,9,13,1,15,11,17,19};
	int c[]=new int[13];
	int b[]=new int[5];
	Scanner input=new Scanner(System.in);
	public int[] arrayB(){
		for (int i = 0; i < b.length; i++) {
			System.out.print("请输入长度为5的数组"+i+"下标数组b的内容:");
			b[i]=input.nextInt();
		}
		/*
		 * for (int i= 0;  i< b.length; i++) {
			System.out.println(b[i]);
		}
		*/
		return b;
	}
	public int inputIndex(){
		
		int index=0;
		do {
			System.out.println("请输入需要插入数组a的位置:");
			index= input.nextInt();
		} while (index<0||index>8);
		return index;
	}
	
	
public static void main(String[] args) {
	User a=new User();
	a.arrayB();
}
}
