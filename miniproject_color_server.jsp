<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="javax.imageio.*" %>
<%@ page import="java.awt.image.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����ó��</title>
<link rel="stylesheet" href="style.css">
<script src="jquery-3.4.1.js"></script>
</head>
<body>
<%
//������ Ȯ���ؼ� ������� ��Ű�Ӥ�
String u_id = (String)session.getAttribute("u_id");
String u_pass = (String)session.getAttribute("u_pass");

if (u_id == null || u_pass == null){
    out.println("�����ΰ� �ƴ� <br><br>");
return;}
%>

<%
MultipartRequest  multi = new MultipartRequest(request, "c:/Upload", 
	5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
String tmp;
Enumeration params = multi.getParameterNames(); //����! �Ѿ���� ������ �ݴ�.
tmp = (String) params.nextElement();
String addVal = multi.getParameter(tmp);
tmp = (String) params.nextElement();
String algo = multi.getParameter(tmp);

// ** ���� ���� **
Enumeration files = multi.getFileNames();
tmp = (String) files.nextElement();
String filename = multi.getFilesystemName(tmp);
out.println("<p>���ε� ���� :" + filename);

///////////////////////

String para = addVal;


// ���� ���� ����
int[][][] inImage=null;
int inH=0, inW=0;
int[][][] outImage=null;
int outH=0, outW=0;

// (1) JSP ���� ó��
File inFp;
FileInputStream inFs;
inFp = new File("c:/Upload/" + filename);  // mypic.png
// Į�� �̹��� ó��
BufferedImage cImage = ImageIO.read(inFp);
// (2) JSP �迭 ó�� : ���� --> �޸�(2���迭)
//(�߿�!) �Է� ��, ���� ����
inW = cImage.getHeight();
inH = cImage.getWidth();

inImage = new int[3][inH][inW];
// ���� --> �޸�
for (int i=0; i<inH; i++) {
	for (int k=0; k<inW; k++) {
		int rgb = cImage.getRGB(i,k);
		int r = (rgb >> 16) & 0xFF;
		int g = (rgb >> 8) & 0xFF;
		int b = (rgb >> 0) & 0xFF;
		inImage[0][i][k] = r;
		inImage[1][i][k] = g;
		inImage[2][i][k] = b;		
	}
}


// (3) ����ó�� �˰��� �����ϱ�.

switch(algo) {

case "101" : 	// ���� �˰��� : out = 255 - in ���
	// (�߿�!) ��� ��, ���� ���� --> �˰��� ����.
	outH = inH;
	outW = inW;
	outImage = new int[3][outH][outW];
	// ## ��¥ ����ó�� �˰��� ##
	for(int rgb=0; rgb<3; rgb++) {
		for(int i=0; i<inH; i++) {
			for (int k=0; k<inW; k++) {
				outImage[rgb][i][k] = 255 - inImage[rgb][i][k];
			}
		}
	}
	break;
	
case "102" : 
	//��� ��Ӱ� �˰��� : out = in + para
	//(�߿�!) ��� ��, ���� ���� --> �˰��� ����.
	outH = inH;
	outW = inW;
	outImage = new int[3][outH][outW];
	//## ��¥ ����ó�� �˰��� ##
for(int rgb=0; rgb<3; rgb++){	
	for(int i=0; i<inH; i++) {
		for (int k=0; k<inW; k++) {
			int v = inImage[rgb][i][k] + Integer.parseInt(para);
			if (v >255)
				v =255;
		    if (v < 0)
		    	v = 0;
		    outImage[rgb][i][k] = v;
		}
	}
}
	break;

	/*
case "103" : 
	//��� ó�� �˰��� 
	//(�߿�!) ��� ��, ���� ���� --> �˰��� ����.
	outH = inH;
	outW = inW;
	outImage = new int[3][outH][outW];
	//## ��¥ ����ó�� �˰��� ##
		for(int rgb=0; rgb<3; rgb++){
	for(int i=0; i<inH; i++) {
		for (int k=0; k<inW; k++) {
			int pix = inImage[rgb][i][k];
			if (pix >= 127)
				pix =255;
		    if (pix <= 127)
		    	pix = 0;
		    outImage[rgb][i][k] = pix;
		}
	}
		}
	break;
*/
case "103" : 
	//��� ó�� �˰��� 
	//(�߿�!) ��� ��, ���� ���� --> �˰��� ����.
	outH = inH;
	outW = inW;
	outImage = new int[3][outH][outW];
	//## ��¥ ����ó�� �˰��� ##
	
	for(int i=0; i<inH; i++) {
		for (int k=0; k<inW; k++) {
			
			int r = inImage[0][i][k];
			int g = inImage[1][i][k];
			int b = inImage[2][i][k];

			
			int pix = Math.round(r+g+b);
			if (pix >= 127)
				pix =255;
		    if (pix <= 127)
		    	pix = 0;
		    outImage[0][i][k] = outImage[1][i][k] =outImage[2][i][k]= pix;
		}
	}
		
	break;
	
case "104" : 
	//�Ķ󺼶� �˰��� 
	// (�߿�!) ��� ��, ���� ���� --> �˰��� ����.
	outH = inH;
	outW = inW;
	outImage = new int[3][outH][outW];
	int[] LUT=null;
	LUT = new int[256];
	// ## ��¥ ����ó�� �˰��� ##
	
	for(int i=0; i<256; i++){
		
		double outVal= 255.0 - 255.0*Math.pow((i/127.0-1),2.0);
		if(outVal > 255.0)
			outVal = 255.0;
		if(outVal <0.0)
			outVal=0.0;
		LUT[i] =(int)outVal;
	}
	for(int rgb=0; rgb<3; rgb++){
	for(int i=0; i<inH; i++) {
		for (int k=0; k<inW; k++) {
			int inVal = inImage[rgb][i][k];
			int v = LUT[inVal];
			 if (v > 255)
				 v = 255;
			 if (v < 0)
				 v = 0;
			 outImage[rgb][i][k] = v;
		}
	}
	}
	break;
	

case "201" : 
	//���Ϲ��� �˰��� 
	//(�߿�!) ��� ��, ���� ���� --> �˰��� ����.
	outH = inH;
	outW = inW;
	outImage = new int[3][outH][outW];
	//## ��¥ ����ó�� �˰��� ##
for(int rgb=0; rgb<3; rgb++){		
	for(int i=0; i<inH; i++) {
		for (int k=0; k<inW; k++) {
			int lr = inImage[rgb][i][inW -k -1];

		    outImage[rgb][i][k] = lr;
		}
	}
}
	break;		

	
case "202" : 
	//�¿���� �˰��� 
	//(�߿�!) ��� ��, ���� ���� --> �˰��� ����.
	outH = inH;
	outW = inW;
	outImage = new int[3][outH][outW];
	//## ��¥ ����ó�� �˰��� ##
for(int rgb=0; rgb<3; rgb++){		
	for(int i=0; i<inH; i++) {
		for (int k=0; k<inW; k++) {
			int lr = inImage[rgb][inH -i -1][k];

		    outImage[rgb][i][k] = lr;
		}
	}
}
	break;		
	
case "203" : 
	//�����¿� �̷��� �˰��� 
	//(�߿�!) ��� ��, ���� ���� --> �˰��� ����.
	outH = inH;
	outW = inW;
	outImage = new int[3][outH][outW];
	//## ��¥ ����ó�� �˰��� ##
for(int rgb=0; rgb<3; rgb++){		
	for(int i=0; i<inH; i++) {
		for (int k=0; k<inW; k++) {
			int lr = inImage[rgb][inH -i -1][inW -k -1];

		    outImage[rgb][i][k] = lr;
		}
	}
}
	break;	

case "204":
	// ȸ�� �˰���
			int degree = Integer.parseInt(addVal);
		      double radian = degree*Math.PI/180.0;
		      double valuer = Math.sin(radian) + Math.cos(radian);
		      outW = (int)(inH*valuer);
		      outH = (int)(inH*valuer);
		      outImage = new int[3][outH][outW];

		    for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<outH; i++) 
		         for(int k=0; k<outW; k++) 
		            outImage[rgb][i][k] = 0;
		      // ��¥ ����ó�� �˰���
		      radian = -radian;
		      int xs, ys, xd ,yd;
		      int c1 = inH/2;
		      int c2 = outH/2;
		      
		      for (int rgb=0; rgb<3; rgb++)
		      for(int i=0; i<outH; i++) 
		         for(int k=0; k<outW; k++) {
		            xs = i;
		            ys = k;
		            xd = (int)(Math.cos(radian)*(xs-c2) - Math.sin(radian)*(ys-c2) + c1);
		            yd = (int)(Math.sin(radian)*(xs-c2) + Math.cos(radian)*(ys-c2) + c1);
		            if((0 <= xd && xd <inH) && (0 <= yd && yd<inW)) 
		               outImage[rgb][xs][ys] = inImage[rgb][xd][yd];
		         }
	break;
	
case "301":
	// ������ �˰���
	outH = inH;
	outW = inW;
	
	int low;
	int high;
	//�޸� �Ҵ�
	outImage = new int[3][outH][outW];
	
	low = inImage[0][0][0];
	high = inImage[0][0][0];
	
	// ��¥ ����ó�� �˰���
	for (int rgb=0; rgb <3; rgb++)
		for(int i=0; i<inH; i++){
			for(int k=0; k<inW; k++){
				int pixel = inImage[rgb][i][k];
				if(pixel < low)
					low = pixel;
				else if(pixel >high)
					high = pixel;
			}
		}
	low +=50;
	high -=50;
	for(int rgb=0; rgb<3; rgb++)
		for(int i=0; i<inH; i++){
			for(int k=0; k<inW; k++){
				int inValue = inImage[rgb][i][k];
				int outValue = (inValue - low)/(high-low)*255;
				if(outValue >255)
					outValue = 255;
				else if(outValue < 0)
					outValue= 0;
				outImage[rgb][i][k] =outValue;
			}
		}
	break;

case "302":
	// �̹��� Ȯ�� �˰���
	outH = inH*Integer.parseInt(addVal);
	outW = inW*Integer.parseInt(addVal);
	// �޸� �Ҵ�
	outImage = new int[3][outH][outW];
	// ��¥ ����ó�� �˰���
	for (int rgb=0; rgb<3; rgb++)
	for(int i=0; i<outH; i++){
		for(int k=0; k<outW; k++){
			outImage[rgb][i][k] = inImage[rgb][i / Integer.parseInt(addVal)][k / Integer.parseInt(addVal)];
		}
	}
	
	break;

case "303":
	// �̹��� ��� �˰���
	// ���ϱ� �˰��� :  out = in + ��  (����!�����÷�)
	// (�߿�!) ��¿����� ũ�� ���� --> �˰��� ����
	outH = (int)(inH/Integer.parseInt(addVal));
	outW = (int)(inW/Integer.parseInt(addVal));
	// �޸� �Ҵ�
	outImage = new int[3][outH][outW];
	// ��¥ ����ó�� �˰���
	for (int rgb=0; rgb<3; rgb++)
	for(int i=0; i<inH; i++){
		for(int k=0; k<inW; k++){
			outImage[rgb][(int)(i / Integer.parseInt(addVal))][(int)(k / Integer.parseInt(addVal))] = inImage[rgb][i][k];
		}
	}

break;

case "304":
//���翬���� �˰���
		outH = inH;
		outW = inW;
		int[][][] tmpImage6 = new int[3][inH+2][inW+2];
		
		for (int rgb=0; rgb<3; rgb++)
		for(int i=0; i<inH; i++){
			for(int k=0; k<inW; k++){
				tmpImage6[rgb][i+1][k+1] = inImage[rgb][i][k];
			}
		}
	
		// �޸� �Ҵ�
		outImage = new int[3][outH][outW];
		// ��¥ ����ó�� �˰���
		for (int rgb=0; rgb<3; rgb++)
		for(int i=0; i<inH; i++){
			for(int k=0; k<inW; k++){
				double max = 0.0;
				double x = 0.0;
				for(int m=0; m<3; m++){
					for(int n=0; n<3; n++){
						x = Math.abs(tmpImage6[rgb][i+1][k+1] - tmpImage6[rgb][i+m][k+n]);
						if(x>=max)
							max = x;
					}
				}
				if(max > 255)
					max = 255;
				if(max < 0)
					max = 0;
				outImage[rgb][i][k] = (int)max;
			}
		}

break;

case "305":
	// �������� �˰���
			outH = inH;
			outW = inW;
			int[][][] tmpImage7 = new int[3][inH+2][inW+2];
			
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					tmpImage7[rgb][i+1][k+1] = inImage[rgb][i][k];
				}
			}
		
			// �޸� �Ҵ�
			outImage = new int[3][outH][outW];
			// ��¥ ����ó�� �˰���
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					double max = 0.0;
					int x = 0;
						x = Math.abs(tmpImage7[rgb][i][k] - tmpImage7[rgb][i+2][k+2]);
						if(x>=max)
							max = x;
						x = Math.abs(tmpImage7[rgb][i][k+1] = tmpImage7[rgb][i+2][k+1]);
						if(x>=max)
							max = x;
						x = Math.abs(tmpImage7[rgb][i][k+2] = tmpImage7[rgb][i+2][k]);
						if(x>=max)
							max = x;
						x = Math.abs(tmpImage7[rgb][i+1][k+2] = tmpImage7[rgb][i+1][k]);
						if(x>=max)
							max = x;
						if(max > 255)
							max = 255;
						if(max < 0)
							max = 0;
						outImage[rgb][i][k] = (int)max;
				}
			}
