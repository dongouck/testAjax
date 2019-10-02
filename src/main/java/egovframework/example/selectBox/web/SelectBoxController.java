package egovframework.example.selectBox.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.selectBox.service.SelectBoxService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class SelectBoxController {

	@Resource
	private SelectBoxService selectBoxService;
	
	@RequestMapping(value = "/selectBox.do")
	public String selectBoxMain(ModelMap model) throws Exception {
		List<EgovMap> parentList = selectBoxService.selectParentBoxList();
		
		model.addAttribute("parentList", parentList);
		
		System.out.println(parentList);
		
		return "selectBox/selectBox.tiles";
	}
	@RequestMapping(value="/selectChildBox.do")
	public void selectChildBoxInit(@RequestParam String param, HttpServletResponse response)throws Exception{
		
		System.out.println("ajx param : "+param);
		List<EgovMap> childList=selectBoxService.selectChildBoxList(param);
		
		HashMap<String, Object> resultMap= new HashMap<String, Object>();
		
		resultMap.put("result", "success");
		resultMap.put("childList", childList);
		System.out.println(resultMap);
		String hashMaptoJson=JsonUtil.MapToJson(resultMap);
		System.out.println(hashMaptoJson);
		
		response.setCharacterEncoding("UTF-8");
		PrintWriter out= response.getWriter();
		out.write(hashMaptoJson);
		
		//response.setCharacterEncoding("utf-8");
		//PrintWriter out= response.getWriter();
	}
	
}
