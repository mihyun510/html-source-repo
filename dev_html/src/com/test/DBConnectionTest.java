package com.test;

import com.util.DBConnectionMgr;
public class DBConnectionTest {
	void methodA(DBConnectionMgr dbMgr) {
		System.out.println(this);
	}
	public static void main(String[] args) {
		DBConnectionTest dbTest = new DBConnectionTest();
		DBConnectionMgr dbMgr1 = DBConnectionMgr.getInstance();
		DBConnectionMgr dbMgr2 = DBConnectionMgr.getInstance();
		dbTest.methodA(dbMgr1);
		dbTest.methodA(dbMgr2); //2개의 주소가 같음. 즉, 하나의 인스턴스화만 일어남. 먼저 인스턴스화를 한 후 인스턴스화를 했을 경우 주소를 항당 받으므로 객체가 null이 아니면 주소를 넣어주고 만약 미리 인스턴스화로인해 주소가 할당된 상태라면 전에 인스턴스화를 했떤 주소를 반환하므로써 한개의 인스턴스화만 가능하게 하는 거임
		if(dbMgr1 == dbMgr2) {
			System.out.println("ture");
		}else {
			System.out.println("false");
		}
	}
}
