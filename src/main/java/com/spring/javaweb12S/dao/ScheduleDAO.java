package com.spring.javaweb12S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb12S.vo.EventVO;
import com.spring.javaweb12S.vo.ScheduleVO;

public interface ScheduleDAO {

	public List<ScheduleVO> getScheduleList(@Param("mid") String mid, @Param("ym") String ym);

	public List<ScheduleVO> getScheduleMenu(@Param("mid") String mid, @Param("ymd") String ymd);

	public void setScheduleInputOk(@Param("vo") ScheduleVO vo);

	public void setScheduleUpdateOk(@Param("vo") ScheduleVO vo);

	public void setScheduleDeleteOk(@Param("vo") ScheduleVO vo);

	public void setScheduleDeleteOk(@Param("idx") int idx);

	public List<EventVO> getEventList(@Param("mid") String mid);


}