break;
	
case "306":
	// ��輱 ���� �˰���
			outH = inH;
			outW = inW;
			double[][] maskW ={{-1.0,-1.0,-1.0},
								{0.0,0.0,0.0},
								{1.0,1.0,1.0}};
			double[][] maskH ={{1.0,0.0,-1.0},
								{1.0,0.0,-1.0},
								{1.0,0.0,-1.0}};
			int[][][] tmpImageW = new int[3][inH+2][inW+2];
			int[][][] tmpImageH = new int[3][inH+2][inW+2];
			int[][][] tmpImageW2 = new int[3][inH][inW];
			int[][][] tmpImageH2 = new int[3][inH][inW];
			
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					tmpImageW[rgb][i+1][k+1] = inImage[rgb][i][k];
					tmpImageH[rgb][i+1][k+1] = inImage[rgb][i][k];
				}
			}
		
			// �޸� �Ҵ�
			outImage = new int[3][outH][outW];
			// ��¥ ����ó�� �˰���
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					double x = 0.0, y = 0.0;
					for(int m=0; m<3; m++){
						for(int n=0; n<3; n++){
							x += maskW[m][n]*tmpImageW[rgb][i+m][k+n];
							y += maskH[m][n]*tmpImageW[rgb][i+m][k+n];
						}
					}
					int v = (int)Math.sqrt(x*x + y*y);
					if(v>255)
						v = 255;
					else if(v<0)
						v = 0;
					outImage[rgb][i][k] = v;
				}
			}
