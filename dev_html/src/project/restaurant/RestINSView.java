package project.restaurant;

import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

public class RestINSView extends JDialog implements ActionListener{ //부모창이 닫히면 같이 자원이 회수됩니다. 나머지는 JFrame과 같아요.
	JLabel 		jlb_name = new JLabel("식당이름");
	JTextField 	jtf_name = new JTextField(30); 
	JLabel 		jlb_tel  = new JLabel("전화번호");
	JTextField 	jtf_tel  = new JTextField(20); 
	JLabel 		jlb_addr = new JLabel("주소");
	JTextField 	jtf_addr = new JTextField(60); 
	JLabel 		jlb_photo= new JLabel("사진");
	JTextField 	jtf_photo= new JTextField(60); 
	JLabel 		jlb_info = new JLabel("식당소개");
	JTextArea 	jta_info = new JTextArea(8,25); 
	JScrollPane jsp_info = new JScrollPane(jta_info);
	JLabel 		jlb_time = new JLabel("영업시간");
	JTextArea 	jta_time = new JTextArea(8,25); 
	JScrollPane jsp_time = new JScrollPane(jta_time);
	JLabel 		jlb_lat  = new JLabel("위도");
	JTextField 	jtf_lat  = new JTextField(60); 
	JLabel 		jlb_lng  = new JLabel("경도");
	JTextField 	jtf_lng  = new JTextField(60); 
	
	JButton 	jbtn_save  = new JButton("저장");
	JButton 	jbtn_close = new JButton("닫기");
	
	JPanel jp_south = new JPanel();
	
	RestaurantDao rtd = new RestaurantDao();

	public RestINSView() {
		initDisplay();
	}
	/*
	 * div#d_msg{ position: absolute; } --> 좌표값 설정하기
	 * 
	 */
	public void initDisplay() {
		jbtn_save.addActionListener(this);
		jbtn_close.addActionListener(this);
		this.setLayout(null); //기본 BorderLayout인데 좌표값으로 배치하기 위해서 null로 처리
		jlb_name.setBounds(20,20,100,20);
		jtf_name.setBounds(120, 20, 250, 20);
		
		jlb_tel.setBounds(20,45,100,20);
		jtf_tel.setBounds(120, 45, 250, 20);
		
		jlb_addr.setBounds(20,70,100,20);
		jtf_addr.setBounds(120, 70, 250, 20);
		
		jlb_photo.setBounds(20,95,100,20);
		jtf_photo.setBounds(120, 95, 250, 20);
		
		jlb_info.setBounds(20,120,100,20);
		jsp_info.setBounds(120, 120, 300, 80);
		
		jlb_time.setBounds(20,210,100,20);
		jsp_time.setBounds(120, 210, 300, 80);
		
		jlb_lat.setBounds(20,295,100,20);
		jtf_lat.setBounds(120, 295, 250, 20);
		
		jlb_lng.setBounds(20,320,100,20);
		jtf_lng.setBounds(120, 320, 250, 20);
		
		jbtn_save.setBounds(130,380,100,40);
		jbtn_close.setBounds(240, 380, 100, 40);
		
		this.add(jlb_name);
		this.add(jtf_name);
		this.add(jlb_tel);
		this.add(jtf_tel);
		this.add(jlb_addr);
		this.add(jtf_addr);
		this.add(jlb_photo);
		this.add(jtf_photo);
		this.add(jlb_info);
		this.add(jsp_info);
		this.add(jlb_time);
		this.add(jsp_time);
		this.add(jlb_lat);
		this.add(jtf_lat);
		this.add(jlb_lng);
		this.add(jtf_lng);
		this.add(jbtn_save);
		this.add(jbtn_close);
		
		this.setSize(500, 500);
		this.setVisible(true);
	}
	
	public static void main(String[] args) {
		new RestINSView();
	}
	
	@Override
	public void actionPerformed(ActionEvent e) {
		Object obj = e.getSource();
		if(obj.equals(jbtn_close)) {
			System.out.println("Dialog 닫기버튼 호출성공");
			System.exit(0); //가상머신과 연결고리 끈기
			
		}
		else if(obj.equals(jbtn_save)) {
			System.out.println("Dialog 저장버튼 호출성공");
			Map<String, Object> pMap  = new HashMap<String, Object>();
			pMap.put("res_name", jtf_name.getText());
			pMap.put("res_tel" , jtf_tel.getText());
			pMap.put("res_addr", jtf_addr.getText());
			pMap.put("res_photo", jtf_photo.getText());
			pMap.put("res_info" , jta_info.getText());
			pMap.put("res_time" , jta_time.getText());
			pMap.put("lat"  , jtf_lat.getText());
			pMap.put("lng"  , jtf_lng.getText());
			int result = rtd.restINS(pMap);
			if(result == 1) {
				JOptionPane.showMessageDialog(this, "등록되었습니다.");
				this.dispose();
				this.setVisible(false);
			}
		}
	}
}
