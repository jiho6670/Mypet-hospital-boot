package com.boot.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.boot.dto.GroomingResDTO;
import com.boot.dto.MedicalResDTO;
import com.boot.dto.Mypet_AdminDTO;
import com.boot.dto.Mypet_NoticesDTO;
import com.boot.dto.Mypet_PetDTO;
import com.boot.dto.Mypet_Qna_BoardDTO;
import com.boot.dto.Mypet_UserDTO;
import com.boot.service.Mypet_Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequiredArgsConstructor
public class Mypet_Controller {
	
    private final Mypet_Service service;

	/* =============== [ 정적 JSP 이동 (HomeController) ] =============== */

	
	 @GetMapping("/")
	 public String home() {
	     return "mainpage";
	 }
	
	 @GetMapping("/login")
	 public String login() {
	     return "login";
	 }
	
	 @GetMapping("/register")
	 public String register() {
	     return "register";
	 }
	
	 @GetMapping("/mainpage")
	 public String mainpage() {
	     return "mainpage";
	 }
	
	 @GetMapping("/hospital_info")
	 public String hospital_info() {
	     return "hospital_info";
	 }
	
	 @GetMapping("/map")
	 public String map() {
	     return "map";
	 }
	
	 @GetMapping("/find_password")
	 public String find_password() {
	     return "find_password";
	 }
	
	 @GetMapping("/reset_password")
	 public String reset_password() {
	     return "reset_password";
	 }
	
	 @GetMapping("/reservation")
	 public String reservation() {
	     return "reservation";
	 }
	
	 @GetMapping("/grooming_appointment")
	 public String grooming_appointment() {
	     return "grooming_appointment";
	 }
	
	 @GetMapping("/medical_appointment")
	 public String medical_appointment() {
	     return "medical_appointment";
	 }
	
	 @GetMapping("/pet_add")
	 public String pet_add() {
	     return "pet_add";
	 }
	
	
	    
   
    /** ========================= [ 회원 기능 ] ========================= **/

    
    // 회원가입 처리
    @RequestMapping(value = "/registerProcess", method = RequestMethod.POST)
    public String registerProcess(MultipartHttpServletRequest request, RedirectAttributes redirectAttributes) {
        Mypet_UserDTO dto = new Mypet_UserDTO();

        dto.setUser_id(request.getParameter("user_id"));
        dto.setUser_pwd(request.getParameter("user_pwd"));
        dto.setUser_name(request.getParameter("user_name"));
        dto.setUser_gender(request.getParameter("user_gender"));

        String birthday = request.getParameter("user_birthday");
        if (birthday != null && !birthday.isEmpty()) {
            dto.setUser_birthday(Date.valueOf(birthday));
        }

        dto.setUser_phone(request.getParameter("user_phone"));
        dto.setUser_email(request.getParameter("user_email"));

        String addr = request.getParameter("user_addr");
        String addrDetail = request.getParameter("user_addr_detail");
        dto.setUser_addr((addr != null ? addr : "") + " " + (addrDetail != null ? addrDetail : ""));
        dto.setUser_status("ACTIVE");

        service.join(dto);
        log.info("회원가입 완료: {}", dto.getUser_id());

        redirectAttributes.addFlashAttribute("message", "회원가입이 완료되었습니다.");
        return "redirect:/login";
    }

    // 로그인 처리
    @RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
    public String loginProcess(HttpServletRequest request, HttpSession session, RedirectAttributes redirectAttributes) {
        String user_id = request.getParameter("user_id");
        String user_pwd = request.getParameter("user_pwd");

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("user_id", user_id);
        map.put("user_pwd", user_pwd);

        Object loginObj = service.login(map);

        if (loginObj instanceof Mypet_AdminDTO) {
            session.setAttribute("role", "ADMIN");
            session.setAttribute("loginAdmin", loginObj);
            log.info("관리자 로그인 성공: {}", user_id);
            return "mainpage";
        }

        if (loginObj instanceof Mypet_UserDTO) {
            Mypet_UserDTO user = (Mypet_UserDTO) loginObj;
            session.setAttribute("role", "USER");
            session.setAttribute("loginUser", user);
            log.info("일반 사용자 로그인 성공: {}", user_id);
            return "mainpage";
        }

        redirectAttributes.addFlashAttribute("message", "아이디 또는 비밀번호가 올바르지 않습니다.");
        return "redirect:/login";
    }