break;

case "307":
	// ������ �˰���
			outH = inH;
			outW = inW;
			double[][] mask4 = {{0.0,-1.0,0.0},
								{-1.0,5.0,-1.0},
								{0.0,-1.0,0.0}};
			int[][][] tmpImage4 = new int[3][inH+2][inW+2];
			
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					tmpImage4[rgb][i+1][k+1] = inImage[rgb][i][k];
				}
			}
		
			// �޸� �Ҵ�
			outImage = new int[3][outH][outW];
			// ��¥ ����ó�� �˰���
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					double x = 0.0;
					for(int m=0; m<3; m++){
						for(int n=0; n<3; n++){
							x += mask4[m][n]*tmpImage4[rgb][i+m][k+n];
						}
					}
					if(x > 255)
						x = 255;
					if(x < 0)
						x = 0;
					outImage[rgb][i][k] = (int)x;
				}
			}
			break;

case "308":
	// ����þ� ���� �˰���
			outH = inH;
			outW = inW;
			double[][] mask3 = {{1.0/16.0,1.0/8.0,1.0/16.0},
								{1.0/8.0,1.0/4.0,1.0/8.0},
								{1.0/16.0,1.0/8.0,1.0/16.0}};
			int[][][] tmpImage3 = new int[3][inH+2][inW+2];
			
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					tmpImage3[rgb][i+1][k+1] = inImage[rgb][i][k];
				}
			}
		
			// �޸� �Ҵ�
			outImage = new int[3][outH][outW];
			// ��¥ ����ó�� �˰���
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					double x = 0.0;
					for(int m=0; m<3; m++){
						for(int n=0; n<3; n++){
							x += mask3[m][n]*tmpImage3[rgb][i+m][k+n];
						}
					}
					if(x > 255)
						x = 255;
					if(x < 0)
						x = 0;
					outImage[rgb][i][k] = (int)x;
				}
			}
			break;
