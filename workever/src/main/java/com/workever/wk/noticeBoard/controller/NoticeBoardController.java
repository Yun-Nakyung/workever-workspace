package com.workever.wk.noticeBoard.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.workever.wk.common.model.vo.PageInfo;
import com.workever.wk.common.template.Pagination;
import com.workever.wk.community.model.vo.CommunityFiles;
import com.workever.wk.community.template.SaveCommunityFiles;
import com.workever.wk.noticeBoard.model.service.NoticeBoardService;
import com.workever.wk.noticeBoard.model.vo.NoticeBoard;

@Controller
public class NoticeBoardController {
	
	@Autowired
	private NoticeBoardService nService;
	
	/** 공지사항 게시글 목록 조회(최신순||오래된순 / 페이징 처리) 후 공지사항 게시글 목록 페이지 포워딩
	 * @param currentPage : 사용자가 요청한 페이지 수
	 * @param orderList : 사용자가 요청한 게시글 목록 정렬용 키워드 asc(오래된순)
	 * @param mv
	 * @return
	 */
	@RequestMapping("list.nbo" )
	public ModelAndView selectNoticeBoardList(@RequestParam(value="cpage", defaultValue="1") int currentPage, String orderList, ModelAndView mv) {
		
		int listCount = nService.selectListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		
		if(orderList != null) { // 오래된순
			
			ArrayList<NoticeBoard> list = nService.selectAscList(pi);
			
			mv.addObject("list", list)
			.addObject("pi", pi)
			.addObject("orderList", orderList)
			.setViewName("noticeBoard/noticeBoardListView");
			
			return mv;
			
		} else { // 최신순(기본)
			
			ArrayList<NoticeBoard> list = nService.selectNoticeBoardList(pi);
		
			mv.addObject("list", list)
			.addObject("pi", pi)
			.setViewName("noticeBoard/noticeBoardListView");
			
			return mv;
			
		}
		
	}
	
	
	/** 공지사항 게시글 검색 목록 조회(최신순||오래된순 / 페이징 처리) 후 공지사항 게시글 목록 페이지 포워딩
	 * @param currentPage : 사용자가 요청한 검색 목록 페이지 수
	 * @param orderList : 사용자가 요청한 검색 목록 정렬용 키워드 asc(오래된순)
	 * @param condition : 사용자가 요청한 검색 조건
	 * @param keyword : 사용자가 요청한 검색 키워드
	 * @param mv
	 * @return
	 */
	@RequestMapping("search.nbo" )
	public ModelAndView selectSearchList(@RequestParam(value="cpage", defaultValue="1") int currentPage,
			String orderList, String condition, String keyword, ModelAndView mv) {
		
		HashMap<String, String> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		int listCount = nService.selectSearchCount(map);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		
		if(orderList != null) { // 오래된순
			
			ArrayList<NoticeBoard> list = nService.selectSearchAscList(map, pi);
			
			mv.addObject("list", list)
			.addObject("pi", pi)
			.addObject("orderList", orderList)
			.addObject("condition", condition)
			.addObject("keyword", keyword)
			.setViewName("noticeBoard/noticeBoardListView");
			
			return mv;
			
		} else { // 최신순(기본)
			
			ArrayList<NoticeBoard> list = nService.selectSearchList(map, pi);
		
			mv.addObject("list", list)
			.addObject("pi", pi)
			.addObject("condition", condition)
			.addObject("keyword", keyword)
			.setViewName("noticeBoard/noticeBoardListView");
			
			return mv;
			
		}
		
	}
	
	/** 공지사항 게시글 상세 조회 후 공지사항 게시글 상세 페이지 포워딩
	 * @param nbno : 공지사항 게시글 번호
	 * @param mv
	 * @return
	 */
	@RequestMapping("detail.nbo")
	public ModelAndView selectNoticeBoard(int nbno, ModelAndView mv) {
		
		int result = nService.increaseCount(nbno); // 조회수 증가
		
		if(result > 0) { // 유효한 게시글
			
			NoticeBoard nb = nService.selectNoticeBoard(nbno); // 게시글 상세 조회
			
			ArrayList<CommunityFiles> list = nService.selectCommunityFilesList(nbno); // 첨부파일 조회
			
			mv.addObject("nb", nb)
			  .addObject("list", list)
			  .setViewName("noticeBoard/noticeBoardDetailView");
			
			return mv;
		
		} else { // 유효하지 않은 게시글
			
			mv.addObject("errorMsg", "유효하지 않은 게시글 입니다")
			  .setViewName("common/errorPage");
			
			return mv;
			
		}
			
	}
	
	/** 공지사항 게시글 작성 페이지 포워딩
	 * @return
	 */
	@RequestMapping("enrollForm.nbo")
	public String noticeBoardForm() {
		
		return "noticeBoard/noticeBoardEnrollForm";
		
	}
	
	@RequestMapping("insert.nbo")
	public String insertNoticeBoard(NoticeBoard nb, MultipartFile[] upfile, HttpSession session, Model m) {
					
		ArrayList<CommunityFiles> list = new ArrayList<>();
		
		if(upfile != null) { // 첨부파일이 존재할 경우
			
			String savePath = "resources/community_upfiles/noticeBoard_upfiles/";
			
			for(int i=0; i<upfile.length; i++) {
				
				String changeName = SaveCommunityFiles.saveFile(upfile[i], session, savePath);
				
				CommunityFiles cf = new CommunityFiles();
				cf.setCfOriginName(upfile[i].getOriginalFilename());
				cf.setCfChangeName(changeName);
				cf.setCfPath(savePath);
				
				list.add(cf);
				
			}
			
		}
		
		System.out.println(list);
		
		int result = nService.insertNoticeBoard(nb, list);
		
		if(result > 0) {
			
			session.setAttribute("successMsg", "성공적으로 공지사항 게시글이 등록되었습니다");
			return "redirect:list.nbo";
			
		} else {
			
			if(!list.isEmpty()) { // 첨부파일 있는 경우
				
				for(CommunityFiles file : list) {
					
					new File(file.getCfPath() + file.getCfChangeName()).delete();
					// 삭제 시키고자하는 파일을 찾아서 File 객체에 담아서 삭제		
				
				}
				
			}
			
			m.addAttribute("errorMsg", "공지사항 게시글 등록 실패");
			return "common/errorPage";
			
		}
		
	}
	
	
}
