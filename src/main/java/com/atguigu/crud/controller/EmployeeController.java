package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 对员工信息的增删改查
 * 
 * @author Admin
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	/**
	 * 删除员工信息
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteSingleEmp(@PathVariable("ids") String ids) {
		// 判断当前删除是批量删除还是单个删除
		if (ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			for (String str : str_ids) {
				del_ids.add(Integer.parseInt(str));
			}
			employeeService.deleteBatch(del_ids);
		} else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteSingleEmp(id);
		}

		return Msg.success();
	}

	/**
	 * 更新员工信息 tomcat不支持post的请求，默认的请求方式是post请求
	 * ，若想使用put请求，则需要配置HttpPutFormContentFilter 如果是post请求。tomcat会将请求体中的数据封装成map
	 * 在需要时通过request。getParamter（“”）获取，
	 * 
	 * 
	 * @param emp
	 * @return
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee emp) {
		employeeService.updateEmp(emp);
		return Msg.success();
	}

	/**
	 * 根据员工id查询员工信息
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}

	/**
	 * 检查用户名是否可用
	 * 
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkemp")
	@ResponseBody
	public Msg checkEmpRepeat(@RequestParam("empName") String empName) {
		// 后端校验用户名是否满足指定长度限制
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,8})";
		if (!empName.matches(regx)) {
			return Msg.fail().add("vaMsg", "用户名可以是2到8个中文汉字或6到16个英文字母和数字的组合组成(后端校验)");
		}

		// 用户名数据库校验
		boolean b = employeeService.checkRepeat(empName);
		if (b) {
			return Msg.success();
		} else {
			return Msg.fail().add("vaMsg", "用户名不可用（数据库校验）");
		}
	}

	/**
	 * @return Msg 新增员工
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			// 校验失败 ，在模态框中显示校验失败信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("异常字段名" + fieldError.getField());
				System.out.println("异常字段名" + fieldError.getField() + ",异常信息" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());

			}
			return Msg.fail().add("erroeField", map);
		} else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}

	/*
	 * @ResponseBody可以将返回的数据封装成json对象返回给浏览器 能让此注解正常工作 ，需要引入jackson.jar
	 * 
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		PageHelper.startPage(pn, 5);
		List emps = employeeService.getAll();

		// 用PageInfo对结果进行包装 包含了所有的分页信息 连续显示的页数
		PageInfo page = new PageInfo(emps, 5);

		return Msg.success().add("pageInfo", page);
	}

	/*
	 * 查询员工数据
	 */
	// @RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		PageHelper.startPage(pn, 5);
		List emps = employeeService.getAll();

		// 用PageInfo对结果进行包装 包含了所有的分页信息 连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);

		return "list";
	}

}