case "401":
	// ���� �˰���
			outH = inH;
			outW = inW;
			double[][] mask2 = {{1.0/9.0,1.0/9.0,1.0/9.0},
					{1.0/9.0,1.0/9.0,1.0/9.0},
					{1.0/9.0,1.0/9.0,1.0/9.0}};
			int[][][] tmpImage2 = new int[3][inH+2][inW+2];
			
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					tmpImage2[rgb][i+1][k+1] = inImage[rgb][i][k];
				}
			}
		
			// �޸� �Ҵ�
			outImage = new int[3][outH][outW];
			// ��¥ ����ó�� �˰���
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					double x = 0.0;
					for(int m=0; m<3; m++){
						for(int n=0; n<3; n++){
							x += mask2[m][n]*tmpImage2[rgb][i+m][k+n];
						}
					}
					if(x > 255)
						x = 255;
					if(x < 0)
						x = 0;
					outImage[rgb][i][k] = (int)x;
				}
			}
			break;
			
			
case "402":
	// ������ �˰���
			outH = inH;
			outW = inW;
			int[][] mask1 = {{-1,0,0},{0,0,0},{0,0,1}};
			int[][][] tmpImage1 = new int[3][inH+2][inW+2];
			
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					tmpImage1[rgb][i][k] = 127;
				}
			}
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					tmpImage1[rgb][i+1][k+1] = inImage[rgb][i][k];
				}
			}
		
			// �޸� �Ҵ�
			outImage = new int[3][outH][outW];
			// ��¥ ����ó�� �˰���
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					int x = 0;
					for(int m=0; m<3; m++){
						for(int n=0; n<3; n++){
							x += mask1[m][n]*tmpImage1[rgb][i+m][k+n];
						}
					}
					x += 127;
					if(x > 255)
						x = 255;
					if(x < 0)
						x = 0;
					outImage[rgb][i][k] = x;
				}
			}
break;
	}
// (4) ����� ���Ͽ� ����
File outFp;
FileOutputStream outFs;
String outname = "out_"+ filename;
outFp = new File("c:/out/"+ outname);
// Į�� �̹��� ����
BufferedImage outCImage = new BufferedImage(outH, outW,
		BufferedImage.TYPE_INT_RGB);
// �޸� --> ����
for(int i=0; i<outH; i++) {
	for(int k=0; k<outW; k++) {
		int r = outImage[0][i][k];
		int g = outImage[1][i][k];
		int b = outImage[2][i][k];
		int px =0;
		px = px | (r << 16);
		px = px | (g << 8);
		px = px | (b << 0);
		outCImage.setRGB(i,k,px);
	}
}
ImageIO.write(outCImage,"jpg", outFp);
String url = "<p><h1><a href='http://192.168.173.3:8080/SampleJSP/";
url += "download.jsp?file=" + outname + "'>�ٿ�ε�</a></h1>";
out.println(url);

%>


</body>
</html>