    // 로그아웃
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        log.info("로그아웃 완료");
        return "redirect:/login";
    }

    // 마이페이지 - 유저 정보 조회
    @RequestMapping("/mypage_userinfo")
    public String mypageUserInfo(HttpSession session, Model model) {
        Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        model.addAttribute("loginUser", loginUser);
        return "mypage_userinfo";
    }

    // 회원 정보 수정 (주현 세션보강 로직 통합)
    @PostMapping("/mypage_userinfo_edit_ok")
    public String mypageUserInfoEditOk(
            @RequestParam(value = "user_pwd", required = false) String user_pwd,
            @RequestParam(value = "user_pwd_confirm", required = false) String user_pwd_confirm,
            @RequestParam("user_phone") String user_phone,
            @RequestParam("user_email") String user_email,
            @RequestParam(value = "user_addr", required = false) String user_addr,
            @RequestParam(value = "user_addr_detail", required = false) String user_addr_detail,
            @RequestParam(value = "user_img", required = false) MultipartFile user_img,
            HttpSession session, RedirectAttributes ra) {

        Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            ra.addFlashAttribute("message", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("user_no", loginUser.getUser_no());
        map.put("user_phone", user_phone);
        map.put("user_email", user_email);
        map.put("user_addr", (user_addr != null ? user_addr : "") + " " + (user_addr_detail != null ? user_addr_detail : ""));

        if (user_pwd != null && !user_pwd.isEmpty()) {
            if (!user_pwd.equals(user_pwd_confirm)) {
                ra.addFlashAttribute("message", "비밀번호 확인이 일치하지 않습니다.");
                return "redirect:/mypage_userinfo_edit";
            }
            map.put("user_pwd", user_pwd);
        }

        try {
            service.updateUserInfo(map);
            // ✅ DB 기준 세션 갱신
            Mypet_UserDTO updatedUser = service.getUserByNo(loginUser.getUser_no());
            if (updatedUser != null) {
                session.setAttribute("loginUser", updatedUser);
            } else {
                // ⚙️ fallback: 기존 객체 수동 수정
                loginUser.setUser_phone(user_phone);
                loginUser.setUser_email(user_email);
                loginUser.setUser_addr(user_addr);
                if (user_pwd != null && !user_pwd.isEmpty()) {
                    loginUser.setUser_pwd(user_pwd);
                }
                session.setAttribute("loginUser", loginUser);
            }

            log.info("회원 정보 수정 완료: user_no={}", loginUser.getUser_no());
            ra.addFlashAttribute("message", "회원 정보가 성공적으로 수정되었습니다!");
        } catch (Exception e) {
            log.error("회원 정보 수정 중 오류 발생", e);
            ra.addFlashAttribute("message", "수정 중 오류 발생: " + e.getMessage());
        }

        return "redirect:/mypage_userinfo";
    }


    /** ========================= [ 펫 관련 기능 ] ========================= **/

    @RequestMapping(value = "/mypage_petinfo", method = RequestMethod.GET)
    public String mypagePetInfo(HttpServletRequest request, Model model, HttpSession session) {
        int pet_no = Integer.parseInt(request.getParameter("pet_no"));
        Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        Mypet_PetDTO petInfo = service.getPetInfo(loginUser.getUser_no(), pet_no);
        model.addAttribute("petInfo", petInfo);
        return "mypage_petinfo";
    }

    @PostMapping("/petjoinProcess")
    public String petjoinProcess(
            @RequestParam("pet_name") String petName,
            @RequestParam("pet_species") String petSpecies,
            @RequestParam("pet_breed") String petBreed,
            @RequestParam("pet_gender") String petGender,
            @RequestParam("pet_birthday") String petBirthdayStr,
            @RequestParam("pet_neutered") String petNeutered,
            @RequestParam(value = "pet_img", required = false) MultipartFile file,
            HttpSession session) {

        Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        Mypet_PetDTO petDTO = new Mypet_PetDTO();
        petDTO.setUser_no(loginUser.getUser_no());
        petDTO.setPet_name(petName);
        petDTO.setPet_species(petSpecies);
        petDTO.setPet_breed(petBreed);
        petDTO.setPet_gender(petGender);
        petDTO.setPet_neutered(petNeutered);

        try {
            if (petBirthdayStr != null && !petBirthdayStr.isEmpty()) {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date utilDate = format.parse(petBirthdayStr);
                petDTO.setPet_birthday(new java.sql.Date(utilDate.getTime()));
            }
        } catch (Exception e) {
            log.error("펫 생일 변환 오류", e);
            return "errorPage";
        }

        service.petjoin(petDTO);
        log.info("펫 등록 완료: {} (user_no={})", petName, loginUser.getUser_no());
        return "redirect:/mypage_petlist";
    }

    @RequestMapping("/mypage_petlist")
    public String mypagePetList(HttpSession session, Model model) {
    	log.info(" [Controller] /mypage_petlist 진입 성공");
    	
        Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        List<Mypet_PetDTO> petList = service.getPetsByUserNo(loginUser.getUser_no());
        model.addAttribute("petList", petList);

        // JSP에서 ${loginUser.xxx} 접근 가능하도록 추가
        model.addAttribute("loginUser", loginUser);

        // 세션의 user에도 펫 리스트를 동기화 (이후 다른 페이지에서도 바로 참조 가능)
        loginUser.setPets(petList);

        log.info("펫 목록 조회: {} (총 {}마리)", loginUser.getUser_id(), 
                 petList != null ? petList.size() : 0);
        return "mypage_petlist";
    }


    @RequestMapping(value = "/mypage_petinfo_edit", method = RequestMethod.GET)
    public String mypagePetInfoEdit(@RequestParam("pet_no") int pet_no, HttpSession session, Model model) {
        Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        Mypet_PetDTO petInfo = service.getPetInfo(loginUser.getUser_no(), pet_no);
        if (petInfo == null) return "redirect:/mypage_petlist";

        model.addAttribute("petInfo", petInfo);
        return "mypage_petinfo_edit";
    }

    @PostMapping("/mypage_petinfo_edit_ok")
    public String mypagePetInfoEditOk(
            @RequestParam("pet_no") int pet_no,
            @RequestParam("pet_name") String pet_name,
            @RequestParam("pet_age") int pet_age,
            @RequestParam("pet_birthday") String pet_birthday,
            @RequestParam("pet_gender") String pet_gender,
            @RequestParam("pet_species") String pet_species,
            @RequestParam("pet_breed") String pet_breed,
            HttpSession session, RedirectAttributes ra) {

        Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("user_no", loginUser.getUser_no());
        map.put("pet_no", pet_no);
        map.put("pet_name", pet_name);
        map.put("pet_age", pet_age);
        map.put("pet_birthday", pet_birthday);
        map.put("pet_gender", pet_gender);
        map.put("pet_species", pet_species);
        map.put("pet_breed", pet_breed);

        try {
            service.updatePetInfo(map);
            log.info("펫 정보 수정 완료: {} (user_no={})", pet_name, loginUser.getUser_no());
        } catch (Exception e) {
            log.error("펫 정보 수정 중 오류 발생", e);
            ra.addFlashAttribute("message", "수정 중 오류 발생: " + e.getMessage());
            return "redirect:/mypage_petinfo_edit?pet_no=" + pet_no;
        }

        ra.addFlashAttribute("message", "펫 정보가 성공적으로 수정되었습니다!");
        return "redirect:/mypage_petinfo?pet_no=" + pet_no;
    }


    /** ========================= [ 공지사항 기능 ] ========================= **/


    @RequestMapping(value = "/notices_write_view", method = RequestMethod.GET)
    public String noticesWriteView(HttpSession session, RedirectAttributes ra) {
        if (session.getAttribute("loginAdmin") == null) {
            ra.addFlashAttribute("message", "관리자만 작성할 수 있습니다.");
            return "redirect:/notices_list";
        }
        return "notices_write_view";
    }

    @RequestMapping(value = "/notices_write", method = RequestMethod.POST)
    public String noticesWrite(Mypet_NoticesDTO dto, HttpSession session, RedirectAttributes ra) {
        Mypet_AdminDTO admin = (Mypet_AdminDTO) session.getAttribute("loginAdmin");
        if (admin == null) {
            ra.addFlashAttribute("message", "관리자만 작성할 수 있습니다.");
            return "redirect:/notices_list";
        }
        dto.setAdmin_no(admin.getAdmin_no());
        service.writeNotice(dto);
        log.info("공지사항 등록 완료: {}", dto.getNotice_title());
        return "redirect:/notices_list";
    }

    @RequestMapping(value = "/notices_modify_view", method = RequestMethod.GET)
    public String noticesModifyView(int notice_no, HttpSession session, Model model, RedirectAttributes ra) {
        if (session.getAttribute("loginAdmin") == null) {
            ra.addFlashAttribute("message", "관리자만 수정할 수 있습니다.");
            return "redirect:/notices_list";
        }
        model.addAttribute("dto", service.getNoticeDetail(notice_no));
        return "notices_modify";
    }

    @RequestMapping(value = "/notices_modify", method = RequestMethod.POST)
    public String noticesModify(Mypet_NoticesDTO dto, HttpSession session, RedirectAttributes ra) {
        if (session.getAttribute("loginAdmin") == null) {
            ra.addFlashAttribute("message", "관리자만 수정할 수 있습니다.");
            return "redirect:/notices_list";
        }
        service.modifyNotice(dto);
        log.info("공지사항 수정 완료: {}", dto.getNotice_title());
        return "redirect:/notices_list";
    }

    @RequestMapping(value = "/notices_delete", method = RequestMethod.POST)
    public String noticesDelete(int notice_no, HttpSession session, RedirectAttributes ra) {
        if (session.getAttribute("loginAdmin") == null) {
            ra.addFlashAttribute("message", "관리자만 삭제할 수 있습니다.");
            return "redirect:/notices_list";
        }
        service.deleteNotice(notice_no);
        log.info("공지사항 삭제 완료: notice_no={}", notice_no);
        return "redirect:/notices_list";
    }
    
    
    @RequestMapping(value = "/notices_list", method = RequestMethod.GET)
    public String noticesList(Model model, 
                              @RequestParam(value = "page", defaultValue = "1") int currentPage) {

        int pageSize = 10; // 한 페이지 게시글 수
        int start = (currentPage - 1) * pageSize + 1;
        int end = currentPage * pageSize;

        HashMap<String, Object> map = new HashMap<>();
        map.put("start", start);
        map.put("end", end);

        List<Mypet_NoticesDTO> notices = service.list(map);
        int totalCount = service.getTotalCount();

        // 전체 페이지 수
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);

        // JSP에 전달
        model.addAttribute("notices", notices);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPage", totalPage);

//    log.info("📋 공지사항 {}건 중 {}~{} 불러오기 완료", totalCount, start, end);
        return "notices_list";
    }
    
    /** ========================= [ 공지사항 상세보기 기능 ] ========================= **/
    @RequestMapping(value = "/notices_view", method = RequestMethod.GET)
    public String noticesView(@RequestParam("notice_no") int notice_no, Model model) {
        // 서비스에서 공지사항 상세 데이터 가져오기
        Mypet_NoticesDTO dto = service.getNoticeDetail(notice_no);
        
        if (dto == null) {
            model.addAttribute("message", "해당 공지사항을 찾을 수 없습니다.");
            return "errorPage"; // 필요하면 error.jsp로 리다이렉트 가능
        }

//        // HTML 태그 제거 (예: <p>, <br>, <b> 등)
//        if (dto.getNotice_content() != null) {
//            String plainText = dto.getNotice_content().replaceAll("<[^>]*>", "");
//            dto.setNotice_content(plainText);
//        }

        // JSP에서 ${dto.xxx}로 접근 가능
        model.addAttribute("dto", dto);
        log.info("공지사항 상세 조회 완료: {}", dto.getNotice_title());
        log.info("공지사항 내용(태그 제거 후): {}", dto.getNotice_content());
        
        // JSP 파일 이름 (정확히 notices_content_view.jsp)
        return "notices_content_view";
    }
    
    




    /** ========================= [ 비밀번호 찾기 기능 ] ========================= **/

    @RequestMapping(value = "/findPasswordProcess", method = RequestMethod.POST)
    public String findPasswordProcess(HttpServletRequest request, Model model, RedirectAttributes rttr) {
        String user_id = request.getParameter("user_id");
        String user_name = request.getParameter("user_name");
        String user_email = request.getParameter("user_email");

        HashMap<String, String> map = new HashMap<String, String>();
        map.put("user_id", user_id);
        map.put("user_name", user_name);
        map.put("user_email", user_email);

        if (service.checkUserExists(map)) {
            model.addAttribute("user_id", user_id);
            return "reset_password";
        } else {
            rttr.addFlashAttribute("error", "일치하는 회원 정보가 없습니다.");
            return "redirect:/findPassword";
        }
    }

    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    public String updatePassword(HttpServletRequest request, RedirectAttributes rttr) {
        String user_id = request.getParameter("user_id");
        String user_pwd = request.getParameter("user_pwd");

        HashMap<String, String> map = new HashMap<String, String>();
        map.put("user_id", user_id);
        map.put("user_pwd", user_pwd);

        if (service.updatePassword(map)) {
            rttr.addFlashAttribute("success", "비밀번호가 성공적으로 변경되었습니다.");
            log.info("비밀번호 변경 완료: {}", user_id);
            return "redirect:/login";
        } else {
            rttr.addFlashAttribute("error", "비밀번호 변경 중 오류가 발생했습니다.");
            return "redirect:/findPassword";
        }
    }
   
 

    /**
     * 역할: 폼 데이터로 예약을 조회하고 '결과' 페이지를 보여줌 (POST)
    /** ========================= [ 미용 예약 기능 ] ========================= **/
    @GetMapping("/reservation_pet_grooming_check")
    public String showGroomingCheckPage() {
        return "reservation_pet_grooming_check";
    }
    @PostMapping("/reservation_pet_grooming_reference")
    public String handleGroomingReference(
            @RequestParam("userName") String userName,
            @RequestParam("phone1") String phone1,
            @RequestParam("phone2") String phone2,
            @RequestParam("phone3") String phone3,
            Model model
    ) {
    	String fullPhoneNumber = phone1 + "-" + phone2 + "-" + phone3;
        log.info("미용 예약 조회 요청: 보호자={}, 연락처={}", userName, fullPhoneNumber);
        
        HashMap<String, String> map = new HashMap<>();
        
        map.put("userName", userName);
        map.put("userPhone", fullPhoneNumber);
        
        List<GroomingResDTO> reservationList = service.findGroomingReservations(map);
        
        log.info(">>>>>> 서비스 조회 결과: 총 {} 건의 예약이 발견되었습니다.", reservationList.size());
        
        if (reservationList != null && !reservationList.isEmpty()) {
            model.addAttribute("reservationList", reservationList);
        } else {
            model.addAttribute("errorMessage", "일치하는 예약 내역이 없습니다.");
        }

        return "reservation_pet_grooming_reference";
    }
    @GetMapping("/reservation_pet_grooming")
    public String showGroomingForm(HttpSession session, Model model) {
        Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        // 사용자의 펫 목록을 가져와 폼에 전달 (선택 기능용)
        List<Mypet_PetDTO> petList = service.getPetsByUserNo(loginUser.getUser_no());
        model.addAttribute("petList", petList);
        return "reservation_pet_grooming";
    }
    @PostMapping("/reservation/grooming/create")
    public String createGroomingReservation(
    		// 1. Spring이 폼 데이터를 자동으로 DTO에 담아줍니다.
    		GroomingResDTO dto, 
    		
    		// 2. 여러 개로 나뉜 연락처는 따로 받습니다.
    		@RequestParam("phone2") String phone2,
    		@RequestParam("phone3") String phone3,
    		
    		HttpSession session, 
    		RedirectAttributes rttr
    		) {
    	log.info("미용 예약 처리 시작...");
    	Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
    	if (loginUser == null) {
    		return "redirect:/login";
    	}
    	
    	// 3. DTO에 로그인 정보와 조합된 연락처를 추가합니다.
    	dto.setUser_no(loginUser.getUser_no());
    	dto.setUser_phone("010-" + phone2 + "-" + phone3);
    	
    	Mypet_PetDTO selectedPet = service.getPetByNo(dto.getPet_no());
    	
    	// 2. 조회된 펫의 이름을 예약 DTO(GroomingResDTO)에 채워 넣습니다.
    	if (selectedPet != null) {
    		dto.setPet_name(selectedPet.getPet_name());
    	}
    	
    	// 4. 서비스를 호출하여 DB에 저장합니다.
    	service.createGroomingReservation(dto);
    	
    	// 5. 성공 메시지와 함께 '예약 조회' 페이지로 리다이렉트합니다.
    	rttr.addFlashAttribute("successMessage", "예약이 성공적으로 접수되었습니다.");
    	return "redirect:/reservation_pet_grooming_check";
    }

    /**
     * ✨ 역할: 진료 예약 '하기' 폼 데이터를 받아 DB에 저장 (POST)
     * - 이 메소드로 모든 예약 처리 로직을 통합합니다.
     */
    /** ========================= [ 진료 예약 기능 ] ========================= **/
    /**
     * 역할: 폼 데이터로 예약을 조회하고 '결과' 페이지를 보여줌 (POST)**/
    @GetMapping("/reservation_pet_medical_check")
    public String showMedicalCheckPage() {
    	return "reservation_pet_medical_check";
    }
  
    @PostMapping("/reservation_pet_medical_reference")
    public String handleMedicalReference(
    		@RequestParam("userName") String userName,
    		@RequestParam("phone1") String phone1,
    		@RequestParam("phone2") String phone2,
    		@RequestParam("phone3") String phone3,
    		Model model
    		) {
    	String fullPhoneNumber = phone1 + "-" + phone2 + "-" + phone3;
    	log.info("진료 예약 조회 요청: 보호자={}, 연락처={}", userName, fullPhoneNumber);
    	
    	HashMap<String, String> map = new HashMap<>();
    	
    	map.put("userName", userName);
    	map.put("userPhone", fullPhoneNumber);
    	
    	List<MedicalResDTO> reservationList = service.findMedicalReservations(map);
    	
    	log.info(">>>>>> 서비스 조회 결과: 총 {} 건의 예약이 발견되었습니다.", reservationList.size());
    	
    	if (reservationList != null && !reservationList.isEmpty()) {
    		model.addAttribute("reservationList", reservationList);
    	} else {
    		model.addAttribute("errorMessage", "일치하는 예약 내역이 없습니다.");
    	}
    	
    	return "reservation_pet_medical_reference";
    }
    @GetMapping("/reservation_pet_medical")
    public String showMedicalForm(HttpSession session, Model model) {
    	Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
    	if (loginUser == null) {
    		return "redirect:/login";
    	}
    	// 사용자의 펫 목록을 가져와 폼에 전달 (선택 기능용)
    	List<Mypet_PetDTO> petList = service.getPetsByUserNo(loginUser.getUser_no());
    	model.addAttribute("petList", petList);
    	return "reservation_pet_medical";
    }
    
    /**
     * ✨ 역할: 진료 예약 '하기' 폼 데이터를 받아 DB에 저장 (POST)
     * - 이 메소드로 모든 예약 처리 로직을 통합합니다.
     */
    @PostMapping("/reservation/medical/create")
    public String createMedicalReservation(
    		// 1. Spring이 폼 데이터를 자동으로 DTO에 담아줍니다.
    		MedicalResDTO dto, 
    		
    		// 2. 여러 개로 나뉜 연락처는 따로 받습니다.
    		@RequestParam("phone2") String phone2,
    		@RequestParam("phone3") String phone3,
    		
    		HttpSession session, 
    		RedirectAttributes rttr
    		) {
    	log.info("진료 예약 처리 시작...");
    	Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
    	if (loginUser == null) {
    		return "redirect:/login";
    	}
    	
    	// 3. DTO에 로그인 정보와 조합된 연락처를 추가합니다.
    	dto.setUser_no(loginUser.getUser_no());
    	dto.setUser_phone("010-" + phone2 + "-" + phone3);
    	
    	Mypet_PetDTO selectedPet = service.getPetByNo(dto.getPet_no());
    	

    	if (selectedPet != null) {
    		dto.setPet_name(selectedPet.getPet_name());
    	}
    	
    	// 4. 서비스를 호출하여 DB에 저장합니다.
    	service.createMedicalReservation(dto);
    	
    	// 5. 성공 메시지와 함께 '예약 조회' 페이지로 리다이렉트합니다.
    	rttr.addFlashAttribute("successMessage", "예약이 성공적으로 접수되었습니다.");
    	return "redirect:/reservation_pet_medical_check";
    }
    
    // Q&A 목록 페이지
	@RequestMapping(value = "/qna_page", method = RequestMethod.GET)
	public String qnaPage(Model model, @RequestParam(value = "page", defaultValue = "1") int currentPage) {
		
		int pageSize = 10; // 한 페이지 게시글 수
        int start = (currentPage - 1) * pageSize + 1;
        int end = currentPage * pageSize;

        HashMap<String, Object> map = new HashMap<>();
        map.put("start", start);
        map.put("end", end);
        
        List<Mypet_Qna_BoardDTO> qnaList = service.list2(map);

//        List<Mypet_Qna_BoardDTO> qnaList = service.getQnaList();
	    model.addAttribute("dd", qnaList);    
	    log.info("[Controller] Q&A 목록 불러오기 완료 ({}건)", qnaList.size());
	    
        int totalCount = service.getTotalCount();

        // 전체 페이지 수
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);
        
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPage", totalPage);

        return "qna_page";
	}
   
    // Q&A 작성 페이지 이동
    @RequestMapping("/qna_write")
    public String qnaWrite(HttpSession session) {
        Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        return "qna_write";
    }
   
    // Q&A 등록 처리
    @PostMapping("/qna_write_ok")
    public String qnaWriteOk(Mypet_Qna_BoardDTO dto, HttpSession session, RedirectAttributes ra) {
        Mypet_UserDTO loginUser = (Mypet_UserDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
   
        dto.setUser_no(loginUser.getUser_no());
        log.info("[Controller] Q&A 등록 요청 수신: {}", dto);
        service.writeQna(dto);
   
        ra.addFlashAttribute("message", "문의가 등록되었습니다!");
        return "redirect:/qna_page";
    }

}
