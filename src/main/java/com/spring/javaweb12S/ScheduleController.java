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
import com.spring.javaweb12S.vo.PointSaveVO;
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

		scheduleService.getSchedule(); // 달력 변수들
		
		List<EventVO> vos = adminService.getEventList(mid);
		model.addAttribute("vos", vos);
		model.addAttribute("vosSize", vos.size());
		return "schedule/schedule";
	}
	
	// 일일출석 이벤트 체크하기, 20개 달성시 3000포인트 지급
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
		if(vo2 != null) return "0";
		
		dbShopService.setEventInput(vo); // 오늘날짜로 출석이벤트 등록
		
		// 이번달 db에 찍힌 도장 개수를 가져온다 
		int eventNum = dbShopService.getEventNum(vo.getMid());
		
		// 이번달 찍힌 도장의 개수가 20개 라면 이벤트 달성 포인트(3000)를 지급해 준다.
		// DBpoint테이블에는 이벤트 지급내역저장, member테이블의 point는 출석지급포인트 3000을 누적처리
		if(eventNum == 2) {
			String pointMemo = vo.getYmd().substring(0,7) + " 출석이벤트";
		  dbShopService.setGetPoint("이벤트", 3000, vo.getMid(), pointMemo); // 이벤트 포인트 현황 저장(이곳에서는 출석포인트 3000와 내역을 저장)
			dbShopService.setMemberPlusPoint(vo.getMid(), 3000); // 멤버 포인트 지급, 나중에 3000으로 고칠것
			return "2";
		}
		else return "1";
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
