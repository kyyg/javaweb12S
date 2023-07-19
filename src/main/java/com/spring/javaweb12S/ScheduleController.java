package com.spring.javaweb12S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb12S.service.AdminService;
import com.spring.javaweb12S.service.DbShopService;
import com.spring.javaweb12S.service.ScheduleService;
import com.spring.javaweb12S.vo.EventVO;
import com.spring.javaweb12S.vo.ScheduleVO;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	ScheduleService scheduleService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	DbShopService dbShopService;
	
	@RequestMapping(value = "/schedule", method=RequestMethod.GET)
	public String scheduleGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		scheduleService.getSchedule();
		List<EventVO> vos = adminService.getEventList(mid);
		model.addAttribute("vos", vos);
		return "schedule/schedule";
	}
	
	// 일일출석 이벤트 체크하기
	@ResponseBody
	@RequestMapping(value = "/eventToday", method = RequestMethod.POST)
	public String eventTodayPost(EventVO vo) {
		String ymd = vo.getYmd().toString();
		String yy = ymd.split("-")[0];
		String mm = ymd.split("-")[1];
		String dd = ymd.split("-")[2];
		if(mm.length() == 1) mm = "0" + mm;
		if(dd.length() == 1) dd = "0" + dd;
		ymd = yy + "-" + mm + "-" + dd;
		vo.setYmd(ymd);
		EventVO vo2 = adminService.getEventToday(vo);
		//System.out.println("vo2값 : " + vo2);
		if(vo2 != null) return "0";
		dbShopService.setEventInput(vo); // 이벤트 등록
		return "1";
	}
	
	
	@RequestMapping(value = "/scheduleMenu", method=RequestMethod.GET)
	public String scheduleMenuGet(HttpSession session, String ymd, Model model) {
		String mid = (String) session.getAttribute("sMid");
		List<ScheduleVO> vos = scheduleService.getScheduleMenu(mid, ymd);
		
		model.addAttribute("vos",vos);
		model.addAttribute("ymd", ymd);
		model.addAttribute("scheduleCnt", vos.size());

		return "schedule/scheduleMenu";
	}
	
	// 스케줄 등록하기
	@ResponseBody
	@RequestMapping(value = "/scheduleInputOk", method=RequestMethod.POST)
	public String scheduleInputOkPost(ScheduleVO vo) {
		scheduleService.setScheduleInputOk(vo);
		return "";
	}
	
	// 스케줄 수정하기
	@ResponseBody
	@RequestMapping(value = "/scheduleUpdateOk", method=RequestMethod.POST)
	public String scheduleUpdateOkPost(ScheduleVO vo) {
		scheduleService.setScheduleUpdateOk(vo);
		return "";
	}
	
	// 스케줄 삭제하기
	@ResponseBody
	@RequestMapping(value = "/scheduleDeleteOk", method=RequestMethod.POST)
	public String scheduleDeleteOkPost(int idx) {
		scheduleService.setScheduleDeleteOk(idx);
		return "";
	}
		
}
