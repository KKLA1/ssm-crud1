package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.bean.EmployeeExample.Criteria;
import com.atguigu.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 查询所有员工信息
	 * 
	 * @return
	 */
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工保存方法
	 * 
	 * @param employee
	 */
	public void saveEmp(Employee employee) {

		employeeMapper.insertSelective(employee);
	}

	/**
	 * 校验员工姓名是否重复
	 * 
	 * @param empName
	 */
	public boolean checkRepeat(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long conut = employeeMapper.countByExample(example);

		return conut == 0;
	}

	/**
	 * 根据员工id查询员工信息
	 * 
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 * 根据员工id更新员工信息
	 * 
	 * @param emp
	 * @return
	 */
	public void updateEmp(Employee emp) {
		employeeMapper.updateByPrimaryKeySelective(emp);
	}

	/**
	 * 根据员工id删除员工信息
	 * 
	 * @param id
	 */
	public void deleteSingleEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	/**
	 * 批量删除
	 * 
	 * @param idList
	 */
	public void deleteBatch(List<Integer> idList) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(idList);
		employeeMapper.deleteByExample(example);
	}

}
