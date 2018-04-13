package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

/**
 * 
 * @author Admin 测试departmentMapper
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class DeptMentMapperTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;

	@Test
	public void deptMtest() {

		ApplicationContext ioc = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
		DepartmentMapper departmentMapper = ioc.getBean(DepartmentMapper.class);
		System.out.println(departmentMapper);

		// 1 测试部门插入数据方法

		departmentMapper.insertSelective(new Department(null, "开发部"));
		departmentMapper.insertSelective(new Department(1, "测试部"));
		departmentMapper.insertSelective(new Department(2, "框架部"));
		departmentMapper.insertSelective(new Department(3, "研发部"));
		departmentMapper.insertSelective(new Department(4, "产品部"));
		departmentMapper.insertSelective(new Department(5, "销售部"));
		departmentMapper.insertSelective(new Department(6, "经管部"));
		departmentMapper.insertSelective(new Department(7, "市场调研部"));

		// 2.员工插入

		employeeMapper.insertSelective(new Employee(1, "Locy", "M", "Locy@atguigu.com", 1));
		employeeMapper.insertSelective(new Employee(2, "Tom", "M", "Tom@atguigu.com", 2));
		employeeMapper.insertSelective(new Employee(3, "Tony", "M", "Tony@atguigu.com", 3));
		employeeMapper.insertSelective(new Employee(4, "lily", "F", "lily@atguigu.com", 4));
		employeeMapper.insertSelective(new Employee(5, "weigy", "F", "weigy@atguigu.com", 5));
		employeeMapper.insertSelective(new Employee(6, "matiy", "F", "matiy@atguigu.com", 6));
		employeeMapper.insertSelective(new Employee(7, "李卫海", "M", "weihai.li@atguigu.com", 7));

		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 10; i++) {
			String uuid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Employee(null, uuid, "M", uuid + ".li@atguigu.com", 25));
		}

	}

}
